import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_presenter_app/controller/newsHeadlineController.dart';
import 'package:news_presenter_app/uitls/app_image.dart';

enum FilterList {bbcNews, aryNews, independent, reuters, cnn, alJazeera}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static const spinKit2 = SpinKitFadingCircle(
    color: Colors.amber,
    size: 50,
  );
}

class _HomeScreenState extends State<HomeScreen> {
  final _newsController = Get.put(NewsHeadlineController());

  final format = DateFormat('MMMM dd, yyyy');

  FilterList? selectedMenu;



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppImage.category,
                height: 30,
                width: 30,
              )),
          actions: [
           PopupMenuButton<FilterList>(
                initialValue:selectedMenu,
                  icon: const Icon(Icons.more_vert, color: Colors.black,),
                  onSelected: (FilterList item){
                  if(FilterList.bbcNews.name == item.name){

                   _newsController.name = 'bbc-news';

                  }
                  if(FilterList.aryNews.name == item.name){
                   _newsController.name = 'ary-news';

                  }
                  if(FilterList.alJazeera.name == item.name){
                   _newsController.name = 'al-jazeera-english';

                  }
                  setState(() {
                    selectedMenu= item;
                    _newsController.fetchNewsHeadline();
                  });

                  },

                  itemBuilder: (context)=> <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                        child: Text('BBC News')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.aryNews,
                        child: Text('Ary News')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.alJazeera,
                        child: Text('Al Jazeera')),

              ]),

          ],
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .55,
              width: width,
              child: Obx(() {
                if (_newsController.isLoading.value) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _newsController.articleList.length,
                      itemBuilder: (context, index) {
                        var result = _newsController.articleList[index];
                        DateTime dateTime =
                            DateTime.parse(result.publishedAt.toString());
                        return SizedBox(
                          child: Stack(
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: result.urlToImage!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: HomeScreen.spinKit2,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 30,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding:const EdgeInsets.all(15),
                                    height: height * .22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            result.title!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: Row(

                                            children: [
                                              Text(
                                                result.source!.name!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(width: width * 0.3),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
              }),
            )
          ],
        ));
  }
}
