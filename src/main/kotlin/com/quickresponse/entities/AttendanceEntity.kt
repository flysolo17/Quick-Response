package com.quickresponse.entities

import com.quickresponse.entities.Attendances.primaryKey
import org.ktorm.entity.Entity
import org.ktorm.schema.*
import java.time.LocalDate
import java.util.Date

object Attendances : Table<AttendanceEntity>(tableName = "attendance"){
    val id = int(name = "id").primaryKey().bindTo { it.id }
    val title = varchar(name = "title").bindTo { it.title}
    val date = date(name = "date").bindTo { it.date }
    val subjectId = int(name = "subjectId").bindTo { it.subjectId }
    val code = varchar(name = "code").bindTo { it.code }
    val isOpen = boolean(name = "isOpen").bindTo { it.isOpen }

}
interface AttendanceEntity : Entity<AttendanceEntity>{
    companion object : Entity.Factory<AttendanceEntity>()
    val id : Int
    val title : String
    val date : LocalDate
    val subjectId : Int
    val code : String
    val isOpen : Boolean
}
