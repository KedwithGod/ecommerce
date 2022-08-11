import 'dart:async';
import '../model/imports/generalImport.dart';

class BaseModel extends ChangeNotifier{
  // for advanced drawer
  final advancedDrawerController = AdvancedDrawerController();
  // drop down value
  String dropDown="Select";
  List<String> dropDownList=["Select",];

  // view state
  ViewState state=ViewState.idle;
  // state error
  String? stateError;

  updateState(ViewState viewState){
    state=viewState;
    notifyListeners();
  }

  // streams
  StreamController<ViewState> stateController=StreamController<ViewState>.broadcast();

  @override
  void dispose() {
   stateController.close();
    super.dispose();
  }

// instead of passing date from homePage to homePageCategory
// set homePageCategory id
  int? homePageCategoryId;
  String homePageCategoryName="";
  homePageCategory(context,{required int id,required String categoryName }){
    homePageCategoryId=id;
    homePageCategoryName=categoryName;
    notifyListeners();
    fetchProductDetails();


  }
  List<ProductResponse> homePageCategoryList=[];
  // fetch product using homePageCategoryId
  Future fetchProductDetails({int? categoryId})async{
    await WooCommerceProducts.fetchAllProducts(
        categoryId: categoryId??homePageCategoryId!).then(( value) {
      if(value is List){
        homePageCategoryList= value.map((e){
          return ProductResponse.fromJson(e);
        }).toList();
        notifyListeners();
      }
      else if(value is WooCommerceErrorResponse){

      }
    });
  }

  bool? asGuest;
  // check if user is guest
  guestStatus()async{
    asGuest =await LocalStorage.getBool(guestUser);
    notifyListeners();
    return LocalStorage.getBool(guestUser).then((value) => value);
  }

  // category
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
  // initialize lists
  initializeCheck(length){
    isSelected = List<bool>.filled(length, false);
    itemColor=List<Color>.filled(length, secondaryColor);
    notifyListeners();
  }

  //category list
  List<CategoryResponse> categoryList=[];
  List<int> itemCount=[];
  List<int> categoriesId=[];
  fetchCategoryList({bool isQuickOrder=false})async{
    await WooCommerceCategories.fetchAllCategories().then((value)async{
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

        categoryDropDown=categoryList.map((e) => e.name.toString()).toList();
        notifyListeners();
        // store category list of strings
        LocalStorage.setString('cat', json.encode(categoryDropDown));
        // store the fetch categories
        LocalStorage.setString('catList', json.encode(value));
        await updateCategoryDropDown();
        // fetch product details
        if(isQuickOrder==false)productDetails();
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

  // lang drop down
List<String> langList=["Kuwaiti dinar","Uruguyan peso"];

updateDropDown(){
  dropDown=langList[0];
  notifyListeners();
}
updateLangDropDownValue(String value){
    dropDown=value;
    notifyListeners();
    if (kDebugMode) {
      print("updateValue $dropDown");
    }
  }

// category
  String categoryString="";
  List<String> categoryDropDown=[""];
updateCategoryDropDown()async{
  String? fetch=await LocalStorage.getString("cat");
  List value=json.decode(fetch!);
  categoryDropDown=value.map((e) => e.toString()).toList();
  notifyListeners();
  categoryString=categoryDropDown[0];
  notifyListeners();
  //await LocalStorage.setString('cat', "");
  print("i am dropDown $dropDown");
}

  updateCategoryDropDownValue(String categoryValue,BuildContext context)async{
    try{
      // update value

      categoryString=categoryValue;
      notifyListeners();
      // show dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: S(
            h:200,w:200,
            child: customDialog(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading(),
                    S(h:20),
                    GeneralTextDisplay(
                      "Loading products",
                      white, 3, 14, FontWeight.w500, "",
                      textAlign: TextAlign.center,)
                  ],
                ),
                align: Alignment.center),
          ),
        ),);
      // fetch stored data

      String? fetch=await LocalStorage.getString("catList");
      List value=json.decode(fetch!);
      // decode data to CategoryResponse

      categoryList=value.map((e) => CategoryResponse.fromJson(e)).toList();
      notifyListeners();
      // get the id from the data

      var id=categoryList.firstWhere((element) =>
      element.name==categoryString).id;
      // fetch the list of products

      await fetchProductDetails(categoryId:id ).then((value)  {
        Navigator.pop(context);
        productDropDown=homePageCategoryList.map((e) => e.name.toString()).toList();
        notifyListeners();
        updateProductDropDown();

        });
    }

    catch(e){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: S(
            h:200,w:200,
            child: customDialog(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeneralTextDisplay(
                      "Sorry,Unable to fetch products",
                      white, 3, 14, FontWeight.w500, "",
                      textAlign: TextAlign.center,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: GeneralTextDisplay(
                        "close",
                        primary, 3, 14, FontWeight.w400, "",
                      ),
                    ),
                  ],
                )]),
                align: Alignment.center),
          ),
        ),);
    }
  }


// update product list on QO(quick order)page
List<String> productDropDown=[""];
String productString="";
// products
 StreamController<String> productStream=StreamController<String>.broadcast();

  updateProductDropDown(){
    productString=productDropDown[0];
    notifyListeners();
    print("i am product $productString");
  }
updateQOProductDropDown(String value)async{
  productString=value;
  notifyListeners();
}

String? string;

updatng(){
  string="value";
  notifyListeners();
}



}