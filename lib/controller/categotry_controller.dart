import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:news_presenter_app/ApiServices/api_services.dart';
import 'package:news_presenter_app/Model/category_model.dart';

class CategoryController extends GetxController{
  var isLoading = false.obs;

  late CategoryModel categoryModel;

  RxList<Article> articleList = <Article>[].obs;



  var category = "General";



  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  void onInit() {

    super.onInit();

    fetchCategory();
  }

  fetchCategory()async{
    isLoading(true);

    try {
      var result = await ApiServices.fetchCategoryNews(category);
      if(result.runtimeType == int){
        if(kDebugMode){
          debugPrint('Error $result');

        }
      }else{
        categoryModel = result;
        articleList.value = categoryModel.articles!;
        print(categoryModel);
      }
    } on Exception catch (e) {
      if(kDebugMode){
        print('Fetch Data Error $e');
      }
    }finally{
      isLoading(false);
    }

  }
}