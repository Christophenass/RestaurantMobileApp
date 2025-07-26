import 'package:get/get.dart';

import '../controller/RegistrationController.dart';

class RegBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}
