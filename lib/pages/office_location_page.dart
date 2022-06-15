import 'package:attendance/core.dart';
import 'package:attendance/widgets/bottom_loader.dart';

class OfficeLocationPage extends StatelessWidget {
  final OfficeLocationGetxController controller = Get.find();
  OfficeLocationPage({Key? key}) : super(key: key);

  void _goTo() {
    controller.officeName.value.clear();
    controller.latitude.value.clear();
    controller.longitude.value.clear();
    Get.to(
      () => FormLocationPage(),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 300),
    );
  }

  void updateStatus(int? id) async {
    if (id != null) {
      await controller.updateDefaultLocation(id);
      await controller.getListLocation();
    }
  }

  void _onDelete() async {
    Get.bottomSheet(
      const BottomLoader(),
      isDismissible: false,
    );
    final result = await controller.deleteLocation();
    await controller.getListLocation();
    Get.back();
    Get.back();
    if (result != null) {
      Get.defaultDialog(
        title: "Info",
        titleStyle: TextStyles.title,
        content: Text(
          result,
          style: TextStyles.subTitle,
        ),
        onConfirm: () => Get.back(),
        textConfirm: "OK",
        confirmTextColor: MyColors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Office Location',
          style: TextStyles.title,
        ),
      ),
      body: Stack(
        children: [
          _buildBody(),
          Positioned(
            bottom: 10,
            right: 15,
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: _goTo,
              child: Icon(
                CommunityMaterialIcons.plus_circle,
                color: MyColors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 15,
            child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                Get.defaultDialog(
                  title: 'Info',
                  titleStyle: TextStyles.title,
                  content: Text(
                    'Delete all new added offfice location?',
                    style: TextStyles.subTitle,
                  ),
                  confirm: ElevatedButton(
                    onPressed: _onDelete,
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontFamily: robotoSemiBold,
                        color: MyColors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusNormal),
                        ),
                      ),
                    ),
                  ),
                );
              },
              backgroundColor: MyColors.danger,
              child: Icon(
                CommunityMaterialIcons.trash_can,
                color: MyColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(
              'Choose Office Location',
              style: TextStyles.title,
            ),
            Obx(
              () => controller.listLocation.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int idx) {
                        final item = controller.listLocation[idx];
                        final isActive = item.isActive ?? false;
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusNormal),
                          ),
                          child: ListTile(
                            onTap: () => updateStatus(item.id),
                            tileColor: MyColors.white,
                            title: Text(
                              item.desc ?? '',
                              style: TextStyles.title,
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                CommunityMaterialIcons.check_circle,
                                color:
                                    isActive ? MyColors.danger : MyColors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.listLocation.length,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
