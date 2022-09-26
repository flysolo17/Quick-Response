package com.quickresponse.repository.subject

import com.quickresponse.data.request.SubjectRequest
import com.quickresponse.entities.*
import com.quickresponse.models.Subject
import org.ktorm.database.Database
import org.ktorm.dsl.*
import org.ktorm.entity.find
import org.ktorm.entity.sequenceOf
import org.ktorm.entity.toList
import java.time.LocalDate
import java.util.Date

class SubjectRepositoryImpl(private val database : Database) : SubjectRepository {
    override suspend fun createSubject(subjectRequest: SubjectRequest): Boolean {
        val result = database.insert(Subjects) {
            set(it.name,subjectRequest.name)
            set(it.desc,subjectRequest.desc)
            set(it.userId,subjectRequest.userId)
            set(it.createdAt, LocalDate.now())
        }
        return result != 0
    }

    override suspend fun getAllSubject(userID: Int): List<Subject> {
        val list : MutableList<Subject> = mutableListOf()
        database.from(Subjects)
            .select()
            .where{(Subjects.userId eq userID)}
            .forEach { row ->
                val subject = Subject(row[Subjects.id]!!,row[Subjects.name]!!,
                    row[Subjects.desc]?: "no description",
                    row[Subjects.createdAt].toString(),
                    row[Subjects.userId]!!)
                list.add(subject)
            }
        return list

    }
    override suspend fun deleteSubject(subjectID: Int): Boolean {
        database.delete(Subjects) { it.id eq subjectID }.also {
            deleteAttendanceWithSubjectId(subjectID)
        }
        return getSubjectByID(subjectID) == null
    }

    override suspend fun updateSubject(subjectID: Int,name : String,desc : String): Boolean {
        val result = database.update(Subjects) {
            set(it.name, name)
            set(it.desc,desc)
            where {
                it.id eq subjectID
            }
        }
        return result != 0
    }

    override suspend fun deleteAttendanceWithSubjectId(subjectID: Int) {
        database.delete(Attendances){ it.subjectId eq subjectID}
    }
    override suspend fun getSubjectByID(subjectID: Int): SubjectEntity? {
        return database.sequenceOf(Subjects).find { it.id eq subjectID }
    }
}