package com.quickresponse.security.hash

interface HashingService {
    fun generateHash(value: String , saltedLength : Int = 32) : SaltedHash
    fun verify(value: String,saltedHash: SaltedHash) : Boolean
}