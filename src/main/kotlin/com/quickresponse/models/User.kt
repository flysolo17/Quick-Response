package com.quickresponse.models

import kotlinx.serialization.Serializable

@Serializable
class User(
    val id : Int,
    val firstName : String,
    val middleName : String,
    val lastName : String,
    val type : String,
    val idNumber : String,
val password : String)