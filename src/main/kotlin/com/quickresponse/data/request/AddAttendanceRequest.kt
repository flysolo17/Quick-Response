package com.quickresponse.data.request

import kotlinx.serialization.Serializable

@Serializable
class AddAttendanceRequest(val title : String,val subjectId : Int)