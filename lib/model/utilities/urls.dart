// create a base url function
import '../imports/generalImport.dart';

String baseUrl(String url){
  return "https://www.q8-uc.com/wp-json/wc/v3/$url?consumer_key=$consumerKey"
      "&consumer_secret=$consumerSecret";
}
