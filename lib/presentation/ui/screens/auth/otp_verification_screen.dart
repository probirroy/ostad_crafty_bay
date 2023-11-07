import 'dart:async';

import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/email_verification_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/otp_verification_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/read_profile_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/create_profile_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/circular_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  const OTPVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
 // final timer = Get.put(TimerController());

  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int timeLeft = 120;
  bool remainTime = true;
  void _startCountDown(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timeLeft > 0){
        timeLeft--;
        setState(() {});
      }else{
      remainTime = false;
        timer.cancel();
      setState(() {
        _buttonDisable = true;
      });

      }
    });
  }

  bool _buttonDisable = false;
  @override
  void initState() {
    _startCountDown();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80,),
                    Center(
                      child: SvgPicture.asset(
                        AssetsPath.craftybayLogoSVG,
                        width: 100,
                      ),
                    ),
                    Text("Enter your OTP code",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24.0,
                    ),),
                    const SizedBox(height: 4.0,),
                    Text("A 4 digit OTP code has been sent",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),),
                    const SizedBox(height: 16.0,),
                    PinCodeTextField(
                      controller: _otpController,
                      validator: (String? value){
                        if(value?.isEmpty ?? true){
                          return "Please enter the OTP code";
                        }else if(value!.length != 6){
                          return 'OTP code must be 6 digits long';
                        }
                        return null;
                      },
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.primaryColor,
                        selectedColor: Colors.green
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {

                      },
                      beforeTextPaste: (text) {
                        return true;
                      }, appContext: context,
                    ),

                    const SizedBox(height: 16.0,),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<OtpVerificationController>(
                        builder: (controller) {
                          return ElevatedButton(
                            onPressed: _buttonDisable ? null : () async {
                             // debugPrint("press");

                              if(!_formKey.currentState!.validate()){
                                return;
                              }

                              verifyOtp(controller);

                            },
                            child: controller.otpInProgress ? CircularButtonWidget(textTitle: 'Please wait',)
                                : const Text("Next"),
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 24.0,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       RichText(
                         text:  TextSpan(
                             style: const TextStyle(color: Colors.grey),
                             children: [
                               const TextSpan(text: 'This code will expire in '),
                               TextSpan(
                                 text: timeLeft.toString(),
                                 style: const TextStyle(
                                   color: AppColors.primaryColor,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ]
                         ),
                       ),
                       RichText(text:   const TextSpan(
                         text: "s",
                         style: TextStyle(
                           color: AppColors.primaryColor,
                           fontWeight: FontWeight.bold,
                         ),
                       ),)
                     ],
                   ),

                    const SizedBox(height: 16.0,),
                    SizedBox(
                     height: 40,
                     width: 120,
                     child: GetBuilder<EmailVerificationController>(
                       builder: (_emailVerificationController) {
                         return ElevatedButton(
                           style: ElevatedButton.styleFrom(foregroundColor: Colors.white,elevation: 0),
                            // onPressed: timeLeft != 0 ? null : () {
                            //   debugPrint("press");
                            // },
                           onPressed: _buttonDisable ?  () {
                             debugPrint("press");
                             setState(() {
                               _emailVerificationController.verifyEmail(email: widget.email);
                               _otpController.clear();
                               timeLeft = 120;
                               remainTime = true;
                               _startCountDown();
                               _buttonDisable = false;
                             });

                           } : null,
                            child: _emailVerificationController.emailVerificationInProgress ?
                            const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 4,
                                        )),
                                  ),
                                  SizedBox(width: 30,),
                                  Text("wait",style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                ],),
                            )
                                : const Text('Resend'),
                          );
                       }
                     ),
                   )
                  ],
                ),
              ),
            ),
          )
      ),

    );
  }
  Future<void>  verifyOtp(OtpVerificationController controller) async {
    final response = await controller.verifyOtp(email: widget.email, otp: _otpController.text.trim());
    if(response == true){
      // Get.offAll(()=>const MainBottomNavScreen());
      await Get.find<ReadProfileController>().getUserProfile();

      Get.find<ReadProfileController>().profileModel.data == null
          ? Get.offAll(()=> CreateProfileScreen())
          : Get.offAll(()=> MainBottomNavScreen());
    }else{
      Get.snackbar("Failed", "Otp verification failed",
          colorText: Colors.black, backgroundColor: Colors.red.shade200);
      // if(mounted){
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text(
      //         "Otp verification failed",
      //       ),
      //     ),
      //   );
      // }
    }
  }
}
