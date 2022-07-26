import 'package:ecommerce/model/imports/generalImport.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return baseUi(children: [
      // login to

      rowPositioned(child: GeneralTextDisplay("Login to Cardizerr", black, 1, 20,
          FontWeight.w700 , "login"), top: 200),
      // sign up
      // social button
      // email
      // password
      // login
      // continue as guest
    ], allowBackButton: false);
  }
}
