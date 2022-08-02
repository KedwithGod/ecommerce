

import 'package:ecommerce/model/imports/generalImport.dart';


class AllWooCommerceUser{
  // function to create account
  static Future fetchListOfCustomers({
    required String userName, required String email
  })async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("customers");
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {

      var parsed = response.body;
     List<Map<String,dynamic>> decoded = json.decode(parsed);
      if (kDebugMode) {
        print('i am decoded $decoded');
      }
      if(response.statusCode==200){
        Map<String,dynamic> userAccount=decoded.where((element){
          if(UserResponse.fromJson(element).email==email &&
              UserResponse.fromJson(element).username==userName) {
            return true;
          }
          return false;
        }).first;
       return UserResponse.fromJson(userAccount);
      }
      else{
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;
  }

}