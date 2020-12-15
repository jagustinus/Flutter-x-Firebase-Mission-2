part of 'page.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  final ctrlName = TextEditingController();

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    ctrlName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: ctrlName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_sharp),
                      labelText: "Full Name",
                      hintText: "Write your full name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: ctrlEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_sharp),
                      labelText: "Email Address",
                      hintText: "Write your active email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: ctrlPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key_sharp),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton.icon(
                    onPressed: () async {
                      if (ctrlName.text == "" ||
                          ctrlEmail.text == "" ||
                          ctrlPassword.text == "") {
                        Fluttertoast.showToast(
                          msg: "Please fill all fields !",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 14.0,
                        );
                      } else {
                        String result = await AuthServices().signUp(
                            ctrlEmail.text, ctrlPassword.text, ctrlName.text);

                        if (result == "success") {
                          Fluttertoast.showToast(
                            msg: "Sign Up successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Sign Up failed, " + result,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.arrow_right_alt_sharp),
                    label: Text("Sign Up"),
                    textColor: Colors.white,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Already registered? Sign in.',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            print("pindah");
                            return SignInPage();
                          }));
                        },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
