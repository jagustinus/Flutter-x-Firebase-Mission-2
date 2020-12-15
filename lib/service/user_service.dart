part of 'service.dart';

class UserServices {
  static CollectionReference _userCol =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference _userDoc;

  // setup Firestore Storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<void> updateUser(Users users) async {
    _userCol.doc(users.uid).set({
      'uid': users.uid,
      'email': users.email,
      'name': users.name,
      'profilePic': users.profilePic ?? ""
    });
  }

  static Future<Users> getCurrentUserData() async {
    DocumentSnapshot snapshot =
        await _userCol.doc(AuthServices.getCurrentUID()).get();

    Users currentUser = Users(snapshot.get('uid'), snapshot.get('email'),
        profilePic: snapshot.get('profilePic'), name: snapshot.data()['name']);

    // return

    User user = AuthServices.auth.currentUser;

    print(currentUser.profilePic);

    // return user.convertToUser(snapshot.get('name'), snapshot.get('profilePic'));
    return currentUser;
  }

  static Future updateProfilePicture(Users user, PickedFile imageFile) async {
    ref = FirebaseStorage.instance
        .ref()
        .child('users/pics')
        .child(user.uid + ".png");
    uploadTask = ref.putFile(File(imageFile.path));
    await uploadTask.whenComplete(
        () => ref.getDownloadURL().then((value) => imgUrl = value));
    return _userCol
        .doc(user.uid)
        .update({
          'profilePic': imgUrl,
        })
        .then((value) => true)
        .catchError((onError) => false);
  }
}
