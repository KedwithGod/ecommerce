import 'package:ecommerce/model/imports/generalImport.dart';

class ProductPageViewModel extends BaseModel{
  // is selected
  bool isSelected=false;

  addToFavorite(){
    isSelected=!isSelected;
    notifyListeners();
  }
}