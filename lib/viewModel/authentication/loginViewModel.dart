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
}