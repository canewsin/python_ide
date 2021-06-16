import '../imports.dart';
import '../imports_conflicts.dart';

class ProjectViewController extends GetxController {
  var openedFiles = <ProjectFile>[].obs;
  var currentFile = ProjectFile().obs;
  Project currentProject;

  void openFile(ProjectFile file) {
    if (!openedFiles.contains(file)) {
      openedFiles.add(file);
      changeCurrentFile(file);
    }
  }

  void closeAllFiles() {
    openedFiles.clear();
    if (openedFiles.isEmpty) changeCurrentFile(ProjectFile());
  }

  void closeFile(ProjectFile file) {
    openedFiles.remove(file);
    if (openedFiles.isEmpty) changeCurrentFile(ProjectFile());
  }

  void changeCurrentFile(ProjectFile file) {
    currentFile.update((val) {
      val.name = file.name;
      val.path = file.path;
    });
  }

  void changeCurrentFileEditMode(ProjectFile file) {
    currentFile.update((val) {
      val.name = file.name;
      val.path = file.path;
      val.isInEditMode = !val.isInEditMode;
    });
  }

  void closeProject() {
    currentProject = null;
    processController.clearConsoleLog();
    closeAllFiles();
    uiStore.updateCurrentAppRoute(AppRoute.Home);
  }
}

final projectViewController = Get.put(ProjectViewController());
