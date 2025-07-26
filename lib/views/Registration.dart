import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/RegistrationController.dart';

class Registration extends GetView<RegistrationController> {
  // Obscure-state only for this screen
  final RxBool _obscurePassword = true.obs;

  Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text("Create Account"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(theme),
                    const SizedBox(height: 30),

                    _buildField(
                      label: "Full Name",
                      hint: "Enter your full name",
                      controller: controller.nameCtrl,
                    ),
                    const SizedBox(height: 20),

                    _buildField(
                      label: "Email",
                      hint: "Enter your email",
                      type: TextInputType.emailAddress,
                      controller: controller.emailCtrl,
                    ),
                    const SizedBox(height: 20),

                    _buildField(
                      label: "Phone Number",
                      hint: "Enter your number",
                      type: TextInputType.phone,
                      controller: controller.phoneCtrl,
                    ),
                    const SizedBox(height: 20),

                    _buildField(
                      label: "Country",
                      hint: "Enter your country",
                      controller: controller.countryCtrl,
                    ),
                    const SizedBox(height: 20),

                    _buildPasswordField(),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.register,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : const Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const Spacer(),
                    Center(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: "Login here",
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.person_add_alt_1,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            "Join Us",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Fill in your details to create an account",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    TextInputType type = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 6),
        Obx(
          () => TextField(
            controller: controller.passwordCtrl,
            obscureText: _obscurePassword.value,
            decoration: InputDecoration(
              hintText: "Enter your password",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () =>
                    _obscurePassword.value = !_obscurePassword.value,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
