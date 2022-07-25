import 'package:ecommerce/model/imports/generalImport.dart';

class CartFirstPageViewModel extends BaseModel{
  // cart value
  int cartValue=1;

  // increment value
  increment(){
    cartValue++;
    notifyListeners();
  }

  // decrement value
  decrement(){
    cartValue--;
    notifyListeners();
  }
  // check box
  List<bool> isChecked=[];

  initializeCheck(){
    isChecked = List<bool>.filled(5, false);
    notifyListeners();
  }

  // check box onChanged
  checkBox(int index,bool value){
    isChecked[index]=value;
    notifyListeners();
  }
}



