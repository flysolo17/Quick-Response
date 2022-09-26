package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
data class GetAllSubjectRequest(val userId : Int)