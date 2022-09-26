package com.quickresponse.models

import kotlinx.serialization.Serializable

@Serializable
data class Subject(val id : Int, val name : String,val desc : String,val createdAt : String, val userId : Int)