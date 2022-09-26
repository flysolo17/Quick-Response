package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
class LoginRequest(
    val idNumber: String,
    val password : String,
) {
}