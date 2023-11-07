import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ostad_crafty_bay/application/state_holders_binders.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/theme_mode_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/splash_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


final ThemeModeController themeModeController =ThemeModeController();

class CraftyBay extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
   CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {

  late final StreamSubscription _connectivityStatusStream;
  void checkInitialInternetConnection()async{
    final connectivityResult = await (Connectivity().checkConnectivity());
    handleConnectivityStates(connectivityResult);
  }
   void checkInternetConnectivityStatus(){
     _connectivityStatusStream = Connectivity().onConnectivityChanged.listen((status) {
       handleConnectivityStates(status);
     });
   }
   void handleConnectivityStates(ConnectivityResult status){
     if(status != ConnectivityResult.wifi && status != ConnectivityResult.mobile){
       Get.showSnackbar(const GetSnackBar(
         title: 'No internet!',
         message: 'Please check your internet connectivity',
         isDismissible: false,
       ));

       // Get.defaultDialog(
       //   title: "No Internet",
       //   middleText: "Please check your internet connection.",
       //   barrierDismissible: false,
       //   titleStyle: const TextStyle(color: Colors.red),
       // );



     }else{
     // Get.back();

       if (Get.isSnackbarOpen) {
         Get.closeAllSnackbars();
       }
     }


   }

   @override
  void initState() {
     checkInitialInternetConnection();
     checkInternetConnectivityStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return ValueListenableBuilder(
        valueListenable:themeModeController.themeMode,
      builder: (context, themeMode,_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CraftyBay',
          navigatorKey: CraftyBay.globalKey,
          initialBinding: StateHolderBinder(),
          theme: ThemeData(
            primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors().color),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding:  const EdgeInsets.symmetric(vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            inputDecorationTheme:  const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors().color),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding:  const EdgeInsets.symmetric(vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            inputDecorationTheme:  const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          themeMode: themeMode,
          //themeMode: ThemeMode.light,
          home: const SplashScreen(),
        );
      }
    );
  }

  @override
  void dispose() {
    _connectivityStatusStream.cancel();
    super.dispose();
  }
}

