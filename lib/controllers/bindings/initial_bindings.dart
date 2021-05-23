import 'package:get/get.dart';
import 'package:shank/controllers/create_new_db_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateNewDbController>(CreateNewDbController());
  }
}
