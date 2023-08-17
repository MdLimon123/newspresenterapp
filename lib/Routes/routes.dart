import 'package:get/get.dart';
import 'package:news_presenter_app/views/categories_screen.dart';
import 'package:news_presenter_app/views/home_screen.dart';
import 'package:news_presenter_app/views/splash_screen.dart';

class Routes {
  static String splashScreen = "/splash_screen";
  static String homeScreen = "/home_screen";
  static String categoryScreen = "/category_screen";
}

List<GetPage> getPages = [
  GetPage(name: Routes.splashScreen, page: () => SplashScreen()),
  GetPage(name: Routes.homeScreen, page: () => HomeScreen()),
  GetPage(name: Routes.categoryScreen, page: ()=> CategoriesScreen())
];
