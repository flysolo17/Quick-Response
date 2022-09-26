package com.quickresponse.repository.user

import com.quickresponse.data.request.SignUpRequest
import com.quickresponse.data.request.UpdateUserRequest
import com.quickresponse.entities.UserEntity
import com.quickresponse.entities.Users
import com.quickresponse.models.User
import com.quickresponse.security.hash.HashingService
import org.ktorm.database.Database
import org.ktorm.dsl.eq
import org.ktorm.dsl.from
import org.ktorm.dsl.insert
import org.ktorm.dsl.update
import org.ktorm.entity.find
import org.ktorm.entity.sequenceOf
import org.ktorm.entity.toList

class UserRepositoryImpl(private val hashingService: HashingService, private val database: Database) : UserRepository {
    override suspend fun insertUser(signUpRequest: SignUpRequest): Boolean {
        val saltedHash  = hashingService.generateHash(signUpRequest.password)
        val result = database.insert(Users) {
            set(it.firstName,signUpRequest.firstName)
            set(it.middleName,signUpRequest.middleName)
            set(it.lastName,signUpRequest.lastName)
            set(it.type,signUpRequest.type)
            set(it.idNumber,signUpRequest.idNumber)
            set(it.password,saltedHash.hash)
            set(it.salt,saltedHash.salt)
        }
        return result != 0
    }

    override suspend fun getUserByIdNumber(idNumber: String): UserEntity? {
        return database.sequenceOf(Users).find { it.idNumber eq idNumber }
    }

    override suspend fun getAllUser() : List<User> {
       return database.sequenceOf(Users).toList().map { User(it.id,it.firstName,it.middleName,it.lastName,it.type, idNumber = it.idNumber, password = it.password) }
    }

    override suspend fun getUserById(userId: Int): User? {
        val userEntity =  database.sequenceOf(Users).find { it.id eq userId }
        return if (userEntity != null) {
            User(userEntity.id,userEntity.firstName,userEntity.middleName,userEntity.lastName,userEntity.type,userEntity.idNumber,userEntity.password)
        } else null
    }

    override suspend fun updateProfile(userId: Int,updateUserRequest: UpdateUserRequest): Boolean {
        val result = database.update(Users) {
            set(it.firstName, updateUserRequest.firstName)
            set(it.middleName, updateUserRequest.middleName)
            set(it.lastName, updateUserRequest.lastName)
            set(it.idNumber, updateUserRequest.idNumber)
            where {
                it.id eq  userId
            }
        }
        return result != 0
    }


}