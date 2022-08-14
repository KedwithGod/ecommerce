import 'package:ecommerce/model/imports/generalImport.dart';

class CartFirstPageViewModel extends BaseModel{
  // cart value
  List<int> cartValue=[];

  // increment value
  increment(int index){
    cartValue[index]++;
    notifyListeners();
  }

  // decrement value
  decrement(int index){
    if(cartValue[index]==1){

    }
    else{
      cartValue[index]--;
      notifyListeners();
    }
  }
  // check box
  List<bool> isChecked=[];

  initializeChartCheck(){
    isChecked = List<bool>.filled(5, false);
    cartValue=List.generate(5, (index) => 1);
    notifyListeners();
  }

  // check box onChanged
  checkBox(int index,bool value){
    isChecked[index]=value;
    notifyListeners();
  }


}



