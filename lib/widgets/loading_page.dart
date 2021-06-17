import '../imports_conflicts.dart';
import '../imports.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    check();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: Get.width / 12,
                right: Get.width / 12,
              ),
              child: Image.asset(logoPath),
            ),
            Padding(
              padding: EdgeInsets.all(24.0),
            ),
            Obx(
              () {
                var status = varController.loadingStatus.value;
                return Text(
                  status,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                  ),
                );
              },
            ),
            Obx(() {
              var percent = varController.loadingPercent.value;
              return (percent < 1)
                  ? CircularProgressIndicator()
                  : Text(
                      '($percent%)',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                    );
            }),
            Text(
              warning,
              style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
