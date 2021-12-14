import '../imports.dart';

const String pkgName = 'in.canews.pythonide${kDebugMode ? '.debug' : ''}';
const String dataDir = "/data/data/$pkgName/files";
const String bin = '$dataDir/usr/bin';
const String python = '$bin/python';
const String libDir = '$dataDir/usr/lib';
const String libDir64 = '$dataDir/usr/lib64';
const String downloading = 'Downloading Files';
const String installing = 'Installing ZeroNet Files';
const String facebookLink = 'https://facebook.com';
const String twitterLink = 'https://twitter.com';
const String githubLink = 'https://github.com';
const String rawGithubLink = 'https://raw.githubusercontent.com';
const String canewsInRepo = '/canewsin/ZeroNet';
const String releases = '$githubLink$canewsInRepo/releases/download/';
const String md5hashLink = '$rawGithubLink$canewsInRepo/py3-patches/md5.hashes';
const String zeroNetNotiId = 'pythonIdeiId';
const String zeroNetChannelName = 'Python3 IDE Mobile';
const String zeroNetChannelDes =
    'Shows ZeroNet Notification to Persist from closing.';
const String notificationCategory = 'ZERONET_RUNNING';
const String isolateUnZipPort = 'unzip_send_port';
const String isolateDownloadPort = 'downloader_send_port';
const String zeronetStartUpError = 'Startup error: ';
const String zeronetAlreadyRunningError =
    zeronetStartUpError + 'Can\'t open lock file';
const bool kEnableDynamicModules = !kDebugMode;

const List<String> binDirs = [
  'usr',
  'site-packages',
];
const List<String> soDirs = [
  'usr/bin',
  'usr/lib',
  'usr/lib/python3.8/lib-dynload',
  'usr/lib/python3.8/site-packages',
];
const List<AppDeveloper> appDevelopers = [
  AppDeveloper(
    name: 'PramUkesh',
    developerType: 'developer',
    profileIconLink: 'assets/developers/pramukesh.jpg',
    githubLink: '$githubLink/PramUkesh/',
    facebookLink: '$facebookLink/n.bhargavvenky',
    twitterLink: '$twitterLink/PramukeshVenky',
  ),
  AppDeveloper(
    name: 'CANewsIn',
    developerType: 'organisation',
    profileIconLink: 'assets/developers/canewsin.jpg',
    githubLink: '$githubLink/canewsin/',
    facebookLink: '$facebookLink/canews.in',
    twitterLink: '$twitterLink/canewsin',
  ),
];

const String profileSwitcher = 'Profile Switcher';
const String profileSwitcherDes =
    'Create and Use different Profiles on ZeroNet';
const String debugZeroNet = 'Debug ZeroNet Code';
const String debugZeroNetDes =
    'Useful for Developers to find bugs and errors in the code.';
const String enableZeroNetConsole = 'Enable ZeroNet Console';
const String enableZeroNetConsoleDes =
    'Useful for Developers to see the exec of ZeroNet Python code';
const String enableZeroNetFilters = 'Enable ZeroNet Filters';
const String enableZeroNetFiltersDes =
    'Enabling ZeroNet Filters blocks known ametuer content sites and spam users.';
const String enableAdditionalTrackers = 'Additional BitTorrent Trackers';
const String enableAdditionalTrackersDes =
    'Enabling External/Additional BitTorrent Trackers will give more ZeroNet Site Seeders or Clients.';
const String pluginManager = 'Plugin Manager';
const String pluginManagerDes = 'Enable/Disable ZeroNet Plugins';
const String vibrateOnZeroNetStart = 'Vibrate on ZeroNet Start';
const String vibrateOnZeroNetStartDes = 'Vibrates Phone When ZeroNet Starts';
const String enableFullScreenOnWebView = 'FullScreen for ZeroNet Zites';
const String enableFullScreenOnWebViewDes =
    'This will Enable Full Screen for in app Webview of ZeroNet';
const String batteryOptimisation = 'Disable Battery Optimisation';
const String batteryOptimisationDes =
    'This will Helps to Run App even App is in Background for long time.';
const String publicDataFolder = 'Public DataFolder';
const String publicDataFolderDes =
    'This Will Make ZeroNet Data Folder Accessible via File Manager.';
const String autoStartZeroNet = 'AutoStart ZeroNet';
const String autoStartZeroNetDes =
    'This Will Make ZeroNet Auto Start on App Start, So you don\'t have to click Start Button Every Time on App Start.';
const String autoStartZeroNetonBoot = 'AutoStart ZeroNet on Boot';
const String autoStartZeroNetonBootDes =
    'This Will Make ZeroNet Auto Start on Device Boot.';
