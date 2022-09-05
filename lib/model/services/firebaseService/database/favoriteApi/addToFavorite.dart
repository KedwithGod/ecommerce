// add to favorite using firebase
import 'package:ecommerce/model/imports/generalImport.dart';

class AddToFavoriteService{

  // add to cart, then add the cart document to the same file
  static String collection = "favorite";

  static Future<bool> addToFavorite(
      {required String? productId,
        required String? productName,
        required String? description,
        String? productQuantity,
        required String? currency,

      }) async {
    return await firebaseFireStore.collection(collection).doc().set({
      "productId": productId,
      'productName': productName,
      "description": description,
      "productQuantity": productQuantity,
      'currency':currency,
      'time of registration':currentTime(),
      'date of registration':currentDate('full date'),
      'time of request':DateTime.now()
    },SetOptions(merge: true)).then((value)  {
      return true;});
  }



  // update cart item
  updateUserData(Map<String, dynamic>? values) {
    return firebaseFireStore.collection(collection).
    doc(values!['id']).update(values);
  }

// list cart item
  Future<QuerySnapshot> requestFuture() {
    var reference = FirebaseFirestore.instance.collection(collection).orderBy('time of request');
    return reference.get();
  }

// remove from cart item
  // a function to delete rider request in case the user cancels request

  deleteRequest(id){
    firebaseFireStore.collection(collection).doc(id).delete();
  }
}