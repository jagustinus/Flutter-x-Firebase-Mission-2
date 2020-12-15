part of 'extension.dart';

// FirebaseUser ---> User
extension FirebaseUserExtension on User {
  Users convertToUser(String name) => Users(this.uid, this.email, name: name);
}
