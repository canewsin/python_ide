import '../imports.dart';

enum AppUpdate {
  NOT_AVAILABLE,
  AVAILABLE,
  DOWNLOADING,
  DOWNLOADED,
  INSTALLING,
}

extension AppUpdateExt on AppUpdate {
  get text {
    switch (uiStore.appUpdate) {
      case AppUpdate.AVAILABLE:
        return 'Update';
        break;
      case AppUpdate.DOWNLOADING:
        return 'Downloading';
        break;
      case AppUpdate.DOWNLOADED:
        return 'Downloaded';
        break;
      case AppUpdate.INSTALLING:
        return 'Installing';
        break;
      default:
        return 'Not Available';
    }
  }

  void action() {
    switch (uiStore.appUpdate) {
      case AppUpdate.AVAILABLE:
        {
          // InAppUpdate.performImmediateUpdate().then((value) =>
          //     uiStore.updateInAppUpdateAvailable(AppUpdate.NOT_AVAILABLE));
          //TODO: Switch to startFlexibleUpdate() when below issue is Fixed.
          //https://github.com/feilfeilundfeil/flutter_in_app_update/issues/42
          InAppUpdate.startFlexibleUpdate().then((value) =>
              uiStore.updateInAppUpdateAvailable(AppUpdate.DOWNLOADED));
          uiStore.updateInAppUpdateAvailable(AppUpdate.DOWNLOADING);
        }
        break;
      case AppUpdate.DOWNLOADED:
        {
          InAppUpdate.completeFlexibleUpdate().then((value) =>
              uiStore.updateInAppUpdateAvailable(AppUpdate.NOT_AVAILABLE));
          uiStore.updateInAppUpdateAvailable(AppUpdate.INSTALLING);
        }
        break;
      default:
    }
  }
}

enum AppRoute {
  Home,
  ProjectViewPage,
  Settings,
  ZeroBrowser,
  LogPage,
  AboutPage,
}

extension AppRouteExt on AppRoute {
  get title {
    switch (this) {
      case AppRoute.AboutPage:
        return 'About';
        break;
      case AppRoute.Home:
        return appTitle;
        break;
      case AppRoute.Settings:
        return 'Settings';
        break;
      case AppRoute.ProjectViewPage:
        return projectViewController.currentProject?.name ?? 'Project Name';
        break;
      case AppRoute.ZeroBrowser:
        return 'ZeroBrowser';
        break;
      case AppRoute.LogPage:
        return 'ZeroNet Log';
        break;
      default:
    }
  }

  IconData get icon {
    switch (this) {
      case AppRoute.AboutPage:
      case AppRoute.Settings:
      case AppRoute.ZeroBrowser:
      case AppRoute.LogPage:
        return OMIcons.home;
        break;
      case AppRoute.Home:
        return OMIcons.info;
        // return OMIcons.settings;
        break;
      case AppRoute.ProjectViewPage:
        return OMIcons.close;
        break;
      case AppRoute.ProjectViewPage:
        return OMIcons.close;
        break;
      default:
        return OMIcons.error;
    }
  }

  void onClick() {
    switch (uiStore.currentAppRoute) {
      case AppRoute.Home:
        uiStore.updateCurrentAppRoute(AppRoute.AboutPage);
        // uiStore.updateCurrentAppRoute(AppRoute.Settings);
        break;
      case AppRoute.AboutPage:
      case AppRoute.Settings:
      case AppRoute.LogPage:
      case AppRoute.ZeroBrowser:
        uiStore.updateCurrentAppRoute(AppRoute.Home);
        break;
      case AppRoute.ProjectViewPage:
        projectViewController.closeProject();
        break;
      default:
    }
  }
}

enum AppTheme {
  Light,
  Dark,
  Black,
}

enum ProcessStatus {
  Running,
  Completed,
  Idle,
  Paused,
  Stoped,
  Error,
}

extension ProcessStatusExt on ProcessStatus {
  String get text {
    switch (this) {
      case ProcessStatus.Idle:
      case ProcessStatus.Completed:
        return 'Run';
        break;
      case ProcessStatus.Paused:
        return 'Resume';
        break;
      case ProcessStatus.Stoped:
        return 'Stopped';
        break;
      case ProcessStatus.Running:
        return 'Pause';
        break;
      case ProcessStatus.Error:
        return 'Error';
        break;
      default:
        return 'Implement This Text';
    }
  }

  Icon get icon {
    switch (this) {
      case ProcessStatus.Idle:
      case ProcessStatus.Stoped:
      case ProcessStatus.Paused:
      case ProcessStatus.Completed:
        return Icon(Icons.play_arrow_outlined);
        break;
      case ProcessStatus.Running:
        return Icon(Icons.pause);
        break;
      default:
        return Icon(Icons.error);
    }
  }
}
