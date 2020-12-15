part of 'service.dart';

class ProductServices {
  static CollectionReference productCol =
      FirebaseFirestore.instance.collection("products");
  static DocumentReference productDoc;

  // setup Firestore Storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<bool> addProduct(Products products, PickedFile imgFile) async {
    await Firebase.initializeApp();

    productDoc = await productCol.add({
      'id': "",
      'name': products.name,
      'price': products.price,
      'image': "",
    });

    if (productDoc.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(productDoc.id + ".png");
      uploadTask = ref.putFile(File(imgFile.path));
      await uploadTask.whenComplete(
          () => ref.getDownloadURL().then((value) => imgUrl = value));

      productCol
          .doc(productDoc.id)
          .update({'id': productDoc.id, 'image': imgUrl});
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProduct(
      String id, String name, String price) async {
    await Firebase.initializeApp();
    return await productCol
        .doc(id)
        .update({'name': name, 'price': price})
        .then((value) => true)
        .catchError((error) => false);
  }

  static Future<bool> deleteProduct(Products product) async {
    await Firebase.initializeApp();
    if (product.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(product.id + ".png");

      ref.delete();
      productCol.doc(product.id).delete();

      return true;
    } else {
      return false;
    }
  }
}
