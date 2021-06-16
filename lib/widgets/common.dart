import '../imports.dart';

class ZeroNetAppBar extends StatelessWidget {
  const ZeroNetAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            uiStore.currentAppRoute.title,
            style: GoogleFonts.roboto(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              if (uiStore.currentAppRoute == AppRoute.Settings)
                InkWell(
                  child: Icon(
                    OMIcons.info,
                    size: 32.0,
                    color: Colors.black,
                  ),
                  onTap: () =>
                      uiStore.updateCurrentAppRoute(AppRoute.AboutPage),
                ),
              if (uiStore.currentAppRoute == AppRoute.Settings)
                Padding(padding: const EdgeInsets.only(right: 20.0)),
              InkWell(
                child: Icon(
                  uiStore.currentAppRoute.icon,
                  size: 32.0,
                  color: Colors.black,
                ),
                onTap: uiStore.currentAppRoute.onClick,
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
