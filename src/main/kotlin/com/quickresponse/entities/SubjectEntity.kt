package com.quickresponse.entities

import org.ktorm.entity.Entity
import org.ktorm.schema.Table
import org.ktorm.schema.date
import org.ktorm.schema.int
import org.ktorm.schema.varchar
import java.time.LocalDate


object Subjects : Table<SubjectEntity>(tableName = "subjects") {
    val id = int("id").primaryKey().bindTo { it.id }
    val name = varchar("name").bindTo { it.name }
    val desc = varchar("desc").bindTo { it.desc }
    val userId = int("userId").bindTo { it.userId }
    val createdAt = date("createdAt").bindTo { it.createAt }
}

interface SubjectEntity : Entity<SubjectEntity> {
    companion object : Entity.Factory<SubjectEntity>()
    val id : Int
    val name : String
    val desc : String
    val userId : Int
    val createAt : LocalDate
}