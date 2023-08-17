import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:news_presenter_app/ApiServices/api_services.dart';
import 'package:news_presenter_app/Model/news_channels_headlines_model.dart';


class NewsHeadlineController extends GetxController{

  var isLoading = false.obs;

  late NewsChannelsHeadlinesModel newsModel;
  RxList<Articles> articleList = <Articles>[].obs;

  var name = "ary-news";



  @override
  onInit(){
    super.onInit();

    fetchNewsHeadline();
  }

  fetchNewsHeadline()async{
    isLoading(true);
    try {
      var result = await ApiServices.fetchNewsChannelHeadlinesApi(name);
      if(result.runtimeType == int){
        if(kDebugMode){
          print('Error $result');
          print("Error Data");
        }
      }else{
        newsModel = result;
        articleList.value = newsModel.articles!;
        print(newsModel);
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