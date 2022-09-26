package com.quickresponse.route

import com.quickresponse.data.request.AddAttendanceRequest
import com.quickresponse.repository.attendance.AttendanceRepository
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.attendanceRoute(attendanceRepository: AttendanceRepository) {
    route("attendance") {
        post("/create") {
            val request = kotlin.runCatching { call.receiveNullable<AddAttendanceRequest>() }.getOrNull() ?: kotlin.run {
                call.respond(HttpStatusCode.BadRequest,"Invalid Request")
                return@post
            }
            val result = attendanceRepository.addAttendance(request)
            if (!result) {
                call.respond(HttpStatusCode.BadRequest,"Create Attendance Failed")
            }
            call.respond(HttpStatusCode.OK,"Attendance Created Successfully")
        }
        get("{subjectId}") {
            val subjectId = call.parameters["subjectId"] ?: return@get call.respond(HttpStatusCode.BadRequest,"No Subject Id")
            val result = attendanceRepository.getAllAttendance(subjectId = subjectId.toInt())!!
            if (result.isNotEmpty()) {
                call.respond(HttpStatusCode.OK,result)
            } else {
                call.respondText("No subject ", status = HttpStatusCode.OK)
            }
        }
        delete("{id}") {
            val attendanceId = call.parameters["id"] ?: return@delete call.respond(HttpStatusCode.BadRequest,"No Attendance Id")
            val attendance = attendanceRepository.getAttendanceById(attendanceId.toInt())
            if (attendance != null) {
                val result = attendanceRepository.deleteAttendance(attendanceId.toInt())
                if (result) {
                    call.respondText("Attendance removed correctly", status = HttpStatusCode.Accepted)
                } else {
                    call.respondText("Attendance removal failed", status = HttpStatusCode.NotFound)
                }
            } else {
                call.respondText("not attendance with id $attendanceId", status = HttpStatusCode.NotFound)
            }
        }
    }
}