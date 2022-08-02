import 'package:dio/dio.dart';
import 'package:ecommerce/model/imports/generalImport.dart';


class HomePageViewModel extends BaseModel{
// for advanced drawer
  final advancedDrawerController = AdvancedDrawerController();

  products()async{
   // var products = await wooCommerceAPI.getAsync("products");
   var product=await Dio().get("https://www.q8-uc.com/wp-json/wc/v3/products?consumer_key=ck_39971a6abfbae154c5baf5d9f98e7b1155226b07&consumer_secret=cs_3d9d18991d087a8dfe7cca01e8b5d8f825b488fb",
    options: Options(
      headers:{
        HttpHeaders.contentTypeHeader:"application/json"
      }
    )
    );
    print("products $product");
  }
}