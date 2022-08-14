import 'package:ecommerce/model/imports/generalImport.dart';



class FireBaseAuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // firebase auth signIn
  static Future fireBaseCreateUser({required String? fullName,required String? email,
  required String? userPassword, required BuildContext context}) async {
    //sign in with email and password
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!, password: userPassword!).then((value)async{
            // firebase auth instance
        var user = FirebaseAuth.instance.currentUser!;
        // save user Id to sharedPreference
        await LocalStorage.setString('firebaseId', user.uid);

        // create woo commerce user
        await CreateWooCommerceUser.createCustomers( email: email, name: fullName).then((wooCommerce)async{
          // store wooCommerce id in cloud fire store
          if(wooCommerce is UserResponse){
            // save user data to
          await UserServices.createUser(id: user.uid, firstName: fullName!.isEmpty?"":fullName[0], email: email,
                lastName: fullName.isEmpty?"":fullName[1], password: userPassword, wooCommerceId: wooCommerce.id.toString());
            // save wooCommerce id to local storage
            await LocalStorage.setString(wooCommerceId, wooCommerce.id.toString());
          }

        });



        return true;
      });


    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => DialogBox(
                getMessageFromErrorCode(error),
                'Account Creation Error',
                DialogType.error,
                dismissText: 'Change Email',
                function: () {
                  // if the error message contains email, it is likely the email
                  // is incorrect

                  // if the error message contains login, it is likely to go to login pag
                  Navigator.pop(context);
                },
                dismissTextColor: primary,
              ));
      return error;
    }
  }

  Future firebaseSignIn(userEmail, userPassword, context) async {
    //sign in with email and password
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      var user = FirebaseAuth.instance.currentUser!;
      // save user Id to sharedPreference
      await LocalStorage.setString('userId', user.uid);
      return user.uid;
    } on FirebaseAuthException catch (loginError) {
      // update viewState
      // show dialog for login Error
      showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              getMessageFromErrorCode(loginError),
              'Login Error',
              DialogType.error,
            );
          });
    }
  }

  // firebaseAuth SignOut
  Future firebaseSignOut(context) async {
    //sign out from firebase
    _auth.signOut().catchError((onError) {
      // display error in a dialog box
      showDialog(
          context: context,
          builder: (context) => DialogBox(
                onError.toString(),
                'FireBase SignOut',
                DialogType.error,
              ));
    });
  }
}
