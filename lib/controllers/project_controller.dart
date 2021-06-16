import '../imports.dart';
import '../imports_conflicts.dart';

class ProjectController extends GetxController {
  var projects = <Project>[Project(id: null)].obs;
  List<CodeTemplate> templates = [];
  List<FileIcon> fileIcons = [];
  var currentTemplate = 'helloworld.py'.obs;

  var createdNewProjectName = ''.obs;
  var createdNewProjectPath = ''.obs;

  void loadCodeTemplates() async {
    var templatesStr = await rootBundle.loadString(
      'assets/templates/python/templates.json',
    );
    var templateMap = json.decode(templatesStr);

    for (var item in (templateMap as Map).keys) {
      var codeTemplate = CodeTemplate().fromMap(item, templateMap[item]);
      templates.add(codeTemplate);
    }
  }

  void loadFileIcons() async {
    var templatesStr = await rootBundle.loadString(
      'assets/fileicons/fileicons.json',
    );
    var iconsMap = json.decode(templatesStr);

    for (var item in (iconsMap as Map).keys) {
      var codeTemplate = FileIcon().fromMap(item, iconsMap[item]);
      fileIcons.add(codeTemplate);
    }
  }

  void loadExistingProjects() {
    Directory projectsDirectory = Directory(appPrivDocsDir.path + '/Projects');
    if (!projectsDirectory.existsSync()) {
      return;
    }
    File projectsFile = File(projectsDirectory.path + '/Projects.json');
    if (projectsFile.existsSync()) {
      var projectsList = json.decode(projectsFile.readAsStringSync());
      for (Map project in projectsList) {
        var projectLoaded = loadProjectFromPath(project[project.keys.first]);
        addProjectToList(projectLoaded);
      }
    }
  }

  Project loadProjectFromPath(String path) {
    File propsFile = File(path + '/project.props');
    Project project;
    if (propsFile.existsSync()) {
      project = Project().fromMap(json.decode(propsFile.readAsStringSync()));
    }
    return project;
  }

  void addProjectToList(Project project) {
    if (projects.where((p) => p.id == project.id).isEmpty)
      projects.add(project);
  }

  void addProject(Project project) {
    addProjectToList(project);
    saveToExistingProjects(project);
  }

  void removeProject(String id) {
    loadExistingProjects();
    removeProjectFromList(id);
  }

  void removeProjectFromList(String id) {
    var projectsLoaded = projects.where((p) => p.id == id);
    if (projectsLoaded.isNotEmpty) {
      var project = projectsLoaded.first;
      removeProjectFromFileSystem(project.id);
      projects.remove(project);
    }
  }

  void removeProjectFromFileSystem(String id) {
    Directory projectsDirectory = Directory(appPrivDocsDir.path + '/Projects');
    File projectsFile = File(projectsDirectory.path + '/Projects.json');
    List<Map> list = [];
    for (var project in projects) {
      if (project.id != null && id != project.id)
        list.add({project.id: project.path});
      if (id == project.id) {
        Directory projDir = Directory(project.path);
        projDir.deleteSync(recursive: true);
      }
    }
    projectsFile.writeAsStringSync(json.encode(list));
  }

  void saveToExistingProjects(Project project) {
    Directory projectsDirectory = Directory(appPrivDocsDir.path + '/Projects');
    File projectsFile = File(projectsDirectory.path + '/Projects.json');
    List<Map> list = [];
    if (!projectsFile.existsSync()) {
      projectsFile.createSync(recursive: true);
      list.add({project.id: project.path});
    } else {
      loadExistingProjects();
      for (var project in projects) {
        if (project.id != null) list.add({project.id: project.path});
      }
    }
    projectsFile.writeAsStringSync(json.encode(list));
  }

  String getProjectName(String name) {
    if (name.contains(' ')) {
      List<String> parts = name.split(' ');
      return parts.join('_');
    }
    return name;
  }

  String getProjectPath(String name, Directory directory) {
    String path = '';
    if (directory == null)
      path = appPrivDir.path + '/Projects/${getProjectName(name)}';
    else
      return directory.path;
    return path;
  }

  Future<bool> createProject(String name, String path) async {
    var isCreated = false;
    if (path.isEmpty || path == 'Projects/$name')
      path = appPrivDir.path + '/Projects/$name';
    var project = Project(
      id: randomAlphaNumeric(20),
      name: name,
      path: path,
      created: DateTime.now(),
      lastEdited: DateTime.now(),
      program: projectController.currentTemplate.value,
    );
    createProjectPropertiesFile(project);
    addProject(project);
    isCreated = await addTemplateToProject(project);
    return isCreated;
  }

  Future<bool> addTemplateToProject(Project project) async {
    var content = await rootBundle
        .loadString('assets/templates/python/${project.program}');
    File file = File(project.path + '/${project.program}');
    file.createSync(recursive: true);
    file.writeAsStringSync(content);
    return true;
  }

  void createProjectPropertiesFile(Project project) {
    var string = json.encode(project.toMap());
    Directory dir = Directory(project.path);
    if (dir.existsSync()) {
      throw 'Project Already Exists, Delete Existing Project to Proceed';
    } else {
      dir.createSync(recursive: true);
      File propertiesFile = File(project.path + '/project.props');
      propertiesFile.createSync();
      propertiesFile.writeAsStringSync(string);
    }
  }
}

final projectController = Get.put(ProjectController());
