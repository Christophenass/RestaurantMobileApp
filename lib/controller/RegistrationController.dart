import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:registrationpage/views/login.dart';

class RegistrationController extends GetxController {
  // ── TextEditingControllers for every field --------------------------
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  // ── Public observable for loading / error states (optional) --------
  final isLoading = false.obs;

  // ── Registration method --------------------------------------------
  Future<void> register() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    // Basic client-side validation
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
      // inside RegistrationController.register(), replace the failing line
      Get.offAll(() => LoginPage()); // ← works immediately
      // Navigate or clear fields if desired
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registration Failed', e.code);
    } finally {
      isLoading(false);
    }
  }

  // ── Clean-up -------------------------------------------------------
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
