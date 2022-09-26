package com.quickresponse.repository.attendance

import com.quickresponse.data.request.AddAttendanceRequest
import com.quickresponse.entities.AttendanceEntity
import com.quickresponse.entities.Attendances
import com.quickresponse.models.Attendance
import org.ktorm.database.Database
import org.ktorm.dsl.*
import org.ktorm.entity.find
import org.ktorm.entity.map
import org.ktorm.entity.sequenceOf
import java.time.LocalDate
import java.util.UUID
import kotlin.random.Random

class AttendanceRepositoryImpl(private val database: Database) : AttendanceRepository {

    override suspend fun addAttendance(addAttendanceRequest: AddAttendanceRequest): Boolean {
       val id = database.insertAndGenerateKey(Attendances) {
           set(it.title,addAttendanceRequest.title)
           set(it.date, LocalDate.now())
           set(it.subjectId,addAttendanceRequest.subjectId)
           set(it.code, UUID.randomUUID().toString() +addAttendanceRequest.subjectId)
           set(it.isOpen,true)
       }
        return id != 0
    }

    override suspend fun getAllAttendance(subjectId : Int): List<Attendance> {
        val list : MutableList<Attendance> = mutableListOf();
        database.from(Attendances).select().where(Attendances.subjectId eq subjectId).forEach { row ->
                val attendance = Attendance(row[Attendances.id]!!,row[Attendances.title]!!,row[Attendances.date].toString(),row[Attendances.subjectId]!!,row[Attendances.code]!!,row[Attendances.isOpen]!!)
                list.add(attendance)
            }
        return list
        }
    override suspend fun deleteAttendance(id: Int): Boolean {
        database.delete(Attendances){it.id eq id}
        return getAttendanceById(id) == null
    }

    override suspend fun getAttendanceById(id: Int): AttendanceEntity? {
        return database.sequenceOf(Attendances).find { it.id eq id }
    }
}