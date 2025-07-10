
class User{
  String? username;
  String? password;

  User({this.password, this.username});
  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'username': String username, 'password': String password} => User(
        username: username,
        password: password
      ),
      _ => throw const FormatException('Failed to load products.'),
    };
  }
}