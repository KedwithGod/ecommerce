import 'package:dio/dio.dart';
import 'package:ecommerce/model/imports/generalImport.dart';



class HomePageViewModel extends BaseModel{


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

  //category list
List<CategoryResponse> categoryList=[];
  fetchCategoryList()async{
    await WooCommerceCategories.fetchAllCategories().then((value){
      if(value is List){
       categoryList= value.map((e){
          return CategoryResponse.fromJson(e);
        }).toList();
       notifyListeners();
       categoryList.removeAt(0);
       notifyListeners();
      }
      else if(value is WooCommerceErrorResponse){

      }
    });
  }

}