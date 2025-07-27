import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Account created');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Registration failed');
    }
  }

  // Login user
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Logged in');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login failed');
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
