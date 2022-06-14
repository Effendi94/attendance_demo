import 'package:attendance/core.dart';
import 'package:community_material_icon/community_material_icon.dart';

class OfficeLocationPage extends StatelessWidget {
  final OfficeLocationGetxController controller = Get.find();
  OfficeLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Office Location',
          style: TextStyles.title,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          CommunityMaterialIcons.plus_circle,
          color: MyColors.white,
        ),
      ),
      body: SafeArea(
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
              ListView.builder(
                itemBuilder: (BuildContext context, int idx) {
                  final item = controller.listLocation[idx];
                  return ListTile(
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
                        color: MyColors.danger,
                      ),
                    ),
                  );
                },
                itemCount: controller.listLocation.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
