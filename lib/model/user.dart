class User {
  final String uid;
  final String userName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String photoUrl;
  User(
      {
        this.uid,
      this.userName,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.photoUrl});
}

class UserData {
  String userName;
  String fullName;
  String email;
  String phoneNumber;
  String photoUrl;
  String password;
  UserData(
      {this.userName,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.photoUrl,
      this.password});
}
