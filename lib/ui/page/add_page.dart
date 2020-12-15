part of 'page.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final ctrlName = TextEditingController();
  final ctrlPrice = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlPrice.clear();
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
        title: Text("Add Product"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: ctrlName,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_box_sharp),
                        labelText: "Product Name",
                        hintText: "Write your product name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: ctrlPrice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.money_sharp),
                        labelText: "Price",
                        hintText: "Write your product's price",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    imageFile == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton.icon(
                                onPressed: () {
                                  chooseImage();
                                },
                                icon: Icon(Icons.image_rounded),
                                label: Text("Choose from Galery"),
                              ),
                              Text("File not found")
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton.icon(
                                onPressed: () {
                                  chooseImage();
                                },
                                icon: Icon(Icons.image_rounded),
                                label: Text("Rechoose from galery"),
                              ),
                              Semantics(
                                  child: Image.file(
                                File(imageFile.path),
                                width: 100,
                              ))
                            ],
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: Text("Add Product"),
                        onPressed: () async {
                          if (ctrlName.text == "" ||
                              ctrlPrice.text == "" ||
                              imageFile == null) {
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
                            Products products = Products(
                                "", ctrlName.text, ctrlPrice.text,
                                image: imageFile.path);
                            bool result = await ProductServices.addProduct(
                                products, imageFile);

                            if (result) {
                              Fluttertoast.showToast(
                                msg: "Product added successfuly.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                              clearForm();
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: "Failed! Please try again.",
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
                        }),
                    SizedBox(
                      height: 20,
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
    );
  }
}
