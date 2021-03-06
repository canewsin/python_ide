import '../imports.dart';
import '../imports_conflicts.dart';

class ProjectViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(24)),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    children: <Widget>[
                      ZeroNetAppBar(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                      Obx(() {
                        var openedFiles = projectViewController.openedFiles;
                        var length = openedFiles.length;
                        return Container(
                          width: Get.width,
                          height: 40.0,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: openedFiles.isEmpty ? 1 : length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              if (openedFiles.isEmpty)
                                return ProjectFileTabView();
                              return ProjectFileTabView(
                                projectFile: openedFiles[i],
                              );
                            },
                          ),
                        );
                      }),
                      Obx(() {
                        var currentFile =
                            projectViewController.currentFile.value;
                        return Column(
                          children: [
                            if (currentFile.name == null)
                              ProjectFileExplorerView()
                            else
                              ProjectFileView(),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(
              bottom: 20.0,
              right: 20.0,
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                switch (processController.status.value) {
                  case ProcessStatus.Idle:
                    Timer(Duration(milliseconds: 500), () {
                      processController.clearConsoleLog();
                      processController
                          .changeProcessStatus(ProcessStatus.Running);
                      var pPath = '';
                      if (projectViewController.currentFile.value.name ==
                              null ||
                          projectViewController.currentFile.value.isPropsFile) {
                        pPath = projectViewController.currentProject.path +
                            '/' +
                            projectViewController.currentProject.program;
                      } else {
                        pPath = projectViewController.currentFile.value.path;
                      }
                      processController.runProcess(pPath);
                    });
                    Get.bottomSheet(
                      ConsoleLogWidget(),
                    ).whenComplete(() => processController.clearConsoleLog());
                    break;
                  case ProcessStatus.Running:
                    processController.changeProcessStatus(ProcessStatus.Paused);
                    break;
                  case ProcessStatus.Paused:
                    processController.changeProcessStatus(ProcessStatus.Stoped);
                    break;
                  case ProcessStatus.Stoped:
                    processController
                        .changeProcessStatus(ProcessStatus.Completed);
                    break;
                  case ProcessStatus.Completed:
                    processController.changeProcessStatus(ProcessStatus.Idle);
                    break;
                  default:
                }
              },
              label: Row(
                children: [
                  Obx(() {
                    return processController.status.value.icon;
                  }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Obx(() => Text(processController.status.value.text)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConsoleLogWidget extends StatelessWidget {
  const ConsoleLogWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      constraints: BoxConstraints(
        minHeight: Get.height * .25,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 8.0,
                  width: Get.width * 0.25,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                Text(
                  'Console Log',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Text(
              processController.consoleLog.value.isEmpty
                  ? 'Running..., Please Wait!'
                  : processController.consoleLog.value,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectFileTabView extends StatelessWidget {
  final ProjectFile projectFile;
  const ProjectFileTabView({
    Key key,
    this.projectFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 1.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 0.0,
            ),
            child: Text(
              projectFile == null ? 'Project Files' : projectFile.name,
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              projectViewController.closeFile(projectFile);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
    );
  }
}

class ProjectFileExplorerView extends StatelessWidget {
  const ProjectFileExplorerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 140.0,
      width: Get.width,
      color: Colors.grey.shade300,
      child: Column(
        children: [
          Builder(
            builder: (ctx) {
              List<ProjectFile> files = [];
              Directory projectDir =
                  Directory(projectViewController.currentProject.path);
              var filesList = projectDir.listSync();
              for (var item in filesList) {
                files.add(
                  ProjectFile(
                    name: item.name(),
                    path: item.path,
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: files.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        projectViewController.openFile(files[i]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                          left: 16.0,
                          right: 16.0,
                        ),
                        height: 25,
                        child: Builder(
                          builder: (ctx) {
                            bool isFileIconSupported = false;
                            FileIcon fileIcon;
                            var fileIconList =
                                projectController.fileIcons.where(
                              (element) => element.supportedExt.contains(
                                File(files[i].path).fileExtension,
                              ),
                            );
                            if (fileIconList.isNotEmpty) {
                              fileIcon = fileIconList.first;
                              isFileIconSupported = true;
                            }
                            return Row(
                              children: [
                                if (!isFileIconSupported)
                                  Icon(Icons.file_present_rounded),
                                if (isFileIconSupported)
                                  SvgPicture.asset(
                                    'assets/fileicons/${fileIcon.fileName}',
                                    semanticsLabel: fileIcon.name,
                                  ),
                                SizedBox(width: 10.0),
                                Text(files[i].name),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectFileView extends StatelessWidget {
  const ProjectFileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var currentFile = projectViewController.currentFile;
      File f = File(currentFile.value.path);
      var content = f.readAsStringSync();
      return Stack(
        children: [
          Container(
            height: Get.height - 140.0,
            width: Get.width,
            color: Colors.grey.shade300,
            padding: const EdgeInsets.all(4.0),
            child: currentFile.value.path.endsWith('project.props')
                ? JsonViewerWidget(json.decode(content))
                : Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Obx(
                      () => projectViewController.currentFile.value.isInEditMode
                          ? Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                top: 4.0,
                              ),
                              child: TextFormField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                ),
                                initialValue: content,
                                minLines: 150,
                                maxLines: 150,
                                onChanged: (txt) {
                                  projectFileController.currentFileText.value =
                                      txt;
                                },
                                style: TextStyle(
                                  fontFamily: 'LucidaSansDemiBold',
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                              ),
                            )
                          : HighlightView(
                              content,
                              language: 'python',
                              theme: githubTheme,
                              padding: EdgeInsets.all(12),
                              textStyle: TextStyle(
                                fontFamily: 'LucidaSansDemiBold',
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
          ),
          if (projectViewController.currentFile.value?.path?.endsWith('.py'))
            Align(
              alignment: Alignment.topRight,
              child: Obx(
                () => Container(
                  margin: EdgeInsets.only(left: Get.width * 0.66),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: Icon(
                          projectViewController.currentFile.value.isInEditMode
                              ? Icons.edit_off_outlined
                              : Icons.edit_outlined,
                        ),
                        onPressed: () {
                          projectFileController.currentFileText.value = content;
                          projectViewController.changeCurrentFileEditMode(
                            projectViewController.currentFile.value,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.save_outlined),
                        onPressed: !(projectViewController
                                .currentFile.value.isInEditMode)
                            ? null
                            : () {
                                projectFileController.saveCurrentFileContent(
                                    projectFileController
                                        .currentFileText.value);
                                projectViewController.changeCurrentFileEditMode(
                                  projectViewController.currentFile.value,
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      );
    });
  }
}
