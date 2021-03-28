class Auth {
  String userid;
  String authToken;

  Auth(String user, String auth) {
    userid = user;
    authToken = auth
  }

  String getUserId() {
    return userid;
  }

  String getAuthToken() {
    return authToken;
  }
}