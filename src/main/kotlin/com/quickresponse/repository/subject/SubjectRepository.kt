package com.quickresponse.repository.subject

import com.quickresponse.data.request.SubjectRequest
import com.quickresponse.entities.SubjectEntity
import com.quickresponse.models.Subject

interface SubjectRepository {
    suspend fun createSubject(subjectRequest: SubjectRequest) : Boolean
    suspend fun getAllSubject(userID : Int) : List<Subject> ?
    suspend fun getSubjectByID(subjectID: Int) : SubjectEntity ?
    suspend fun deleteSubject(subjectID : Int) : Boolean
    suspend fun updateSubject(subjectID: Int,name : String,desc : String) : Boolean
    suspend fun deleteAttendanceWithSubjectId(subjectID: Int)
}