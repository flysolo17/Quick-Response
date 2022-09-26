package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
data class SignUpRequest(
    val firstName : String,
    val middleName : String,
    val lastName : String,
    val type: String,
    val idNumber : String,
    val password : String
)
