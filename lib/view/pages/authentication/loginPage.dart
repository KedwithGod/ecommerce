import 'package:ecommerce/model/imports/generalImport.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        onModelReady: (model) {
          model.getUser();

    },
    disposeViewModel: false,
    viewModelBuilder: () => LoginViewModel(),
    builder: (context, model, child) =>baseUi(children: [
      // logo
      rowPositioned(
        child: S(
            h:200,w:200,
            child: Hero(
                tag: "appLogo",
                child: Image.asset("assets/appLogo.jpeg"))),
        top: 10
      ),
      // login to
      rowPositioned(
          child: GeneralTextDisplay(
              "Login to Cardizerr", secondaryColor, 1, 20, FontWeight.w700, "login"),
          top: 200),
      // sign up
      rowPositioned(
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/signUp");
            },
            child: Row(
              children: [
                GeneralTextDisplay("Don't have an account? ", black51, 1, 16,
                    FontWeight.w400, "login"),
                GeneralTextDisplay(
                    "Sign Up", primary, 1, 16, FontWeight.w600, "login"),
              ],
            ),
          ),
          top: 240),
      // social button
      rowPositioned(
          child: Row(
            children: [
              // facebook
              Container(
                width: sS(context).cW(width: 40),
                height: sS(context).cH(height: 40),
                decoration:  BoxDecoration(
                    color: Color(int.parse("0xff041F60")), shape:BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset:const Offset(0,4),
                          blurRadius: 12,
                          color: petiteOrchid.withOpacity(0.3)
                      )
                    ]
                ),
                alignment: Alignment.center,
                child: GeneralIconDisplay(FontAwesomeIcons.facebookF,
                    white, UniqueKey(), 20),
              ),
              // google
              S(w:15),
              Container(
                width: sS(context).cW(width: 40),
                height: sS(context).cH(height: 40),
                decoration:  BoxDecoration(
                    color: error, shape:BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset:const Offset(0,4),
                          blurRadius: 12,
                          color: petiteOrchid.withOpacity(0.3)
                      )
                    ]
                ),
                alignment: Alignment.center,
                child: GeneralIconDisplay(FontAwesomeIcons.googlePlusG,
                    white, UniqueKey(), 20),
              ),
              //apple
              S(w:15),
              Container(
                width: sS(context).cW(width: 40),
                height: sS(context).cH(height: 40),
                decoration:  BoxDecoration(
                    color: black51, shape:BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset:const Offset(0,4),
                          blurRadius: 12,
                          color: petiteOrchid.withOpacity(0.3)
                      )
                    ]
                ),
                alignment: Alignment.center,
                child: GeneralIconDisplay(FontAwesomeIcons.apple,
                    white, UniqueKey(), 20),
              ),
              //phone auth
              S(w:15),
              GestureDetector(
                onTap: (){
                  phoneAuthenticationService.fireBasePhoneVerification(context, phoneNumber: "+2348151535983");
                },
                child: Container(
                  width: sS(context).cW(width: 40),
                  height: sS(context).cH(height: 40),
                  decoration:  BoxDecoration(
                      color: primary, shape:BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset:const Offset(0,4),
                            blurRadius: 12,
                            color: petiteOrchid.withOpacity(0.3)
                        )
                      ]
                  ),
                  alignment: Alignment.center,
                  child: GeneralIconDisplay(FontAwesomeIcons.mobile,
                      white, UniqueKey(), 20),
                ),
              ),
            ],
          ),
          top: 280),
      // or
      rowPositioned(
          child: GeneralTextDisplay(
              "or", regentGray, 1, 15, FontWeight.w500, "or"),
          top: 340),
      // email
      rowPositioned(
        child:
          textAndTextField(context, textInputType: TextInputType.text,
              controller: model.emailController, hint: "Enter email Address",
              labelText: "Email", onChanged: (){}, inputFormatter: [], errorTextActive: model.emailError, focusNode: model.emailFocusNode,
              prefix: GeneralIconDisplay(Icons.email, primary, UniqueKey(), 20), suffix: null)
          ,top:
          400
      ),
      // password«
      rowPositioned(
          child:
          textAndTextField(context, textInputType: TextInputType.text,
              controller: model.passwordController, hint: "Enter your password",
              labelText: "Password", onChanged: (){}, inputFormatter: [], errorTextActive: model.passwordError, focusNode: model.passwordFocusNode,
              prefix: GeneralIconDisplay(Icons.lock, primary, UniqueKey(), 20), suffix: null)
          ,top:
      472
      ),
      // login
      rowPositioned(
          child: buttonWidget(
              text: "Login",
              onPressed: () {
                //model.loginUser(context);
              },
              radius: 20,
              textColor: white),
          top: 600),
      // continue as guest
      rowPositioned(
          child: ButtonWidget(
                () {
                  model.continueAsGuest(context);
            },
            white,
            200,
            20,
            GeneralTextDisplay("Continue as guest", regentGray, 1, 13,
                FontWeight.w400, "skip for now"),
            Alignment.center,
            0,
            noElevation: true,
          ),
          top: 660),
    ], allowBackButton: false));
  }
}
