part of 'page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
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
                          if (ctrlEmail.text == "" || ctrlPassword.text == "") {
                            Fluttertoast.showToast(
                              msg: "Please fill all fields !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            String result = await AuthServices()
                                .signIn(ctrlEmail.text, ctrlPassword.text);
                            if (result == "success") {
                              Fluttertoast.showToast(
                                msg: "Sign In successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );

                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return MainMenu();
                              }));
                            } else {
                              Fluttertoast.showToast(
                                msg: "Sign In failed, " + result.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        icon: Icon(Icons.download_sharp),
                        label: Text("Sign In"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account ? Sign up.",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpPage();
                              }));
                            },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            isLoading == true
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
