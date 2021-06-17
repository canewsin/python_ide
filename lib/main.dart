import 'imports.dart';
import 'imports_conflicts.dart';

//TODO:Remainder: Removed Half baked x86 bins, add them when we support x86 platform
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  variableBox = await Hive.openBox('variableBox');
  await init();
  if (kEnableInAppPurchases) {
    InAppPurchaseConnection.enablePendingPurchases();
    final Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    purchaseUpdates.listen((purchases) => listenToPurchaseUpdated(purchases));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(
          () {
            if (varController.zeroNetInstalled.value) {
              if (firstTime) {
                SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                // uiController.updateCurrentAppRoute(AppRoute.Settings);
                if (!isExecPermitted)
                  makeExecHelper().then(
                    (value) => isExecPermitted = value,
                  );
                variableBox.put('firstTime', false);
              }
              projectController.loadExistingProjects();
              return Obx(
                () {
                  switch (uiController.currentAppRoute.value) {
                    case AppRoute.AboutPage:
                      return WillPopScope(
                        onWillPop: () {
                          uiController.updateCurrentAppRoute(AppRoute.Home);
                          return Future.value(false);
                        },
                        child: AboutPage(),
                      );
                      break;
                    case AppRoute.ProjectViewPage:
                      return WillPopScope(
                        onWillPop: () {
                          uiController.updateCurrentAppRoute(AppRoute.Home);
                          projectViewController.closeProject();
                          return Future.value(false);
                        },
                        child: ProjectViewPage(),
                      );
                      break;
                    case AppRoute.Home:
                      getInAppPurchases();
                      return HomePage();
                      break;
                    case AppRoute.Settings:
                      return WillPopScope(
                        onWillPop: () {
                          uiController.updateCurrentAppRoute(AppRoute.Home);
                          return Future.value(false);
                        },
                        child: SettingsPage(),
                      );
                      break;
                    case AppRoute.LogPage:
                      return WillPopScope(
                        onWillPop: () {
                          uiController.updateCurrentAppRoute(AppRoute.Home);
                          return Future.value(false);
                        },
                        child: ZeroNetLogPage(),
                      );
                      break;
                    default:
                      return Container();
                  }
                },
              );
            } else
              return Loading();
          },
        ),
      ),
    );
  }
}
