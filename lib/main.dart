import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:registrationpage/controller/CartController.dart';
import 'package:registrationpage/controller/MainPageController.dart';
import 'package:registrationpage/controller/RegistrationController.dart';
import 'controller/logincontroller.dart';
import 'routes/AppRoute.dart';
import 'views/Registration.dart';
import 'views/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

 
  Get.put(LoginController());
  Get.put(RegistrationController());
  Get.put(MainPageController());
  Get.put(CartController());
  runApp(const MyApp());
}

// Register controllers

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //eza ma hattayna GetMaterialApp ma btefham l routes
    //GetMaterialApp is a widget that provides the necessary bindings and routing for GetX.
    return GetMaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //latest design system from google
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
      home: LoginPage(),
      routes: {AppRoute.register: (context) => Registration()},
      debugShowCheckedModeBanner: false,
    );
  }
}
