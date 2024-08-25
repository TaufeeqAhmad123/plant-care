import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plant_care/controller/login_controller.dart';
import 'package:plant_care/controller/reset_password_controller.dart';

import 'package:plant_care/utils/constant/sizes.dart';
import 'package:plant_care/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/views/signup_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            //border: Border.all(color: Colors.grey),
            image: DecorationImage(
                image: AssetImage('assets/plants.png'), fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Text(
                  'Enter your eamil to reset your password ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Form(
                  key: controller.resetpasswordKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: TSizes.spaceBtwSections,
                        bottom: TSizes.spaceBtwItems),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                //fontSize: TSizes.subTitle,
                                fontWeight: FontWeight.bold)),

                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        TextFormField(
                          controller: controller.email,
                          cursorColor: Colors.black,
                          validator: (value) => TValidator.validateEmail(value),
                          decoration: InputDecoration(
                            //labelText: '  Email',
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(
                              Iconsax.direct_right,
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )),
                            errorBorder: const OutlineInputBorder().copyWith(
                              borderRadius: BorderRadius.circular(
                                  TSizes.inputFieldRadius),
                              borderSide:
                                  const BorderSide(width: 1, color: Colors.red),
                            ),

                            //enabled: BorderRadius.circular(20),
                          ),
                        ),

                        const SizedBox(
                          height: TSizes.loadingIndicatorSize,
                        ),

                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return const CircularProgressIndicator();
                            } else {
                              return ElevatedButton(
                                onPressed: () => controller.resetpassword(),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.deepPurple,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 110, vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.deepPurple),
                                  ),
                                ),
                                child: const Text('Reset Password'),
                              );
                            }
                          }),
                        ),

                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        //social media login
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
