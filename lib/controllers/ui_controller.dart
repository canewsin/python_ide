import '../imports_conflicts.dart';
import '../imports.dart';

class UiController extends GetxController {
  PersistentBottomSheetController currentBottomSheetController;

  var appUpdate = AppUpdate.NOT_AVAILABLE.obs;

  void updateInAppUpdateAvailable(AppUpdate available) =>
      appUpdate.value = available;

  var showSnackReply = false.obs;

  void updateShowSnackReply(bool show) {
    showSnackReply.value = show;
  }

  var reload = 0.obs;

  void updateReload(int i) {
    reload.value = i;
  }

  var currentAppRoute = AppRoute.Home.obs;

  void updateCurrentAppRoute(AppRoute appRoute) =>
      currentAppRoute.value = appRoute;

  var currentTheme = AppTheme.Light.obs;

  void setTheme(AppTheme theme) {
    currentTheme.value = theme;
  }
}

final uiController = Get.put(UiController());
