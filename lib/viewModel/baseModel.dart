import 'dart:async';

import '../model/imports/generalImport.dart';

class BaseModel extends ChangeNotifier{
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


}