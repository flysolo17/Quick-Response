package com.quickresponse.plugins

import com.quickresponse.repository.attendance.AttendanceRepository
import com.quickresponse.repository.attendee.AttendeeRepository
import com.quickresponse.repository.subject.SubjectRepository
import com.quickresponse.repository.user.UserRepository
import com.quickresponse.route.attendanceRoute
import com.quickresponse.route.attendeesRoute
import com.quickresponse.route.authRoute
import com.quickresponse.route.subjectRoute
import com.quickresponse.security.hash.HashingService
import com.quickresponse.security.token.TokenConfig
import com.quickresponse.security.token.TokenService
import io.ktor.server.routing.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.request.*

fun Application.configureRouting(userRepository: UserRepository,
                                 hashingService: HashingService,
                                 tokenService : TokenService,
                                 tokenConfig : TokenConfig,
                                 subjectRepository: SubjectRepository,
                                 attendanceRepository: AttendanceRepository,
                                    attendeesRepository: AttendeeRepository) {
    routing {
        authRoute(userRepository,hashingService,tokenService,tokenConfig)
        subjectRoute(subjectRepository)
        attendanceRoute(attendanceRepository)
        attendeesRoute(attendeesRepository)
        get("/hello") {
            call.respond(HttpStatusCode.OK,"hello")
        }
    }
}

