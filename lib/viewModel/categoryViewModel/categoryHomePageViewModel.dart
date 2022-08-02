import 'package:ecommerce/model/imports/generalImport.dart';

class CategoryHomePageViewModel extends BaseModel{
  // list of chips
  // name
  List<String> name=[
    "Jacket", "HandBag", "Spectacle","Gloves","Lab Coat",
    "Dress","Flat Shoes", "Jeans","Necklace","Earrings"
  ];
  // isSelected
  List<bool> isSelected=[];
  List<int> selectedIndex=[];

// isSelected text color
List<Color> itemColor=[];
List<int> itemCount=List.generate(10, (index) => index);

// initialize lists
  initializeCheck(){
    isSelected = List<bool>.filled(10, false);
    itemColor=List<Color>.filled(10, secondaryColor);
    notifyListeners();
  }

  // change item color to white, once it is selected
  onSelected(int index){
    isSelected[index]=!isSelected[index];
    itemColor[index]==secondaryColor?itemColor[index]=white:itemColor[index]=secondaryColor;
    if(selectedIndex.contains(index)){
      selectedIndex.remove(index);
    }
    else{
      selectedIndex.add(index);
    }
    notifyListeners();
    selectedIndex.sort();
    notifyListeners();
  }
}