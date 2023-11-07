import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/read_profile_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadProfileScreen extends StatefulWidget {
  const ReadProfileScreen({Key? key}) : super(key: key);

  @override
  State<ReadProfileScreen> createState() => _ReadProfileScreenState();
}

class _ReadProfileScreenState extends State<ReadProfileScreen> {
  @override
  void initState() {
    Get.find<ReadProfileController>().getUserProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 16),
          child: SizedBox(
            height: 580,
            width: double.infinity,
            child: GetBuilder<ReadProfileController>(
              builder: (_readProfileController) {
                return _readProfileController.isReadProfileInProgress ? const Center(child: CircularProgressIndicator()) : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name : ${_readProfileController.profileModel.data?.cusName ?? ''}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor
                              ),
                              ),
                              SizedBox(height: 8,),
                              Text("Address : ${_readProfileController.profileModel.data?.cusAdd ?? ''}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text("Phone Number : ${_readProfileController.profileModel.data?.cusPhone ?? ''}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text("City : ${_readProfileController.profileModel.data?.cusCity ?? ''}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor
                                ),
                              ),
                              SizedBox(height: 8,),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                        Get.to(()=>MainBottomNavScreen());
                      }, child: Text("Home Screen")),
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
