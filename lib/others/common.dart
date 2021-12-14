import '../imports.dart';
import '../imports_conflicts.dart';

Directory appPrivDir;
Directory appPrivDocsDir;
Directory tempDir;
Directory metaDir = Directory(dataDir + '/meta');
Directory trackersDir = Directory(dataDir + '/trackers');
AndroidDeviceInfo deviceInfo;
bool isZeroNetInstalledm = false;
bool isZeroNetDownloadedm = false;
bool isDownloadExec = false;
bool canLaunchUrl = false;
bool firstTime = true;
bool kIsPlayStoreInstall = false;
bool kEnableInAppPurchases = !kDebugMode && kIsPlayStoreInstall;
bool kEnableCryptoPurchases = false;
bool manuallyStoppedZeroNet = false;
bool zeroNetStartedFromBoot = true;
bool isExecPermitted = false;
bool debugZeroNetCode = false;
bool vibrateonZeroNetStart = false;
bool enableZeroNetAddTrackers = false;
int downloadStatus = 0;
Map downloadsMap = {};
Map downloadStatusMap = {};
PackageInfo packageInfo;
String appVersion = '';
String buildNumber;
var zeroNetState = state.NONE;
Client client = Client();
String arch;
Box<dynamic> variableBox;
String appNativeDir = '';
String zeroNetIPwithPort(String url) =>
    url.replaceAll('http:', '').replaceAll('/', '').replaceAll('s', '');
String sesionKey = '';
String browserUrl = 'https://google.com';
String zeroBrowserTheme = 'light';
String snackMessage = '';

String downloadLink(String item) =>
    releases + 'Android_Module_Binaries/$item.zip';

bool isUsrBinExists() => Directory(dataDir + '/usr').existsSync();
String downloadingMetaDir(String tempDir, String name, String key) =>
    Directory(tempDir + '/meta/$name.$key.downloading').path;
String downloadedMetaDir(String tempDir, String name) =>
    Directory(tempDir + '/meta/$name.downloaded').path;
String installingMetaDir(String tempDir, String name, String key) =>
    Directory(tempDir + '/meta/$name.$key.installing').path;
String installedMetaDir(String dir, String name) =>
    Directory(dir + '/$name.installed').path;
Duration secs(int sec) => Duration(seconds: sec);
List<String> files(String arch) => [
      'python38_$arch',
      'site_packages_common',
    ];

init() async {
  firstTime = variableBox.get('firstTime', defaultValue: true);
  getArch();
  kIsPlayStoreInstall = await isPlayStoreInstall();
  appNativeDir = await getNativeDir();
  tempDir = await getTemporaryDirectory();
  appPrivDir = await getExternalStorageDirectory();
  appPrivDocsDir = await getApplicationDocumentsDirectory();
  isZeroNetInstalledm = await isZeroNetInstalled();
  if (isZeroNetInstalledm) {
    varController.isZeroNetInstalled(isZeroNetInstalledm);
    checkForAppUpdates();
    projectController.loadCodeTemplates();
    projectController.loadFileIcons();
  }
  if (!tempDir.existsSync()) tempDir.createSync(recursive: true);
  Purchases.setup("ShCpAJsKdJrAAQawcMQSswqTyPWFMwXb");
}

Future<FilePickerResult> pickFile({List<String> fileExts}) async {
  FilePickerResult result = await FilePicker.platform.pickFiles(
    type: FileType.any,
    allowedExtensions: fileExts,
  );

  return result;
}

check() async {
  if (!isZeroNetInstalledm) {
    if (isZeroNetDownloadedm) {
      if (isZeroNetInstalledm) {
        varController.setLoadingStatus('ZeroNet Installed');
        varController.isZeroNetInstalled(isZeroNetInstalledm);
        printOut('isZeroNetInstalledm');
      } else {
        isZeroNetInstalled().then((onValue) async {
          isZeroNetInstalledm = onValue;
          varController.isZeroNetInstalled(onValue);
          if (!isZeroNetInstalledm) {
            if (!unZipIsolateBound) bindUnZipIsolate();
            unZipinBg();
          }
        });
      }
    } else {
      isZeroNetInstalledm = await isZeroNetInstalled();
      if (!isZeroNetInstalledm) {
        isZeroNetDownloadedm = await isZeroNetDownloaded();
        if (isZeroNetDownloadedm) {
          varController.isZeroNetDownloaded(true);
        } else {
          varController.setLoadingStatus(downloading);
          if (!isDownloadExec) {
            if (await isModuleInstallSupported() &&
                kEnableDynamicModules &&
                await isPlayStoreInstall()) {
              await initSplitInstall();
              printOut(
                'PlayStore Module Install Supported',
                lineBreaks: 3,
                isNative: true,
              );
              if (await isRequiredModulesInstalled()) {
                printOut(
                  'Required Modules are Installed',
                  lineBreaks: 3,
                  isNative: true,
                );
                if (await copyAssetsToCache()) {
                  printOut(
                    'Assets Copied to Cache',
                    lineBreaks: 3,
                    isNative: true,
                  );
                  isZeroNetDownloadedm = true;
                  varController.setLoadingStatus(installing);
                  varController.setLoadingPercent(0);
                  check();
                }
              } else {
                printOut(
                  'Required Modules are not Installed, Installing',
                  lineBreaks: 3,
                  isNative: true,
                );
                handleModuleDownloadStatus();
              }
            } else {
              await initDownloadParams();
              downloadBins();
            }
          }
        }
      } else {
        varController.isZeroNetInstalled(true);
      }
    }
  }
}
