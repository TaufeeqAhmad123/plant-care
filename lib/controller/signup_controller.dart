import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plant_care/Auth/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  // Add your controller logic here

  final hidepassw = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  GlobalKey<FormState> loginupKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  Future<void> signup() async {
    try {
      isLoading(true);

      if (!loginupKey.currentState!.validate()) {
        isLoading(false);
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailandPassword(
              email.text.trim(), password.text.trim());

      isLoading(false);

      AuthenticationRepository.instance.ScreenRedirect();

      Get.snackbar(
        'Success',
        'User account created successfully',
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
        shouldIconPulse: true,
        padding: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.copy_success),
      );
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }
}
