import 'package:cached_network_image/cached_network_image.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {

  const CategoryCard({
    super.key, required this.image, required this.categoryName, required this.onTab,
  });
 final String image;
 final String categoryName;
 final VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: SizedBox(
        width: 90,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              //margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child:  CachedNetworkImage(
                  imageUrl: image,
                  placeholder:(context,url)=> SvgPicture.asset(AssetsPath.craftybayLogoSVG) ,
                errorWidget: (context, url, error) => const Icon(Icons.image),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
             Text(categoryName,style: const TextStyle(
              fontSize: 16.0,
              letterSpacing: 0.4,
              color: AppColors.primaryColor,
              overflow: TextOverflow.ellipsis,
            ),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}