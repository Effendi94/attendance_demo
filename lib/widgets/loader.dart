// Flutter imports:

// Project imports:
import 'package:attendance/core.dart';
import 'package:attendance/widgets/color_loader.dart';

class Loader extends StatelessWidget {
  final String? text;
  const Loader({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: ColorLoader(
              radius: 20.0,
              dotRadius: 5.0,
            ),
          ),
          Center(child: Text(text ?? "Please Wait"))
        ],
      ),
      color: Colors.white.withOpacity(0.6),
      // color: Colors.transparent,
    );
  }
}
