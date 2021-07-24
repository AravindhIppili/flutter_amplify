class User {
  String email, username;
  List<String>? images;
  User({
    required this.email,
    required this.username,
     this.images
    });
}

User currentUser  =User(email: "",username: "");
