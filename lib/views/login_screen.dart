import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plant_care/controller/login_controller.dart';

import 'package:plant_care/utils/constant/sizes.dart';
import 'package:plant_care/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/views/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
                  'Everything you need to take care of your plants',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Form(
                  key: controller.loginupKey,
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
                          height: 20,
                        ),
                        const Text('Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                //fontSize: TSizes.subTitle,
                                fontWeight: FontWeight.bold)),

                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        Obx(
                          () => TextFormField(
                            controller: controller.password,
                            obscureText: controller.hidepassw.value,
                            validator: (value) =>
                                TValidator.validatePassword( value),
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              prefixIcon: const Icon(
                                Iconsax.password_check,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () => controller.hidepassw.value =
                                      !controller.hidepassw.value,
                                  icon: controller.hidepassw.value
                                      ? const Icon(Iconsax.eye_slash)
                                      : const Icon(
                                          Iconsax.eye,
                                        )),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  )),
                              errorBorder: const OutlineInputBorder().copyWith(
                                borderRadius: BorderRadius.circular(
                                    TSizes.inputFieldRadius),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.red),
                              ),
                              //enabled: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
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
                                onPressed: () => controller.login(),
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
                                child: const Text('Login'),
                              );
                            }
                          }),
                        ),

                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        const Row(
                          children: [
                            Flexible(
                                child: Divider(
                              color: Colors.white,
                            )),
                            Text(
                              ' Or login with ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Flexible(
                                child: Divider(
                              color: Colors.white,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        //social media login

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(TSizes.xs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Get.to(const SignupScreen());
                                },
                                icon: const Image(
                                  image: AssetImage('assets/google-icon.png'),
                                  width: TSizes.iconMd + 4,
                                  height: TSizes.iconMd + 4,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),
                            Container(
                              padding: const EdgeInsets.all(TSizes.xs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Image(
                                  image: AssetImage('assets/facebook-icon.png'),
                                  width: TSizes.iconMd + 4,
                                  height: TSizes.iconMd + 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignupScreen());
                      },
                      child: const Text('Sign Up',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
