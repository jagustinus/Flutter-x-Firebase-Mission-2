part of 'page.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('users');
  bool isLoading = false;

  Users user;

  @override
  void initState() {
    getUserData();
    // print(user.name);
    super.initState();
  }

  void getUserData() async {
    UserServices.getCurrentUserData().then((value) => {
          setState(() {
            user = value;
          })
        });
  }

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Account"), centerTitle: true, leading: Container()),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(8),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(user == null
                                ? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'
                                : user.profilePic),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton.icon(
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8),
                            icon: Icon(Icons.image),
                            label: Text('Edit Photo'),
                            onPressed: () async {
                              await chooseImage();
                              await UserServices.updateProfilePicture(
                                      user, imageFile)
                                  .then((value) {
                                if (value) {
                                  Fluttertoast.showToast(
                                    msg: "Update profile picture succesfull!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );

                                  setState(() {
                                    getUserData();
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Failed",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            user == null ? '' : user.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            user == null ? '' : user.email,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Signout Confirmation"),
                            content: Text("Are you sure to signout ?"),
                            actions: [
                              FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await AuthServices.signOut().then(
                                    (value) => {
                                      if (value)
                                        {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return SignInPage();
                                            },
                                          ))
                                        }
                                      else
                                        {
                                          setState(() {
                                            isLoading = false;
                                          })
                                        }
                                    },
                                  );
                                },
                                child: Text("Yes"),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Sign Out"),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                  ),
                ),
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
    );
  }
}
