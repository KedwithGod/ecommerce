
import 'package:ecommerce/model/imports/generalImport.dart';



// method to perform all google signIN
class GoogleSigning{
  // initializing the google sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // current user details
  String? userEmail;
  String? userDisplayName;
  String? userPhotoUrl;
  String? userId;
  GoogleSignInAccount? _user;
  // google sign in method
  Future googleSignIn(context) async{
    final googleUser =await _googleSignIn.isSignedIn();
    if (googleUser==true) {
      _googleSignIn.isSignedIn();
      return true;
    }
    else{
      return false;
    }
  }

  // google signUp method
  Future googleSignUp(context) async {
 try{
   final GoogleSignInAccount? googleUser =await _googleSignIn.signIn();

   // values gotten from the user google account
   googleUser!=null?userEmail=googleUser.email:null;
   googleUser!=null?userDisplayName=googleUser.displayName:null;
   googleUser!=null?userPhotoUrl=googleUser.photoUrl:null;
   googleUser!=null?userId=googleUser.id:null;

   print(userId);
   // save data into local Storage
   await LocalStorage.setString('userId', googleUser!.id);
   googleUser.authentication;
   userService.createUser(id:userId,email: userEmail,
       firstName:userDisplayName,photoUrl: userPhotoUrl
   );

   // getting the google sign iN account user
   _user=googleUser;
   // setting up google auth
   GoogleSignInAuthentication googleAuth;
   googleAuth =await googleUser.authentication;

   // creating a credential to sign up into firebase
   final credential =GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken
   );

   // signing into firebase using the credentials gotten form google
   await FirebaseAuth.instance.signInWithCredential(credential).then((value) => true);
   // add creating customer with woo commerce
 }

 catch(onError){
     // display error in a dialog box
      showDialog(
          context: context,
          builder: (context)=>
              DialogBox(onError.toString(), "Google Sign In", DialogType.error));
    }


  }


  // google signOut method
    Future googleSignOut(context) async {
    await _googleSignIn.disconnect();
      await _googleSignIn.signOut().catchError((onError){
        // display error in a dialog box
        showDialog(
            context: context,
            builder: (context)=>
                DialogBox(onError.toString(), 'Google SignOut',DialogType.error, ));
      });
      await FirebaseAuth.instance.signOut();
    }
}
