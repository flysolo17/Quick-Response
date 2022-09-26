package com.quickresponse.entities

import org.ktorm.entity.Entity
import org.ktorm.schema.Table
import org.ktorm.schema.int
import org.ktorm.schema.long
import org.ktorm.schema.varchar

object Attendees : Table<AttendeesEntity>(tableName = "attendees"){
    val id = int(name="id").primaryKey().bindTo { it.id }
    val idNumber = varchar(name ="idNumber").bindTo { it.idNumber }
    val attendanceId = int(name = "attendanceId").bindTo { it.attendanceId }
    val timestamp = long(name = "timestamp").bindTo { it.timestamp }
}

interface AttendeesEntity : Entity<AttendeesEntity> {
    companion object : Entity.Factory<AttendeesEntity>()
    val id : Int
    val idNumber : String
    val attendanceId : Int
    val timestamp : Long
}