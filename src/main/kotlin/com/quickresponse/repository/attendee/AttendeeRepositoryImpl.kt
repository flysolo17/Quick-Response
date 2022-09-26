package com.quickresponse.repository.attendee

import com.quickresponse.data.request.AttendeesRequest
import com.quickresponse.entities.Attendees
import com.quickresponse.entities.AttendeesEntity
import com.quickresponse.entities.Users
import com.quickresponse.models.Attendee
import org.ktorm.database.Database
import org.ktorm.dsl.eq
import org.ktorm.dsl.from
import org.ktorm.dsl.insert
import org.ktorm.dsl.leftJoin

class AttendeeRepositoryImpl(val database : Database) : AttendeeRepository {
    override suspend fun getAllAttendees(attendanceId: Int): List<Attendee> {
        //TODO not yet implemented
        return mutableListOf()
    }
    override suspend fun addAttendee(attendeesRequest: AttendeesRequest): Boolean {
        val result = database.insert(Attendees){
            set(it.idNumber,attendeesRequest.idNumber)
            set(it.attendanceId,attendeesRequest.attendanceId)
            set(it.timestamp,System.currentTimeMillis())
        }
        return result != 0
    }
}