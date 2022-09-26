package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
data class UpdateUserRequest(val firstName : String,
val middleName : String,
val lastName : String,
val idNumber : String)
