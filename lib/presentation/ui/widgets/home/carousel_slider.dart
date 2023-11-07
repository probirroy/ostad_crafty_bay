import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ostad_crafty_bay/data/models/home/slider/slider_data.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<SliderData> carouselSliders; // change here
  const CarouselSliderWidget({Key? key, required this.carouselSliders}) : super(key: key);

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 180.0,
              autoPlay: true,
             // enlargeCenterPage: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (int page,_){
                _selectedSlider.value = page;
              }
          ),
          items: widget.carouselSliders.map((sliderItem) { // change here
            return Builder(
              builder: (BuildContext context) {
                return Container(
                   width: MediaQuery.of(context).size.width,
                    //padding: const EdgeInsets.only(right: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration:  BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: Stack(
                      children: [
                         // child: Image.network(item.image ?? '',), // change here
                         CustomCachedImage(imageUrl: sliderItem.image ?? ""),

                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(sliderItem.title ?? '',style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.red
                            ),)),
                      ],
                    ),
                );
              },
            );
          }).toList(),
        ),

        ValueListenableBuilder(valueListenable: _selectedSlider, builder: (context,value,_){
          List<Widget>list =[];
          for(int i = 0;i<widget.carouselSliders.length;i++){
            list.add( Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16.0),
                color: value == i ? AppColors.primaryColor : null,
              ),
            ));
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list,
          );
        })
      ],
    );
  }
}

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key, required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,height: double.infinity,width: double.infinity, // Provide the URL of the image
        placeholder: (context, url) => SvgPicture.asset(AssetsPath.craftybayLogoSVG),
        errorWidget: (context, url, error) => SvgPicture.asset(AssetsPath.craftybayLogoSVG),
        fit: BoxFit.cover, // You can adjust this to your needs
      ),
    );
  }
}