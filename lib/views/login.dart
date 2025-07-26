import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/logincontroller.dart';
import '../routes/AppRoute.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Logo or illustration
            Center(
              child: Column(
                children: [
                  Icon(Icons.lock, size: 80, color: theme.colorScheme.primary),
                  const SizedBox(height: 12),
                  Text(
                    "Welcome Back!",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Login to your account",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 📧 Email field
            Text("Email", style: labelStyle),
            const SizedBox(height: 6),
            TextField(
              controller: controller.email, // ✅ bind to controller
              keyboardType: TextInputType.emailAddress,
              decoration: inputStyle("Enter your Email"),
            ),

            const SizedBox(height: 20),

            // 🔒 Password field
            Text("Password", style: labelStyle),
            const SizedBox(height: 6),
            TextField(
              controller: controller.password, // ✅ bind to controller
              obscureText: true,
              decoration: inputStyle("Enter your Password"),
            ),

            const SizedBox(height: 10),

            // 🔁 Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, // Add your forgot logic later
                child: const Text("Forgot Password?"),
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.login(); // ✅ call login method
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 📝 Register prompt
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed(AppRoute.register);
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: "Register here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🎨 Custom input field styling
  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
  }

  // 🏷️ Label style
  final labelStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
}
