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

        // initialize cart
        initializeProductAddToCart(homePageCategoryList.length);
        LocalStorage.setString('productList', json.encode(value));
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
  fetchCategoryList(context,{bool isQuickOrder=false})async{
    try{
      SchedulerBinding.instance?.addPostFrameCallback((_) =>showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return dialogBox(context,
              "Fetching Category List",
              'Category',
              DialogType.processing,
              function: () {},
              dismissText: "",
            );
          }));
      await WooCommerceCategories.fetchAllCategories().then((value) async {
        if (value is List) {
          // turn dynamic list to CategoryResponse type
          categoryList = value.map((e) {
            return CategoryResponse.fromJson(e);
          }).toList();
          notifyListeners();
          // remove the unCategorized item in the list
          categoryList.removeAt(0);
          // initialize the item count
          itemCount = List.generate(categoryList.length, (index) => index);
          notifyListeners();
          // initialize category list
          initializeCheck(categoryList.length);
          // add category index for use
          for (var index in itemCount) {
            categoriesId.add(categoryList[index].id!);
            notifyListeners();
          }

          categoryList
              .map((e) => e.name.toString())
              .toList()
              .forEach((element) {
            categoryDropDown.add(element);
          });
          notifyListeners();
          // store category list of strings
          LocalStorage.setString('cat', json.encode(categoryDropDown));
          // store the fetch categories
          LocalStorage.setString('catList', json.encode(value));
          await updateCategoryDropDown();
          // fetch product details
          if (isQuickOrder == false) productDetails();
          Navigator.pop(context);
        }
        else if (value is WooCommerceErrorResponse) {
          Navigator.pop(context);
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => dialogBox(context,
               value.message,
                'Category',
                DialogType.error,
                dismissText: 'close',
                function: () {
                  // if the error message contains email, it is likely the email
                  // is incorrect

                  // if the error message contains login, it is likely to go to login pag
                  Navigator.pop(context);
                },
                dismissTextColor: primary,
              ));
        }
      });
    }
    on SocketException catch (error){
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(context,
            "Looks like you have a bad internet connection, kindly check and try again",
            'Network Error',
            DialogType.error,
            dismissText: 'close',
            function: () {
              // if the error message contains email, it is likely the email
              // is incorrect

              // if the error message contains login, it is likely to go to login pag
              Navigator.pop(context);
            },
            dismissTextColor: primary,
          ));
      return error;
    }
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
  String categoryString="Select Category";
  List<String> categoryDropDown=["Select Category"];
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
                    GeneralTextDisplay(
                      "Loading products",
                      black51, 3, 14, FontWeight.w500, "",
                      textAlign: TextAlign.center,),
                    S(h:20),
                    loading(),
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
       if(homePageCategoryList.isNotEmpty) {
         productDropDown=homePageCategoryList.map((e) => e.name.toString()).toList();
        notifyListeners();

       }
       else if(homePageCategoryList.isEmpty){
         productDropDown=["No product available"];
         notifyListeners();
       }
        updateProductDropDown();
        updateDropDown();
        updateCategoryDropDown();

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
List<String> productDropDown=["Select Product"];
String productString="Select Product";
double productPrice=0;
// products
 StreamController<String> productStream=StreamController<String>.broadcast();

  updateProductDropDown(){
    productString=productDropDown[0];
    notifyListeners();
    print("i am product $productString");
  }
updateQOProductDropDown(String value)async{
   // update product String
  productString=value;
  notifyListeners();

  // set product price
  String? productListString=await LocalStorage.getString('productList');
  List decodedList=jsonDecode(productListString!);
  homePageCategoryList=decodedList.map((e) => ProductResponse.fromJson(e)).toList();
  notifyListeners();
  String unFormattedProductPrice=homePageCategoryList.firstWhere((element) => element.name==productString).regularPrice!;
  // format string to bring out price
  productPrice=double.parse(unFormattedProductPrice.toString());
  notifyListeners();

}

// product price
// add to cart color
  // cart value
  List<int> productCartValue=[];
  // check box
  List<bool> isProductChecked=[];

  initializeProductAddToCart(int value){
    isProductChecked = List<bool>.filled(value, false);
    productCartValue=List.generate(value, (index) => 1);
    notifyListeners();
  }

  int currentIndex=0;
  Color cartColor=grey;
  productAddToCart(int index){
    isProductChecked[index]= !isProductChecked[index];
    notifyListeners();
    if (kDebugMode) {
      print(index);
    }
  }


  // save device id to localStorage
  saveDeviceId()async{
    String? deviceId = await PlatformDeviceId.getDeviceId;
    if (kDebugMode) {
      print('i am device id'+ deviceId!);
    }
    LocalStorage.setString(guestUserId, deviceId!);
  }

  // add to cart function, to add a product to chart
}