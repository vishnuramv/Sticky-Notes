class User {
  String username;
  String firstname;
  String lastname;
  String email;
  String password;
  String api_key;
  int id;

  User(this.username, this.firstname, this.lastname, this.email, this.password,
      this.api_key, this.id);

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        parsedJson['username'],
        parsedJson['firstname'],
        parsedJson['lastname'],
        parsedJson['emailadresss'],
        parsedJson['password'],
        parsedJson['api_key'],
        parsedJson['id']);
  }
}
