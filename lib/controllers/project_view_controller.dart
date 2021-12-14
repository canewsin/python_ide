import '../imports.dart';
import '../imports_conflicts.dart';

class ProjectViewController extends GetxController {
  var openedFiles = <ProjectFile>[].obs;
  var currentFile = ProjectFile().obs;
  Project currentProject;
  var currentProjectFiles = <ProjectFile>[].obs;
  var createFileNameText = ''.obs;

  void addCurrentProject(ProjectFile file) {
    if (!currentProjectFiles.contains(file)) {
      currentProjectFiles.add(file);
    }
  }

  void openFile(ProjectFile file) {
    if (!openedFiles.contains(file)) {
      openedFiles.insert(0, file);
      changeCurrentFile(file);
    }
  }

  void closeAllFiles() {
    openedFiles.clear();
    if (openedFiles.isEmpty) changeCurrentFile(ProjectFile());
  }

  void closeFile(ProjectFile file) {
    openedFiles.remove(file);
    if (openedFiles.isEmpty) {
      changeCurrentFile(ProjectFile());
    } else {
      changeCurrentFile(openedFiles.first);
    }
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
    currentProjectFiles.clear();
    uiController.updateCurrentAppRoute(AppRoute.Home);
  }
}

final projectViewController = Get.put(ProjectViewController());
