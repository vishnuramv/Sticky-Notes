class User {
  String username;
  String firstname;
  String lastname;
  String email;
  String password;
  String api_key;
  String id;

  User(this.username, this.firstname, this.lastname, this.email, this.password,
      this.api_key, this.id);

  User.fromJson(Map<String, dynamic> parsedJson) {
    User user = new User(
        parsedJson['username'],
        parsedJson['firstname'],
        parsedJson['lastname'],
        parsedJson['emailadresss'],
        parsedJson['password'],
        parsedJson['api_key'],
        parsedJson['id']);
  }
}
