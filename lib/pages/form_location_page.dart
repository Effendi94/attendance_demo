import 'package:attendance/core.dart';
import 'package:attendance/widgets/bottom_loader.dart';
import 'package:attendance/widgets/rounded_text_field.dart';

class FormLocationPage extends StatelessWidget {
  final OfficeLocationGetxController controller = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FormLocationPage({Key? key}) : super(key: key);

  void selectPlace() async {
    // final pos = await controller.getCurrentLocation();
    // final result = await Get.to(
    //   () => PlacePicker(
    //     dotenv.get('kGoogleApiKey'),
    //     displayLocation: LatLng(pos.latitude, pos.longitude),
    //   ),
    // );

    // if (result == null) return;
    // debugPrint('$result');
  }

  void _setCurrentLocation() async {
    Get.bottomSheet(
      const BottomLoader(),
      isDismissible: false,
    );
    final pos = await controller.getCurrentLocation();
    controller.latitude.value.text = pos.latitude.toString();
    controller.longitude.value.text = pos.longitude.toString();
    Get.back();
  }

  void _saveLocation() async {
    try {
      if (formKey.currentState!.validate()) {
        Get.bottomSheet(
          const BottomLoader(),
          isDismissible: false,
        );
        final data = TableLocation(
          desc: ucWord(controller.officeName.value.text),
          latitude: convertToDouble(controller.latitude.value.text),
          longtitude: convertToDouble(controller.longitude.value.text),
          isActive: true,
        );
        final resultId = await controller.saveLocation(data);
        await controller.updateDefaultLocation(resultId);
        Get.back();
        Get.defaultDialog(
          title: 'Info',
          titleStyle: TextStyles.title,
          content: Text(
            "Data Office Saved",
            style: TextStyles.subTitle,
          ),
          confirm: ElevatedButton(
            onPressed: () async {
              await controller.getListLocation();
              Get.back();
              Get.back();
            },
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
                  borderRadius: BorderRadius.circular(kBorderRadiusNormal),
                ),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed save data',
        backgroundColor: MyColors.danger,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Add Office Location',
          style: TextStyles.title,
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Office Name',
                style: TextStyles.inputLabel,
              ),
              RoundedTextField(
                validator: Validator.validateEmpty,
                controller: controller.officeName.value,
              ),
              const SizedBox(height: 5),
              Text(
                'Office Location',
                style: TextStyles.inputLabel,
              ),
              // RoundedTextField(
              //   validator: Validator.validateEmpty,
              //   readOnly: true,
              //   hintText: "Tap to add",
              //   controller: controller.latitude.value,
              //   onTap: selectPlace,
              // ),
              Obx(
                () => RoundedTextField(
                  validator: Validator.validateEmpty,
                  hintText: "Latitude",
                  controller: controller.latitude.value,
                  keyboardType: TextInputType.number,
                ),
              ),
              Obx(
                () => RoundedTextField(
                  validator: Validator.validateEmpty,
                  hintText: "Longitude",
                  controller: controller.longitude.value,
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: Text(
                    'Get Current Location',
                    style: TextStyles.elevatedButton,
                  ),
                  onPressed: _setCurrentLocation,
                ),
              ),
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: _saveLocation,
                child: const Text(
                  'SAVE',
                  style: TextStyle(
                    fontFamily: robotoBold,
                  ),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size.fromHeight(
                      50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
