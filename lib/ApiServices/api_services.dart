import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_presenter_app/Model/news_channels_headlines_model.dart';

class ApiServices{

  static dynamic fetchNewsChannelHeadlinesApi()async{

    try {
      var request = http.Request('GET', Uri.parse('https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=108a8d319c034889ab3bb7756c80ae35'));

      http.StreamedResponse response = await request.send();

      if(response.statusCode == 200){
        var data = await response.stream.bytesToString();
        print(data);
        return newsChannelsHeadlinesModelFromJson(data);

      }else{
        return response.statusCode;
      }
    } on Exception catch (e) {
      if(kDebugMode){
        debugPrint('News fetch error : ${e.toString()}');
      }
      return 0;
    }



  }

}