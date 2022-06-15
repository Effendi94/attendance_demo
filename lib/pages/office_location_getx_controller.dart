import 'package:attendance/core.dart';
import 'package:geolocator/geolocator.dart';

class OfficeLocationGetxController extends GetxController {
  var officeName = TextEditingController().obs;
  var latitude = TextEditingController().obs;
  var longitude = TextEditingController().obs;

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

  Future<Position> getCurrentLocation() async {
    await checkPermission();
    final result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return result;
  }

  Future<int> saveLocation(TableLocation tableLocation) async {
    final result = await tableLocation.save();
    if (result == null) throw "";
    return result;
  }

  Future<String?> deleteLocation() async {
    final result = await TableLocation().select().id.not.equals(1).delete();
    return result.successMessage;
  }

  Future<void> updateDefaultLocation(int id) async {
    await TableLocation().select().isActive.equals(true).update(
      {'isActive': 0},
    );
    await TableLocation().select().id.equals(id).update({'isActive': 1});
  }
}
