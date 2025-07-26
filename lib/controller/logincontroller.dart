import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:registrationpage/views/MainPage.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      print("✅ Login successful for: ${userCredential.user?.email}");
      Get.snackbar("Success", "Logged in successfully");
      Get.offAll(() => MainPage());
      // Navigate to your app's home page or dashboard here
      // e.g., Get.offNamed(AppRoute.home);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed";

      if (e.code == 'user-not-found') {
        errorMessage = "No user found with that email";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password";
      }

      print("❌ FirebaseAuthException: ${e.code} - ${e.message}");
      Get.snackbar("Error", errorMessage);
    } catch (e) {
      print("❌ Unexpected error: $e");
      Get.snackbar("Error", "An unexpected error occurred");
    }
  }
}
