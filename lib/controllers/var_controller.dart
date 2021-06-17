import '../imports.dart';
import '../imports_conflicts.dart';

class VarController extends GetxController {
  String zeroNetWrapperKey = '';

  var event = ObservableEvent.installed.obs;

  void setObservableEvent(ObservableEvent eve) {
    event.value = eve;
  }

  var zeroNetLog = 'ZeroNet Mobile'.obs;

  void setZeroNetLog(String status) {
    zeroNetLog.value = status;
  }

  var zeroNetAppbarStatus = 'ZeroNet Mobile'.obs;

  void setZeroNetAppbarStatus(String status) {
    zeroNetAppbarStatus.value = status;
  }

  var zeroNetStatus = 'Not Running'.obs;

  void setZeroNetStatus(String status) {
    zeroNetStatus.value = status;
  }

  var zeroNetInstalled = false.obs;

  void isZeroNetInstalled(bool installed) {
    zeroNetInstalled.value = installed;
  }

  var zeroNetDownloaded = false.obs;

  void isZeroNetDownloaded(bool downloaded) {
    zeroNetDownloaded.value = downloaded;
  }

  var loadingStatus = 'Loading'.obs;

  void setLoadingStatus(String status) {
    loadingStatus.value = status;
  }

  var loadingPercent = 0.obs;

  void setLoadingPercent(int percent) {
    loadingPercent.value = percent;
  }
}

final varController = Get.put(VarController());
