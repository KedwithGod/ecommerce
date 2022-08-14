

import 'package:ecommerce/model/imports/generalImport.dart';


class CreateWooCommerceUser{
  // function to create account
  static Future createCustomers({
     String? userName, required String email,required String? name
  })async{
    Map<String, String> header = {
      "content-type": "application/json"
    };
    Map<String,String> data={
    "email": email,
    "first_name": name![0],
    "last_name": name![1],
    "username": userName??"",
    };

    String url = baseUrl("customers");
    var respond =
    post(Uri.parse(url), headers: header,body: data).then((response) {
      var parsed = response.body;
      Map<String,dynamic> decoded = json.decode(parsed)[0];
      if (kDebugMode) {
        print(decoded);
      }
      if (response.statusCode == 200) {
        return UserResponse.fromJson(decoded);
      }

      else {
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;


  }}