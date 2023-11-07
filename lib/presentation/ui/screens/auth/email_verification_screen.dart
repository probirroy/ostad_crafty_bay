import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/email_verification_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/otp_verification_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/circular_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
   const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key:_formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 80,),
                    Center(
                      child: SvgPicture.asset(
                        AssetsPath.craftybayLogoSVG,
                        width: 100,
                      ),
                    ),
                    Text("Welcome back",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24.0,
                    ),),
                    const SizedBox(height: 4.0,),
                    Text("Please enter your email address",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                      hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value){
                        if(value?.isEmpty ?? true){
                          return "Enter your email";
                        }else if(value!.isEmail == false){
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0,),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<EmailVerificationController>(
                    builder: (controller) {
                      // if(controller.emailVerificationInProgress){
                      //   return const Center(child: CircularProgressIndicator());
                      // }
                      return ElevatedButton(
                        onPressed: () async {
                         if(!_formKey.currentState!.validate()){
                           return;
                         }
                        verifyEmail(controller);
                         /*
                           final response = await controller.verifyEmail(_emailController.text.trim());
                         if(response == true){
                           Get.offAll(()=>const OTPVerificationScreen());
                         }else{
                          if(mounted){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Email verification failed",
                                ),
                              ),
                            );
                          }
                         }
                         * */

                        },
                        child: controller.emailVerificationInProgress ?
                        const CircularButtonWidget(textTitle: 'Please wait',)
                            : const Text("Next"),
                      );
                    }
                  ),
                ),
            ],
                ),
              ),
            ),
          )
      ),
    );
  }

  Future<void> verifyEmail(EmailVerificationController controller) async {
    final response = await controller.verifyEmail(email: _emailController.text.trim());
    if(response == true){
      Get.offAll(()=> OTPVerificationScreen(email: _emailController.text.trim()));
    }else{
      Get.snackbar("Failed", "Email verification failed");
      // if(mounted){
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text(
      //         "Email verification failed",
      //       ),
      //     ),
      //   );
      // }
    }
  }
}


