import 'package:ecommerce/model/imports/generalImport.dart';




class LoginViewModel extends BaseModel{
  //  text field controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // bool to check for error in text field
  final bool emailError = false;
  final bool passwordError = false;
  // focus node
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  String requestError="";
  
  // function to retrieve User
  getUser()async{
   await WooCommerceProducts.fetchAllProducts(categoryId: 30);
  }

  // login user

  loginUser(context)async {
    /* // find user using password and email address from all customer
    await AllWooCommerceUser.fetchListOfCustomers(email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value)async{
          if (value is UserResponse){
            // store id in shared preference
           await LocalStorage.setInt(wooCommerceId, value.id);
           // change as guest to false
           await LocalStorage.setBool(guestUser, false);
            Navigator.pushNamed(context, '/homePage');
          }

          else if(value is WooCommerceErrorResponse){
            requestError=value.message;
            notifyListeners();
          }
    });*/


  }

    // continue as a guest
    continueAsGuest(context) async {
      await LocalStorage.setBool(guestUser, true).then((value) {
        Navigator.pushNamed(context, '/homePage');
      });
    }
  }