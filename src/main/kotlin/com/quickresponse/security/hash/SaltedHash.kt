package com.quickresponse.security.hash

data  class SaltedHash(
    val hash : String,
    val salt : String
)