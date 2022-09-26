package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
data class AttendeesRequest(val idNumber: String ,val attendanceId : Int,) {
}