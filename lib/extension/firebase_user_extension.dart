part of 'extension.dart';

// FirebaseUser ---> User
extension FirebaseUserExtension on User {
  Users convertToUser(String name, String profilePic) =>
      Users(this.uid, this.email, name: name, profilePic: profilePic);
}
