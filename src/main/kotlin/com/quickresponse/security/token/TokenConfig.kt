package com.quickresponse.security.token

data class TokenConfig(
    val issuer : String,
    val audience : String,
    var expiresIn : Long,
    val secret : String
)