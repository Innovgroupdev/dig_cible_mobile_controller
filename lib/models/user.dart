class User {
  final String email;

  const User({
     this.email ='',
  });

  static User fromJSON(json) => User(email: json['email']);
}
