package com.quickresponse.models

import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.time.LocalDate
@Serializable
data class Attendance (val id : Int,val title : String,val date : String, val subjectId : Int, val code : String,val isOpen : Boolean){
}