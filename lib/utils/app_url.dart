

class AppUrl {
  static var url = "http://192.168.100.18:8080";
  static var loginEndpoint = "$url/auth/login";
  static var secretEndpoint = "$url/auth/secret";
  static var signUpEndpoint = "$url/auth/signup";
  static var createSubjectEndpoint = "$url/subject/create";
  static var subjectEndpoint = "$url/subject";
  static var attendanceEndpoint = "$url/attendance";
  static var createAttendanceEndpoint = "$attendanceEndpoint/create";
 }