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
            Image.asset(logoPath),
            Padding(
              padding: EdgeInsets.all(24.0),
            ),
            Observer(
              builder: (context) {
                var status = varStore.loadingStatus;
                return Text(
                  status,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                  ),
                );
              },
            ),
            Observer(builder: (context) {
              var percent = varStore.loadingPercent;
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
