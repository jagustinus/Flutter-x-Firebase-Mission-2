part of 'service.dart';

class UserServices {
  static CollectionReference _userCol =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference _userDoc;

  static Future<void> updateUser(Users users) async {
    _userCol.doc(users.uid).set({
      'uid': users.uid,
      'email': users.email,
      'name': users.name,
      'profilePic': users.profilePicture ?? ""
    });
  }
}
