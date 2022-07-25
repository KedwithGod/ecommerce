import 'package:ecommerce/model/imports/generalImport.dart';

Widget loading({double? height,double? width}){
  return S(
    h: height??50,
    w: width??50,
    child: const CircularProgressIndicator(
      valueColor:   AlwaysStoppedAnimation<Color>(
          primary),
      backgroundColor:white),
  );
}