import 'package:ecommerce/model/imports/generalImport.dart';
import 'package:ecommerce/model/services/firebaseService/authentication/fireBaseAuth.dart';

class SignUpViewModel extends BaseModel{
  //  text field controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(); 
  final TextEditingController fullNameController = TextEditingController();
  // bool to check for error in text field
  final bool emailError = false;
  final bool passwordError = false; 
  final bool fullNameError = false;
  // focus node
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode fullNameFocusNode = FocusNode();
// Sign Up user through firebase
firebaseSignUp(context)async{
    try{
      // show dialog processing request
      showDialog(context: context, builder: (context){
        return DialogBox("Please wait,we are setting Up your account",
            'SignUp',DialogType.error );
      });
      // sign user in and save user data
      await FireBaseAuthClass.fireBaseCreateUser(fullName: fullNameController.text.trim(), email: emailController.text.trim(),
          userPassword: passwordController.text.trim(),
          context: context);
    
    }
     on FirebaseAuthException catch(signUpError){
      Navigator.pop(context);
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return DialogBox(getMessageFromErrorCode(signUpError), 
            'SignUp Error',DialogType.error );
      });
    }
  }
// Sign Up user through google
googleSignUp(context)async{
    try{

    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return DialogBox(getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }
  }
// Sign Up user through apple id
appleSignUp(context)async{
    try{

    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return DialogBox(getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }
  }
// Sign Up user through phone number
phoneAuthentication(context)async{
    try{

    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return DialogBox(getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }
  }
// Sign Up user through facebook 
facebookSignUp(context)async{
    try{

    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return DialogBox(getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }
  }
}