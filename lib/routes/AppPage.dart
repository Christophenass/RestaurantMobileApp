import 'package:get/get.dart';
import '../bindings/RegBinding.dart';
import '../bindings/loginbinding.dart';
import '../views/Registration.dart';

import '../views/login.dart';
import 'AppRoute.dart';
//These are the named routes my app can use, and here’s the widget (page) and optional bindings (controllers/dependencies) to use for each one.
class AppPage{
  static final List<GetPage> pages=[
    GetPage(
        name: AppRoute.register,
        page: ()=>Registration(),
        binding: RegBinding(),
    ),
    GetPage(
      name: AppRoute.login,
      page: ()=>LoginPage(),
     binding: LoginBinding(),

    ),
  ];

}