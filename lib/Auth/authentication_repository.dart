// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plant_care/utils/constant/exception.dart';

import 'package:plant_care/views/login_screen.dart';


import '../imagepredict.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final storage = GetStorage();

  final _auth = FirebaseAuth.instance;
  User? get AuthUsers => _auth.currentUser;

//create account with email and password on firebase
  @override
  void onReady() {
    ScreenRedirect();
  }

  ScreenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      Get.to(ImagePredictionScreen());
    } else {
      storage.writeIfNull('isFirstTime', true);
      storage.read('isFirstTime') != true
          ? Get.offAll(const LoginScreen())
          : Get.offAll(const LoginScreen());
    }
  }

  Future<UserCredential> registerWithEmailandPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<UserCredential> signinWithEmailandPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
