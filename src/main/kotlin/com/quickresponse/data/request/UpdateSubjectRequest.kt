package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
data class UpdateSubjectRequest(val name : String,val desc : String)
