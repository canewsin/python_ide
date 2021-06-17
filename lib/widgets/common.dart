import '../imports.dart';
import '../imports_conflicts.dart';

class ZeroNetAppBar extends StatelessWidget {
  const ZeroNetAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            uiController.currentAppRoute.value.title,
            style: GoogleFonts.roboto(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              if (uiController.currentAppRoute.value == AppRoute.Settings)
                InkWell(
                  child: Icon(
                    OMIcons.info,
                    size: 32.0,
                    color: Colors.black,
                  ),
                  onTap: () =>
                      uiController.updateCurrentAppRoute(AppRoute.AboutPage),
                ),
              if (uiController.currentAppRoute.value == AppRoute.Settings)
                Padding(padding: const EdgeInsets.only(right: 20.0)),
              InkWell(
                child: Icon(
                  uiController.currentAppRoute.value.icon,
                  size: 32.0,
                  color: Colors.black,
                ),
                onTap: uiController.currentAppRoute.value.onClick,
              )
            ],
          )
        ],
      );
    });
  }
}

class ClickableTextWidget extends StatelessWidget {
  ClickableTextWidget({
    this.text,
    this.textStyle,
    this.onClick,
  });

  final String text;
  final TextStyle textStyle;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: textStyle,
        recognizer: TapGestureRecognizer()..onTap = onClick,
      ),
    );
  }
}
