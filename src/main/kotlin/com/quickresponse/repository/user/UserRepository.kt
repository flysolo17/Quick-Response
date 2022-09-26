package com.quickresponse.repository.user

import com.quickresponse.data.request.SignUpRequest
import com.quickresponse.data.request.UpdateUserRequest
import com.quickresponse.entities.UserEntity
import com.quickresponse.models.User

interface UserRepository {
    suspend fun insertUser(signUpRequest: SignUpRequest) : Boolean
    suspend fun getUserByIdNumber(idNumber : String) : UserEntity?
    suspend fun getAllUser() : List<User>
    suspend fun getUserById(userId : Int) : User?
    suspend fun updateProfile(userId: Int,updateUserRequest : UpdateUserRequest) : Boolean
}