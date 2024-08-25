import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plant_care/Auth/authentication_repository.dart';
import 'package:plant_care/views/login_screen.dart';

class ResetPasswordController extends GetxController {
  // Add your controller logic here

  final email = TextEditingController();

  GlobalKey<FormState> resetpasswordKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  Future<void> resetpassword() async {
    try {
      isLoading(true);

      if (!resetpasswordKey.currentState!.validate()) {
        isLoading(false);
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .resetpassword(email.text.trim());
      Get.to(() => const LoginScreen());

      isLoading(false);

      Get.snackbar(
        'Success',
        'Reset password link sent to your email',
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
      Get.snackbar('Error', backgroundColor: Colors.blue, e.toString());
    }
  }
}
