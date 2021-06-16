import '../imports.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(24)),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                children: <Widget>[
                  ZeroNetAppBar(),
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 30),
                  // ),
                  // ListView.builder(
                  //   physics: BouncingScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: Utils.defSettings.keys.length,
                  //   itemBuilder: (ctx, i) {
                  //     // Setting current =
                  //     //     Utils.defSettings[Utils.defSettings.keys.toList()[i]];
                  //     if (current.name == enableZeroNetFilters && firstTime) {
                  //       return Container();
                  //     }
                  //     return SettingsCard(
                  //       setting: current,
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
