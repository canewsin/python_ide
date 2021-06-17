import '../imports.dart';

const MethodChannel _channel = const MethodChannel('in.canews.pythonide');
const EventChannel _events_channel =
    const EventChannel('in.canews.pythonide/installModules');

Future<bool> askBatteryOptimisation() async =>
    await _channel.invokeMethod('batteryOptimisations');

Future<bool> isPlayStoreInstall() async =>
    await _channel.invokeMethod('isPlayStoreInstall');

Future<bool> isBatteryOptimised() async =>
    await _channel.invokeMethod('isBatteryOptimized');

Future<bool> moveTaskToBack() async =>
    await _channel.invokeMethod('moveTaskToBack');

Future<bool> isModuleInstallSupported() async =>
    await _channel.invokeMethod('isModuleInstallSupported');

Future<bool> isRequiredModulesInstalled() async =>
    await _channel.invokeMethod('isRequiredModulesInstalled');

Future<bool> copyAssetsToCache() async =>
    await _channel.invokeMethod('copyAssetsToCache');

Future<String> getAppInstallTime() async =>
    await _channel.invokeMethod('getAppInstallTime');

Future<String> getAppLastUpdateTime() async =>
    await _channel.invokeMethod('getAppLastUpdateTime');

Future<bool> initSplitInstall() async =>
    await _channel.invokeMethod('initSplitInstall');

void uninstallModules() async =>
    await _channel.invokeMethod('uninstallModules');

void nativePrint(String log) => _channel.invokeMethod('nativePrint', log);

getNativeDir() async => await _channel.invokeMethod('nativeDir');

void handleModuleDownloadStatus() {
  _events_channel.receiveBroadcastStream().listen((onData) {
    Map data = json.decode(onData);
    final status = data['status'];
    if (status == 2) {
      final downloaded = data['downloaded'];
      final total = data['total'];
      double percentage = downloaded / total;
      varController.setLoadingPercent(percentage.toInt());
    }
    printOut(onData, lineBreaks: 2, isNative: true);
    if (status == 5) check();
  });
}

getArch() async {
  if (deviceInfo == null) deviceInfo = await DeviceInfoPlugin().androidInfo;
  String archL = deviceInfo.supportedAbis[0];
  if (archL.contains('arm64'))
    arch = 'arm64';
  else if (archL.contains('armeabi'))
    arch = 'arm';
  else if (archL.contains('x86_64'))
    arch = 'x86_64';
  else if (archL.contains('x86')) arch = 'x86';
}
