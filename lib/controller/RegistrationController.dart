import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:registrationpage/views/login.dart';

class RegistrationController extends GetxController {
  
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  
  final isLoading = false.obs;

  
  Future<void> register() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return;
    }

    isLoading(true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Account created');
      
      Get.offAll(() => LoginPage()); 
      
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registration Failed', e.code);
    } finally {
      isLoading(false);
    }
  }

  
  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    countryCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}
