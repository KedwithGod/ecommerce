// add to cart using firebase
import 'package:ecommerce/model/imports/generalImport.dart';

class AddToCartService{

  // add to cart, then add the cart document to the same file
static String collection = "cart";

// this is to initialize cart document so it can be updated with array functions

   Future<bool> initializeCartStorage(String email)async{
     return await firebaseFireStore.collection(collection).doc(email).set({
       'cartItemList':[]
     },SetOptions(merge: true)).then((value)  {
       return true;});
   }

// add a new item to cart
  static Future<bool> addToCart(
      {required String? productId,
      required String? productName,
      required String? description,
      String? productQuantity,
        required String? currency,
        required String? email// for non registered user, use phone identifier
      }) async {
   return await firebaseFireStore.collection(collection).doc(email).update({
     'cartItemList':FieldValue.arrayUnion([{
       "productId": productId,
       'productName': productName,
       "description": description,
       "productQuantity": productQuantity,
       'currency': currency,
       'time of registration': currentTime(),
       'date of registration': currentDate('full date'),
       'time of request': DateTime.now()
     }])}).then((value)  {
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

  deleteRequest(String email, String elementIndex){
    firebaseFireStore.collection(collection).doc(email).update({
      "cartItemList": FieldValue.arrayRemove([elementIndex]),
    });;
  }
}