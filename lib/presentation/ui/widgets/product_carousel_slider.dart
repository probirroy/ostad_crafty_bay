import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCarouselSliderWidget extends StatefulWidget {
  final List<String>imageList;
  const ProductCarouselSliderWidget({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ProductCarouselSliderWidget> createState() => _ProductCarouselSliderWidgetState();
}

class _ProductCarouselSliderWidgetState extends State<ProductCarouselSliderWidget> {
  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 260.0,
              autoPlay: true,
             //  enlargeCenterPage: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (int page,_){
                _selectedSlider.value = page;
              }
          ),
          items: widget.imageList.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                   width: MediaQuery.of(context).size.width,
                    //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration:  BoxDecoration(
                        color: Colors.grey.shade300,
                    ),
                    child: CachedNetworkImage(
                      imageUrl:  imageUrl ?? '',
                      placeholder:(context,url)=> SvgPicture.asset(AssetsPath.craftybayLogoSVG) ,
                      errorWidget: (context, url, error) => SvgPicture.asset(AssetsPath.craftybayLogoSVG),
                    ),

                );
              },
            );
          }).toList(),
        ),

       Positioned(
         bottom: 10,
         left: 0,
         right: 0,
         child:  ValueListenableBuilder(valueListenable: _selectedSlider, builder: (context,value,_){
         List<Widget>list =[];
         for(int i = 0;i<widget.imageList.length;i++){
           list.add( Container(
             height: 14,
             width: 14,
             margin: const EdgeInsets.symmetric(horizontal: 4.0),
             decoration: BoxDecoration(
               // border: Border.all(color: Colors.grey),
               borderRadius: BorderRadius.circular(16.0),
               color: value == i ? AppColors.primaryColor : Colors.white,
             ),
           ));
         }
         return Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: list,
         );
       }),)
      ],
    );
  }
}