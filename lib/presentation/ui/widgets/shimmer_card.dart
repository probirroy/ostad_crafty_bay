import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Opacity(
            opacity: 0.09,
            child: FittedBox(
              child: Center(
                child: SvgPicture.asset(
                  AssetsPath.craftybayLogoSVG,
                  width: 100,
                 // height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor:
            Colors.black.withOpacity(0.04),
            period: const Duration(milliseconds: 800),
            direction: ShimmerDirection.ltr,
            child: Container(
              height: 150,
              width: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius:
                BorderRadius.circular(16.0),
              ),
            )
        ),
      ],
    );
  }
}