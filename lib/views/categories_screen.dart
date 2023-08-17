
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_presenter_app/controller/categotry_controller.dart';

import 'home_screen.dart';

class CategoriesScreen extends StatefulWidget {
   CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
   final format = DateFormat('MMMM dd, yyyy');

   final _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    _categoryController.fetchCategory();
    return Scaffold(

      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _categoryController.categoriesList.length,
                  itemBuilder: (context, index){

                  return
                    InkWell(
                          onTap: (){

                            _categoryController.category = _categoryController.categoriesList[index];
                            setState(() {

                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color:_categoryController.category == _categoryController.categoriesList[index]? Colors.blue:Colors.grey,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Center(child: Text(_categoryController.categoriesList[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white
                                ),)),
                              ),
                            ),
                          ),



                   );

              }),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Obx(() {
                if (_categoryController.isLoading.value) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _categoryController.articleList.length,
                      itemBuilder: (context, index) {
                        var result = _categoryController.articleList[index];
                        DateTime dateTime =
                        DateTime.parse(result.publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(

                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: result.urlToImage!,
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width : width * .3,
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
                              
                              Expanded(child: Container(
                                height: height * .18,
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    Text(result.title!,maxLines: 3,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54
                                    ),),
                                    const SizedBox(height: 10,),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(result.source!.name!,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54
                                          ),),

                                        Text(format.format(dateTime),
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54
                                          ),),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      });
                }
              }),
            ),

          ],
        ),
      ),
    );
  }
}
