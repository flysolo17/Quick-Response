package com.quickresponse.repository.attendance

import com.quickresponse.data.request.AddAttendanceRequest
import com.quickresponse.entities.AttendanceEntity
import com.quickresponse.models.Attendance

interface AttendanceRepository {
    suspend fun addAttendance(addAttendanceRequest: AddAttendanceRequest):  Boolean
    suspend fun getAllAttendance(subjectId :Int) : List<Attendance>?
    suspend fun deleteAttendance(id: Int) : Boolean
    suspend fun getAttendanceById(id: Int) : AttendanceEntity?
}