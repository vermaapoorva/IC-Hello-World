class User {
  String userid;
  String name;
  String username;
  String email;

  User(String userid, String name, String username, String email) {
    this.userid = userid;
    this.name = name;
    this.username = username;
    this.email = email;
  }

  String getUserId() {
    return userid;
  }

  String getName() {
    return name;
  }

  String getUsername() {
    return username;
  }

  String getEmail() {
    return email;
  }
}