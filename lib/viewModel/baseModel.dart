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
  fetchProductDetails()async{
    await WooCommerceProducts.fetchAllProducts(
        categoryId: homePageCategoryId!).then(( value) {
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
}