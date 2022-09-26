package com.quickresponse.route

import com.quickresponse.data.request.AttendeesRequest
import com.quickresponse.repository.attendee.AttendeeRepository
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.attendeesRoute(attendeeRepository: AttendeeRepository) {
    route("attendees") {
        post("scan") {
            val request = kotlin.runCatching { call.receiveNullable<AttendeesRequest>() }.getOrNull() ?: kotlin.run {
                call.respond(HttpStatusCode.BadRequest,"Invalid Request")
                    return@post
            }
            val  result = attendeeRepository.addAttendee(request)
            if (!result) {
                call.respond(HttpStatusCode.BadRequest,"Add attendee failed!")
            }
            call.respond(HttpStatusCode.OK,"Attendance Success!")
        }
    }
}