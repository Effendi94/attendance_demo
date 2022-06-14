import 'package:attendance/core.dart';

class OfficeLocationGetxController extends GetxController {
  var listLocation = <TableLocation>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getListLocation();
  }

  Future<void> getListLocation() async {
    try {
      isLoading(true);
      final dataList = await TableLocation().select().orderBy('desc').toList();
      if (dataList.isNotEmpty) {
        listLocation(dataList);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
}
