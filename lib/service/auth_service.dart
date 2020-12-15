part of 'service.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> signUp(String email, String password, String name) async {
    await Firebase.initializeApp();

    String msg = "";
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Users users = result.user.convertToUser(name);
      auth.signOut();
      await UserServices.updateUser(users);
      msg = "success";
    } catch (e) {
      msg = e.toString();
    }

    return msg;
  }

  Future<String> signIn(String email, String password) async {
    await Firebase.initializeApp();

    String msg = "";

    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => msg = "success");
    } catch (e) {
      msg = e.toString();
    }

    return msg;
  }
}
