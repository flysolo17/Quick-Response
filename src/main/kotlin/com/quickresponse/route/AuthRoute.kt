package com.quickresponse.route

import com.quickresponse.data.request.LoginRequest
import com.quickresponse.data.request.SignUpRequest
import com.quickresponse.data.request.UpdateUserRequest
import com.quickresponse.entities.UserEntity
import com.quickresponse.models.User
import com.quickresponse.repository.user.UserRepository
import com.quickresponse.security.hash.HashingService
import com.quickresponse.security.hash.SaltedHash
import com.quickresponse.security.token.TokenClaim
import com.quickresponse.security.token.TokenConfig
import com.quickresponse.security.token.TokenService
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.authRoute(userRepository: UserRepository,hashingService: HashingService,tokenService: TokenService,tokenConfig: TokenConfig) {
    route("/auth") {
        post("/signup") {
            val request = kotlin.runCatching { call.receiveNullable<SignUpRequest>() }.getOrNull() ?: kotlin.run {
                call.respond(HttpStatusCode.BadRequest,"Invalid request")
                return@post
            }
            if (userRepository.getUserByIdNumber(request.idNumber) != null) {
                call.respond(HttpStatusCode.Conflict,"ID number already exists!")
            } else {
                val result = userRepository.insertUser(request)
                if (!result) call.respond(HttpStatusCode.Conflict,"Invalid request")
                call.respond(HttpStatusCode.OK,"Successfully Added!")
            }
        }

        post("/login") {
            val request = call.receive<LoginRequest>()
            val user = userRepository.getUserByIdNumber(request.idNumber)
            if (user == null) {
                call.respond(HttpStatusCode.Conflict,"Invalid email or password")
                return@post
            }
            val isValidPassword = hashingService.verify(
                value = request.password,
                saltedHash = SaltedHash(
                    hash = user.password,
                    salt = user.salt
                )
            )
            if (!isValidPassword) {
                call.respond(HttpStatusCode.Conflict,"Invalid password")
                return@post
            }
            val token = tokenService.generate(
                config = tokenConfig,
                TokenClaim(
                    name = "userID",
                    value = user.id.toString()
                )
            )
            call.respond(
                status = HttpStatusCode.OK,
                message = token)
        }
        authenticate {
            patch("{id}") {
                val id = call.parameters["id"] ?: return@patch  call.respond(HttpStatusCode.BadRequest, message = "No Id Attach")
                val request = kotlin.runCatching { call.receiveNullable<UpdateUserRequest>() }.getOrNull() ?: kotlin.run {
                    call.respond(HttpStatusCode.BadRequest,"Invalid Request")
                    return@patch
                }
                val user : UserEntity? = userRepository.getUserByIdNumber(request.idNumber)
                if (user != null && user.id != id.toInt()) {
                    call.respond(HttpStatusCode.Conflict,"This id number is exists!")
                } else {
                    val result = userRepository.updateProfile(id.toInt(),request)
                    if (!result) call.respond(HttpStatusCode.Conflict,"Failed to update profile")
                    call.respond(HttpStatusCode.OK,"Updated Successfully")
                }
            }
        }
        authenticate {
            get("secret") {
                val principal = call.principal<JWTPrincipal>()
                val userID = principal?.getClaim("userID",String::class)
                if (userID != null) {
                    val user = userRepository.getUserById(userID.toInt())
                    if (user != null) {
                        call.respond(HttpStatusCode.OK,user)
                    } else {
                        call.respond(HttpStatusCode.BadRequest,"User not found!")
                    }
                } else {
                    call.respond(HttpStatusCode.BadRequest,"No user Id")
                }
            }
        }
        authenticate {
            get("users") {
                call.respond(HttpStatusCode.OK,userRepository.getAllUser())
            }
        }
    }
}