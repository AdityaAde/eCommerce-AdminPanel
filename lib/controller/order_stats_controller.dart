import 'package:backend_getx/models/order_stats_models.dart';
import 'package:backend_getx/services/database_service.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController {
  final DatabaseService database = DatabaseService();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    stats.value = database.getOrderStats();
    super.onInit();
  }
}
