package com.quickresponse.route

import com.quickresponse.data.request.GetAllSubjectRequest
import com.quickresponse.data.request.SubjectRequest
import com.quickresponse.data.request.UpdateSubjectRequest
import com.quickresponse.models.Subject
import com.quickresponse.repository.subject.SubjectRepository
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.subjectRoute(subjectRepository: SubjectRepository) {
    route("/subject") {
        authenticate {
            post("/create") {
                val request = kotlin.runCatching { call.receiveNullable<SubjectRequest>() }.getOrNull() ?:kotlin.run {
                    call.respond(HttpStatusCode.BadRequest,"Invalid Request")
                    return@post
                }
                val result = subjectRepository.createSubject(request)
                if (!result) {
                    call.respond(HttpStatusCode.BadRequest,"Create Subject Failed")
                }
                call.respond(HttpStatusCode.OK,"Subject Created Successfully")
            }
        }

        get("{userId?}") {
            val id = call.parameters["userId"] ?: return@get call.respond(HttpStatusCode.BadRequest)
            val result = subjectRepository.getAllSubject(id.toInt())!!
            if (result.isNotEmpty()) {
                call.respond(HttpStatusCode.OK,result)
            } else {
                call.respondText("No subject ", status = HttpStatusCode.OK)
            }
        }
        authenticate {
            delete("{id?}") {
                val id = call.parameters["id"] ?: return@delete call.respond(HttpStatusCode.BadRequest)
                val subject = subjectRepository.getSubjectByID(id.toInt())
                if (subject != null) {
                    val result = subjectRepository.deleteSubject(id.toInt())
                    if (result) {
                    call.respondText("Subject removed correctly", status = HttpStatusCode.Accepted)
                    } else {
                        call.respondText("Subject removal failed", status = HttpStatusCode.NotFound)
                    }
                } else {
                    call.respondText("not subject with id $id", status = HttpStatusCode.NotFound)
                }

            }
        }
        authenticate {
            patch("{id}") {
                val id = call.parameters["id"] ?: return@patch call.respond(HttpStatusCode.BadRequest, message = "No ID Attach")
                val request = kotlin.runCatching { call.receiveNullable<UpdateSubjectRequest>() }.getOrNull() ?:kotlin.run {
                    call.respond(HttpStatusCode.BadRequest,"Invalid Request")
                    return@patch
                }
                val result = subjectRepository.updateSubject(id.toInt(),request.name,request.desc)
                if (!result) {
                    call.respond(HttpStatusCode.BadRequest,"Update Subject Failed!")
                }
                call.respond(HttpStatusCode.OK,"Subject Updated Successfully")
            }
        }

    }
}