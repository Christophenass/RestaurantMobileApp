import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'routes/AppPage.dart';
import 'routes/AppRoute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   //GetMaterialApp is a widget where we get the page and its widgets we want to load when the user opens the app
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //`initialRoute` defines the first screen shown when the app starts.(login or register hasab shou mnhatta)
initialRoute: AppRoute.login,
      //defines what widget and bindings to load when a route name is used(register or login widget)
      getPages:AppPage.pages
    );
  }
}





