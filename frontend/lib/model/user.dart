
class User{
  String? username;
  String? password;

  User({this.password, this.username});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      password: json['password'],
      username: json['username']
      );
    }
}