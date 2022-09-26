package com.quickresponse.entities

import org.ktorm.entity.Entity
import org.ktorm.schema.Table
import org.ktorm.schema.int
import org.ktorm.schema.varchar


object Users : Table<UserEntity>("users") {
    val id = int(name = "id").primaryKey().bindTo { it.id }
    val firstName = varchar(name = "firstName").bindTo { it.firstName }
    val middleName = varchar(name= "middleName").bindTo { it.middleName }
    val lastName = varchar(name = "lastName").bindTo { it.lastName }
    val type = varchar(name = "type").bindTo { it.type }
    val idNumber = varchar(name = "idNumber").bindTo { it.idNumber }
    val password = varchar(name = "password").bindTo { it.password }
    val salt = varchar(name = "salt").bindTo { it.salt }
}
interface UserEntity : Entity<UserEntity> {
    companion object : Entity.Factory<UserEntity>()
    val id : Int
    val firstName : String
    val middleName : String
    val lastName : String
    val type : String
    val idNumber : String
    val password : String
    val salt : String

}