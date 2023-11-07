import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/auth_utility_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/email_verification_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    goToNextPage();
  }
  Future<void> goToNextPage() async {
    await AuthUtilityController.getAccessToken();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAll(()=> const MainBottomNavScreen());
     //  Get.offAll(() => AuthUtilityController.isLoggedIn
     //      ? const MainBottomNavScreen()
     //      : const EmailVerificationScreen());
    });
  }

  @override
  void dispose() {
    // Revert to the default system UI mode when disposing the splash screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SvgPicture.asset(
              AssetsPath.craftybayLogoSVG,
              width: 100,
            ),
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 16.0,
          ),
          const Text("Version 1.0.0"),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
