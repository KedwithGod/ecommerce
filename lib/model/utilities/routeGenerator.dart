
import '../imports/generalImport.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case '/homePage':
        return materialPage(settings,const HomePage());
      case '/cartFirstPage':
        return materialPage(settings,const CartFirstPage());
      case '/categoryHomePage':
        return materialPage(settings,const CategoryHomePage());
      case '/categoryList':
        return materialPage(settings, CategoryList(
            selectedCategory:settings.arguments as List<int>
        ));
      case '/productPage':
        return materialPage(settings,const ProductPage());
      case '/favoritePage':
        return materialPage(settings,const FavoritePage());
      case '/accountPage':
        return materialPage(settings,const AccountPage());



      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }

  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title:const Text('No page Route'),
        ),
        body: const Center(
          child:Text('The page you tab either had no page route or the route is incorrect'),
        ),
      );
    });
  }
}

