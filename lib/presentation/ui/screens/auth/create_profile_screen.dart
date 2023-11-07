import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/create_profile_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/read_profile_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/otp_verification_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/read_profile_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/payment/invoice_list_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/circular_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {

  final TextEditingController _cusNameController = TextEditingController();
  final TextEditingController _cusAddController = TextEditingController();
  final TextEditingController _cusCityController = TextEditingController();
  final TextEditingController _cusStateController = TextEditingController();
  final TextEditingController _cusPostcodeController = TextEditingController();
  final TextEditingController _cusCountryController = TextEditingController();
  final TextEditingController _cusPhoneController = TextEditingController();
  final TextEditingController _cusFaxController = TextEditingController();
  final TextEditingController _shipNameController = TextEditingController();
  final TextEditingController _shipAddController = TextEditingController();
  final TextEditingController _shipCityController = TextEditingController();
  final TextEditingController _shipStateController = TextEditingController();
  final TextEditingController _shipPostcodeController = TextEditingController();
  final TextEditingController _shipCountryController = TextEditingController();
  final TextEditingController _shipPhoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final controller = Get.find<ReadProfileController>();
  bool _isLoading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData().then((value){
        _cusNameController.text = controller.profileModel.data?.cusName ?? '';
        _cusAddController.text =  controller.profileModel.data?.cusAdd ?? '';
        _cusCityController.text = controller.profileModel.data?.cusCity ?? '';
        _cusStateController.text = controller.profileModel.data?.cusState ?? '';
        _cusPostcodeController.text = controller.profileModel.data?.cusPostcode ?? '';
        _cusCountryController.text = controller.profileModel.data?.cusCountry ?? '';
        _cusPhoneController.text = controller.profileModel.data?.cusPhone ?? '';
        _cusFaxController.text = controller.profileModel.data?.cusFax ?? '';
        _shipNameController.text = controller.profileModel.data?.shipName ?? '';
        _shipAddController.text = controller.profileModel.data?.shipAdd ?? '';
        _shipCityController.text = controller.profileModel.data?.shipCity ?? '';
        _shipStateController.text = controller.profileModel.data?.shipState ?? '';
        _shipPostcodeController.text = controller.profileModel.data?.shipPostcode ?? '';
        _shipCountryController.text = controller.profileModel.data?.shipCountry ?? '';
        _shipPhoneController.text = controller.profileModel.data?.shipPhone ?? '';
      });

    });
    super.initState();
  }

  Future<void>fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await controller.getUserProfile();
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_isLoading ? const Center(child: CircularProgressIndicator()) : SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 24.0,),
                    Center(
                      child: SvgPicture.asset(
                        AssetsPath.craftybayLogoSVG,
                        width: 100,
                      ),
                    ),
                    Text("Complete Profile",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24.0,
                    ),),
                    const SizedBox(height: 4.0,),
                    Text("Get started with us by share your details",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _cusNameController,
                      decoration:  InputDecoration(
                        labelText: 'Full Name',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      controller: _cusAddController,
                      decoration:  InputDecoration(
                        labelText: 'Your Address',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _cusCityController,
                      decoration:  InputDecoration(
                        labelText: 'City',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your city name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _cusStateController,
                      decoration:  InputDecoration(
                        labelText: 'State',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your state name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _cusPostcodeController,
                      decoration:  InputDecoration(
                        labelText: 'Postcode',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your postcode';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _cusCountryController,
                      decoration:  InputDecoration(
                        labelText: 'Country',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your country name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _cusPhoneController,
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your mobile number';
                        } else {
                          if (text!.length < 11) {
                            return 'Mobile should be at least 11 digit';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _cusFaxController,
                      decoration:  InputDecoration(
                        labelText: 'Fax',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your fax number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Shipping Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _shipNameController,
                      decoration:  InputDecoration(
                        labelText: 'Shipping Person Name',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter shipping person full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      controller: _shipAddController,
                      decoration: InputDecoration(
                        labelText: 'Shipping Address',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _shipCityController,
                      decoration: InputDecoration(
                        labelText: 'Shipping City',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter shipping city name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _shipStateController,
                      decoration: InputDecoration(
                        labelText: 'Shipping State',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter shipping state name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _shipPostcodeController,
                      decoration: InputDecoration(
                        labelText: 'Shipping Postcode',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter shipping postcode';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _shipCountryController,
                      decoration: InputDecoration(
                        labelText: 'Shipping Country',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter shipping country name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _shipPhoneController,
                      decoration:  InputDecoration(
                        labelText: 'Shipping Mobile',
                        labelStyle:TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      validator: (String? text) {
                        if (text?.isEmpty ?? true) {
                          return 'Enter shipping mobile number';
                        } else {
                          if (text!.length < 11) {
                            return 'Mobile should be at least 11 digit';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0,),
                    GetBuilder<CreateProfileController>(
                      builder: (_createProfileController) {
                        return SizedBox(
                          width: 230,
                          child: ElevatedButton(
                            onPressed: () async {
                             if(_formKey.currentState!.validate()){
                               final response = await _createProfileController.createUserProfile(
                                  cusName: _cusNameController.text.trim(),
                                  cusAdd: _cusAddController.text.trim(),
                                  cusCity: _cusCityController.text.trim(),
                                  cusState: _cusStateController.text.trim(),
                                  cusPostcode: _cusPostcodeController.text.trim(),
                                  cusCountry: _cusCountryController.text.trim(),
                                  cusPhone: _cusPhoneController.text.trim(),
                                  cusFax: _cusFaxController.text.trim(),
                                  shipName: _shipNameController.text.trim(),
                                  shipAdd: _shipAddController.text.trim(),
                                  shipCity: _shipCityController.text.trim(),
                                  shipState: _shipStateController.text.trim(),
                                  shipPostcode: _shipPostcodeController.text.trim(),
                                  shipCountry: _shipCountryController.text.trim(),
                                  shipPhone: _shipPhoneController.text.trim(),
                               );
                          if(response == true){
                            if(mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Succesully update profile",
                                  ),
                                ),
                              );
                            }
                                 Get.to(()=> const MainBottomNavScreen());
                               } else{
                                 if(mounted){
                                   ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                       content: Text(
                                         _createProfileController.errorMessage,
                                       ),
                                     ),
                                   );
                                 }
                               }

                             }
                            },
                            child: _createProfileController.isCreateProfileInProgress ?
                            const CircularButtonWidget(textTitle: "Please wait")
                                : const Text("Update Profile"),
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 8.0,),
                    SizedBox(
                      width: 120,
                      child: OutlinedButton(
                        onPressed: (){
                        Get.to(()=> const InvoiceListScreen());
                      }, child: const Text("Invoice List"),),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
