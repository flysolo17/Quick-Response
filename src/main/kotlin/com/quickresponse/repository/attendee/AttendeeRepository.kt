package com.quickresponse.repository.attendee

import com.quickresponse.data.request.AttendeesRequest
import com.quickresponse.entities.AttendeesEntity
import com.quickresponse.models.Attendee

interface AttendeeRepository {
    suspend fun getAllAttendees(attendanceId : Int) : List<Attendee>
    suspend fun addAttendee(attendeesRequest: AttendeesRequest) : Boolean
}