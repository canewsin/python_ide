import '../imports.dart';
import '../imports_conflicts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  ProjectsView(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),
                  // PopularZeroNetSites(),
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 5),
                  // ),
                  InAppUpdateWidget(),
                  if (kIsPlayStoreInstall)
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                  if (kIsPlayStoreInstall) RatingButtonWidget(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),
                  AboutButtonWidget(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InAppUpdateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (uiController.appUpdate.value != AppUpdate.NOT_AVAILABLE)
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              appUpdateAvailable,
              style: GoogleFonts.roboto(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            RaisedButton(
              onPressed: uiController.appUpdate.value.action,
              color: Color(0xFF008297),
              padding: EdgeInsets.only(left: 10, right: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Obx(() {
                return Text(
                  uiController.appUpdate.value.text,
                  style: GoogleFonts.roboto(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ],
        );
      return Container();
    });
  }
}

class AboutButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => uiController.updateCurrentAppRoute(AppRoute.AboutPage),
      color: Color(0xFFAA5297),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        knowMore,
        style: GoogleFonts.roboto(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }
}

class RatingButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        final InAppReview inAppReview = InAppReview.instance;
        //TODO: remove this once we support non playstore reviews.
        if (await inAppReview.isAvailable() && kIsPlayStoreInstall) {
          inAppReview.requestReview();
        } else {
          //TODO: Handle this case. eg: Non-PlayStore Install, Already Reviewed Users etc.
        }
      },
      color: Color(0xFF008297),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        feedbackStr,
        style: GoogleFonts.roboto(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }
}

final TextEditingController _pathController = TextEditingController(
  text: 'Projects/',
);

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          child: Obx(
            () {
              var projects = projectController.projects;
              var length = projects.length;
              return GridView.builder(
                itemCount: length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) {
                  var project = projects[i];
                  return InkWell(
                    onTap: project.id == null
                        ? () {
                            Get.bottomSheet(
                              SizedBox(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 18.0,
                                      right: 18.0,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 60.0,
                                        ),
                                        Text(
                                          'Create New Project',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25.0,
                                        ),
                                        Container(
                                          width: Get.width,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Name : ',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: Get.width * 0.72,
                                                child: TextFormField(
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                  onChanged: (text) {
                                                    projectController
                                                        .createdNewProjectName
                                                        .value = text;
                                                    projectController
                                                            .createdNewProjectPath
                                                            .value =
                                                        'Projects/' + text;
                                                    _pathController.text =
                                                        projectController
                                                            .createdNewProjectPath
                                                            .value;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25.0,
                                        ),
                                        Container(
                                          width: Get.width,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Path : ',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: Get.width * 0.72,
                                                child: TextFormField(
                                                  controller: _pathController,
                                                  onChanged: (text) {
                                                    projectController
                                                        .createdNewProjectPath
                                                        .value = text;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        '(Optional, You can leave this as empty)',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25.0,
                                        ),
                                        Container(
                                          width: Get.width,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Template : ',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Obx(
                                                () => DropdownButton(
                                                  value: projectController
                                                      .currentTemplate.value,
                                                  items: projectController
                                                      .templates
                                                      .map<DropdownMenuItem>(
                                                        (e) => DropdownMenuItem(
                                                          child: Text(e.name),
                                                          value: e.fileName,
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (v) {
                                                    projectController
                                                        .currentTemplate
                                                        .value = v;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: Get.width,
                                          margin: const EdgeInsets.only(
                                            bottom: 18.0,
                                          ),
                                          child: Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _pathController.clear();
                                                  Get.back();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              Spacer(),
                                              Obx(
                                                () {
                                                  var projName =
                                                      projectController
                                                          .createdNewProjectName
                                                          .value;
                                                  return ElevatedButton(
                                                    onPressed: projName.isEmpty
                                                        ? null
                                                        : () {
                                                            projectController
                                                                .createProject(
                                                              projectController
                                                                  .createdNewProjectName
                                                                  .value,
                                                              projectController
                                                                  .createdNewProjectPath
                                                                  .value,
                                                            );
                                                            _pathController
                                                                .clear();
                                                            Get.back();
                                                          },
                                                    child: Text('Create'),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 18.0,
                                          ),
                                          child: Text(
                                            'Enter Your Project Details to Continue',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              isScrollControlled: true,
                            );
                          }
                        : () {
                            projectViewController.currentProject = project;
                            uiController.updateCurrentAppRoute(
                              AppRoute.ProjectViewPage,
                            );
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: project.id == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Spacer(flex: 2),
                                Icon(Icons.add),
                                Spacer(flex: 1),
                                Text(
                                  'Create New Project',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                              ],
                            )
                          : Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        Container(
                                          color: Colors.white,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 18.0,
                                              right: 18.0,
                                            ),
                                            child: Builder(
                                              builder: (context) {
                                                List<Widget> children = [
                                                  SizedBox(
                                                    height: 25.0,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Project Details',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                                for (var item
                                                    in project.propsNames) {
                                                  var value = project.props[
                                                          project.propsNames
                                                              .indexOf(
                                                    item,
                                                  )]
                                                      .toString();
                                                  if (item == 'path') {
                                                    if (value.startsWith(
                                                        appPrivDir.path)) {
                                                      value = value.substring(
                                                          appPrivDir
                                                                  .path.length +
                                                              1);
                                                    }
                                                  }
                                                  children.add(SizedBox(
                                                    height: 25.0,
                                                  ));
                                                  children.add(
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '$item : '
                                                              .capitalizeFirst,
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth:
                                                                Get.width *
                                                                    0.60,
                                                          ),
                                                          child: Text(
                                                            value,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                                children.addAll([
                                                  Spacer(),
                                                  Container(
                                                    width: Get.width,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom: 18.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: Text('Cancel'),
                                                        ),
                                                        Spacer(),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            projectController
                                                                .removeProject(
                                                              project.id,
                                                            );
                                                            Get.back();
                                                          },
                                                          child: Text('Delete'),
                                                        ),
                                                        Spacer(),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            projectViewController
                                                                    .currentProject =
                                                                project;
                                                            uiController
                                                                .updateCurrentAppRoute(
                                                              AppRoute
                                                                  .ProjectViewPage,
                                                            );
                                                            Get.back();
                                                          },
                                                          child: Text('Open'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]);
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: children,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.info_outline_rounded,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          project.name.capitalizeFirstofEach,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                  crossAxisCount: 2,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
