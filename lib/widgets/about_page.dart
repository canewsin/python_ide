import '../imports.dart';
import '../imports_conflicts.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        uiController.updateCurrentAppRoute(AppRoute.Home);
        return Future.value(false);
      },
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(24)),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZeroNetAppBar(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          logoPath,
                          width: 100.0,
                          height: 100.0,
                        ),
                        Padding(padding: const EdgeInsets.all(8.0)),
                        Flexible(
                          child: Container(
                            child: Text(
                              appDescription1,
                              style: GoogleFonts.roboto(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text.rich(
                        TextSpan(
                          text: appDescription2,
                          style: GoogleFonts.roboto(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: zeronetWebLink,
                              style: GoogleFonts.roboto(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Color(0xFF8663FF),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(zeronetWebLink);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                    ),
                    DeveloperWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    DonationWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Text(
                      contribute,
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                    ),
                    Text(
                      contributeDescription,
                      style: GoogleFonts.roboto(
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DonationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          donationAddressTitle,
          style: GoogleFonts.roboto(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
        ),
        if (kEnableCryptoPurchases)
          LayoutBuilder(
            builder: (ctx, cons) {
              List<Widget> children = [];
              for (var crypto in donationsAddressMap.keys) {
                children.add(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crypto,
                        style: GoogleFonts.roboto(
                          fontSize: 16.0,
                        ),
                      ),
                      ClickableTextWidget(
                        text: donationsAddressMap[crypto],
                        textStyle: GoogleFonts.roboto(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: Color(0xFF8663FF),
                          decoration: TextDecoration.underline,
                        ),
                        onClick: () {
                          FlutterClipboard.copy(donationsAddressMap[crypto]);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '$crypto Donation Address Copied to Clipboard',
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                      )
                    ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              );
            },
          ),
        if (kEnableCryptoPurchases)
          Flexible(
            child: Text(
              clickAddToCopy,
              style: GoogleFonts.roboto(
                fontSize: 16.0,
              ),
            ),
          ),
        if (kEnableCryptoPurchases)
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        if (kEnableInAppPurchases) GooglePlayInAppPurchases(),
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        Flexible(
          child: Text(
            donationDescription,
            style: GoogleFonts.roboto(
              fontSize: 16.0,
            ),
          ),
        )
      ],
    );
  }
}

class DeveloperWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          developers,
          style: GoogleFonts.roboto(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: const EdgeInsets.all(4.0)),
        LayoutBuilder(
          builder: (ctx, cons) {
            List<Widget> children = [];
            for (var developer in appDevelopers) {
              children.add(
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4.0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                ExactAssetImage(developer.profileIconLink),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                developer.name + '(${developer.developerType})',
                                style: GoogleFonts.roboto(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              LayoutBuilder(builder: (context, cons) {
                                List<Widget> children = [];
                                final iconsPath = 'assets/icons';
                                List<String> assets = [
                                  '$iconsPath/github_dark.png',
                                  '$iconsPath/twitter_dark.png',
                                  '$iconsPath/facebook_dark.png',
                                ];
                                List<String> links = [
                                  developer.githubLink,
                                  developer.twitterLink,
                                  developer.facebookLink,
                                ];
                                for (var item in assets) {
                                  children.add(InkWell(
                                    onTap: () {
                                      var i = assets.indexOf(item);
                                      launch(links[i]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Image.asset(
                                        item,
                                        height: 30.0,
                                        width: 30.0,
                                      ),
                                    ),
                                  ));
                                }
                                return Row(
                                  children: children,
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: children,
            );
          },
        ),
      ],
    );
  }
}

class GooglePlayInAppPurchases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'Google Play Purchases ',
              children: [
                TextSpan(
                  text: '(30% taken by Google) :',
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                  ),
                ),
              ],
              style: GoogleFonts.roboto(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(() {
            List<Widget> mChildren = [];
            Map<String, List<Package>> googlePurchasesTypes = {
              'One Time': purchasesController.oneTimePurchases,
              'Monthly Subscriptions': purchasesController.subscriptions,
            };
            for (var item in googlePurchasesTypes.keys) {
              List<Package> purchases = googlePurchasesTypes[item];
              purchases
                ..sort((item1, item2) {
                  int item1I1 = item1.identifier.lastIndexOf('_') + 1;
                  int item1I2 = item1.identifier.lastIndexOf('.');
                  String item1PriceStr =
                      item1.identifier.substring(item1I1, item1I2);
                  int item1Price = int.parse(item1PriceStr);
                  int item2I1 = item2.identifier.lastIndexOf('_') + 1;
                  int item2I2 = item2.identifier.lastIndexOf('.');
                  String item2PriceStr =
                      item2.identifier.substring(item2I1, item2I2);
                  int item2Price = int.parse(item2PriceStr);
                  return item1Price < item2Price ? -1 : 1;
                });
              if (purchases.length > 0) {
                List<Widget> children = [];
                for (var package in purchases) {
                  var i = purchases.indexOf(package);
                  Color c = Color(0xFF);
                  String label = '';
                  switch (i) {
                    case 0:
                      label = 'Tip';
                      c = Color(0xFF06CAB6);
                      break;
                    case 1:
                      label = 'Coffee';
                      c = Color(0xFF0696CA);
                      break;
                    case 2:
                      label = 'Lunch';
                      c = Color(0xFFCA067B);
                      break;
                    default:
                  }
                  children.add(
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: Text(
                          "$label(${package.product.priceString})",
                          style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      color: c,
                      onPressed: () => purchasePackage(package),
                    ),
                  );
                }
                mChildren.add(
                  Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(8.0)),
                      Text(
                        item,
                        style: GoogleFonts.roboto(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(8.0)),
                      Center(
                        child: Wrap(
                          spacing: 25.0,
                          runSpacing: 10.0,
                          alignment: WrapAlignment.spaceEvenly,
                          children: children,
                        ),
                      )
                    ],
                  ),
                );
              }
            }
            return Column(
              children: mChildren,
            );
          })
        ],
      ),
    );
  }
}
