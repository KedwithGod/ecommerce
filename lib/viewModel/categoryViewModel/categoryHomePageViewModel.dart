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


// initialize lists
  initializeCheck(length){
    isSelected = List<bool>.filled(length, false);
    itemColor=List<Color>.filled(length, secondaryColor);
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

  //category list
  List<CategoryResponse> categoryList=[];
  List<int> itemCount=[];
  List<int> categoriesId=[];
  fetchCategoryList()async{
    await WooCommerceCategories.fetchAllCategories().then((value){
      if(value is List){
        // turn dynamic list to CategoryResponse type
        categoryList= value.map((e){
          return CategoryResponse.fromJson(e);
        }).toList();
        notifyListeners();
        // remove the unCategorized item in the list
        categoryList.removeAt(0);
        // initialize the item count
        itemCount=List.generate(categoryList.length, (index) => index);
        notifyListeners();
        // initialize category list
        initializeCheck(categoryList.length);
        // add category index for use
        for(var index in itemCount){
          categoriesId.add(categoryList[index].id!);
          notifyListeners();
        }

        // fetch product details
        productDetails();
      }
      else if(value is WooCommerceErrorResponse){

      }
    });
  }
  fetchSelectedCategoryList(List selectedIndex)async{
    await WooCommerceCategories.fetchAllCategories().then((value){
      if(value is List){
        // turn dynamic list to CategoryResponse type
        categoryList= value.map((e){
          return CategoryResponse.fromJson(e);
        }).toList();
        notifyListeners();
        // remove the unCategorized item in the list
        categoryList.removeAt(0);
        notifyListeners();
        // initialize the item count
        itemCount=List.generate(selectedIndex.length, (index) => index);
        notifyListeners();
        // add category index for use
        for(var index in selectedIndex){
          categoriesId.add(categoryList[index].id!);
          notifyListeners();
        }
        // fetch product details
        productDetails();
      }
      else if(value is WooCommerceErrorResponse){

      }
    });
  }

  List<List<ProductResponse>> productList=[];
  // fetch product using categoryId
  productDetails()async{
    for(var index in itemCount){
      await WooCommerceProducts.fetchAllProducts(
          categoryId: categoriesId[index]).then(( value) {
        if(value is List){
          productList.add( value.map((e){
            return ProductResponse.fromJson(e);
          }).toList());
          notifyListeners();
        }
        else if(value is WooCommerceErrorResponse){

        }
      });
    }

  }
}