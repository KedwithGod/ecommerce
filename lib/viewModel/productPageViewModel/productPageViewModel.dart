import 'package:ecommerce/model/imports/generalImport.dart';

class ProductPageViewModel extends BaseModel{
  // is selected
  bool isProductSelected=false;

  addToFavorite(){
    isProductSelected=!isProductSelected;
    notifyListeners();
  }
}