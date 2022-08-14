// constants of string
// screen sizing

import 'package:ecommerce/model/imports/generalImport.dart';




ScreenSize sS(BuildContext context, )=>ScreenSize(context: context);

// class instances
ValidateEmailAddress validateEmail=ValidateEmailAddress();
ValidatePhoneNumber validatePhone=ValidatePhoneNumber();
UserServices userService=UserServices();
Faker fakeData=Faker();
PhoneAuthenticationService phoneAuthenticationService=PhoneAuthenticationService();

// plugin instances
FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;

// keys
String consumerKey="ck_39971a6abfbae154c5baf5d9f98e7b1155226b07";
String consumerSecret="cs_3d9d18991d087a8dfe7cca01e8b5d8f825b488fb";

// carousel colors
List<String> carousels=[
"https://www.q8-uc.com/wp-content/uploads/2022/05/Webp.net-compress-image-1-2048x909.jpg",
"https://www.q8-uc.com/wp-content/uploads/2022/05/2_2-2048x909.jpg",
"https://www.q8-uc.com/wp-content/uploads/2022/05/1_1-2048x909.jpg"
];

// string names
// store registered user id
String wooCommerceId="wooCommerceId";
// store user as guest
String guestUser="guestUser";
