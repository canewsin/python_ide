import '../imports.dart';

class UnzipParams {
  String item;
  Uint8List bytes;
  String dest;
  UnzipParams(
    this.item,
    this.bytes, {
    this.dest = '',
  });
}

enum state {
  NOT_DOWNLOADED,
  DOWNLOADING,
  NOT_INSTALLED,
  INSTALLING,
  MAKING_AS_EXEC,
  READY,
  RUNNING,
  NONE,
}

class FileIcon {
  String name;
  String fileName;
  List<String> supportedExt;

  FileIcon({
    this.name,
    this.fileName,
    this.supportedExt,
  });

  FileIcon fromMap(String name, Map map) {
    List<String> exts = [];
    for (var item in map['supportedExt']) {
      exts.add(item);
    }
    return FileIcon(
      name: name,
      fileName: map['fileName'],
      supportedExt: exts,
    );
  }
}

class AppDeveloper extends Equatable {
  final String name;
  final String profileIconLink;
  final String developerType;
  final String githubLink;
  final String facebookLink;
  final String twitterLink;
  const AppDeveloper({
    this.name,
    this.profileIconLink,
    this.developerType,
    this.githubLink,
    this.facebookLink,
    this.twitterLink,
  });

  @override
  List<Object> get props => [
        name,
        profileIconLink,
        developerType,
        githubLink,
        facebookLink,
        twitterLink,
      ];
}

class CodeTemplate extends Equatable {
  final String name;
  final String fileName;
  final String source;

  CodeTemplate({
    this.name,
    this.fileName,
    this.source,
  });

  CodeTemplate fromMap(String name, Map map) {
    return CodeTemplate(
      name: name,
      fileName: map['fileName'],
      source: map['source'],
    );
  }

  @override
  List<Object> get props => [
        name,
        fileName,
        source,
      ];
}

class Project extends Equatable {
  final String id;
  final String name;
  final String path;
  final String program;
  final DateTime created;
  final DateTime lastEdited;

  Project({
    this.id,
    this.name,
    this.path,
    this.program,
    this.created,
    this.lastEdited,
  });

  Map toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'path': this.path,
      'program': this.program,
      'created': this.created.millisecondsSinceEpoch,
      'lastEdited': this.lastEdited.millisecondsSinceEpoch,
    };
  }

  Project fromMap(Map map) {
    return Project(
      id: map['id'],
      name: map['name'],
      path: map['path'],
      program: map['program'],
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      lastEdited: DateTime.fromMillisecondsSinceEpoch(map['lastEdited']),
    );
  }

  List<String> get propsNames => [
        'id',
        'name',
        'path',
        'program',
        'created',
        'lastEdited',
      ];

  @override
  List<Object> get props => [
        id,
        name,
        path,
        program,
        created,
        lastEdited,
      ];
}

class ProjectFile with EquatableMixin {
  String name;
  String path;
  bool isInEditMode;

  ProjectFile({
    this.name,
    this.path,
    this.isInEditMode = false,
  });

  @override
  List<Object> get props => [name, path];
}

extension ProjectFileExt on ProjectFile {
  bool get isPropsFile => this.path.endsWith('project.props');
}
