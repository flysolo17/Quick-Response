package com.quickresponse

import io.ktor.server.application.*
import com.quickresponse.plugins.*
import com.quickresponse.repository.attendance.AttendanceRepositoryImpl
import com.quickresponse.repository.attendee.AttendeeRepository
import com.quickresponse.repository.attendee.AttendeeRepositoryImpl
import com.quickresponse.repository.subject.SubjectRepositoryImpl
import com.quickresponse.repository.user.UserRepositoryImpl
import com.quickresponse.security.hash.HashingServiceImpl
import com.quickresponse.security.token.TokenConfig
import com.quickresponse.security.token.TokenServiceImpl
import io.ktor.http.*
import io.ktor.server.plugins.cors.routing.*
import org.ktorm.database.Database

fun main(args: Array<String>): Unit =
    io.ktor.server.netty.EngineMain.main(args)


@Suppress("unused") // application.conf references the main function. This annotation prevents the IDE from marking it as unused.
fun Application.module() {
    configureCors()
    val database : Database = Database.connect(
            url = "jdbc:mysql://localhost:3306/quick_response",
            user = "root",
            password = "")
    val tokenService = TokenServiceImpl()
    val tokenConfig = TokenConfig(
        issuer = environment.config.property("jwt.issuer").getString(),
        audience = environment.config.property("jwt.audience").getString(),
        expiresIn = 365L * 1000L * 60L * 60L * 24L,
        secret = "JWT_SECRET"

    )
    val hashingService = HashingServiceImpl()
    val userRepository = UserRepositoryImpl(hashingService,database)
    val subjectRepository = SubjectRepositoryImpl(database)
    val attendanceRepository = AttendanceRepositoryImpl(database)
    val  attendeeRepository = AttendeeRepositoryImpl(database)
    configureSerialization()
    configureMonitoring()
    configureSecurity(tokenConfig)
    configureRouting(userRepository,hashingService,tokenService,tokenConfig,subjectRepository,attendanceRepository,attendeeRepository)
}
