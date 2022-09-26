package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
data class SubjectRequest(val name : String,val desc : String? = null,val userId : Int)
