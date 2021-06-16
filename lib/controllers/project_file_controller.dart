import '../imports.dart';
import '../imports_conflicts.dart';

class ProjectFileController extends GetxController {
  var currentFileText = ''.obs;

  void saveCurrentFileContent(String text) {
    File currentFile = File(projectViewController.currentFile.value.path);
    currentFile.writeAsStringSync(text);
  }
}

final projectFileController = Get.put(ProjectFileController());
