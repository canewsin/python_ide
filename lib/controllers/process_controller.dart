import '../imports.dart';
import '../imports_conflicts.dart';

class ProcessController extends GetxController {
  var status = ProcessStatus.Idle.obs;
  var consoleLog = ''.obs;

  void appendConsoleLog(Object log) => consoleLog.value += log.toString();

  void clearConsoleLog() => consoleLog.value = '';

  void changeProcessStatus(ProcessStatus statusInput) =>
      status.value = statusInput;

  void runProcess(String path) {
    var python = appNativeDir + '/libpython3.8.so';
    if (File(python).existsSync()) {
      Process.start('$python', [
        path,
      ], environment: {
        "LD_LIBRARY_PATH": "$libDir:$libDir64:/system/lib64",
        'PYTHONHOME': '$dataDir/usr',
        'PYTHONPATH': '$python',
      })
          .then((proc) {
            proc.stderr.listen((onData) {
              appendConsoleLog(utf8.decode(onData));
            });
            proc.stdout.listen((onData) {
              appendConsoleLog(utf8.decode(onData));
            });
          })
          .whenComplete(
            () => processController.changeProcessStatus(ProcessStatus.Idle),
          )
          .catchError((e) {
            if (e is ProcessException) {
              printOut(e.toString());
            }
            processController.changeProcessStatus(ProcessStatus.Error);
            appendConsoleLog({'ZeroNetStatus': 'ERROR'});
            appendConsoleLog({'console': e.toString()});
          });
    } else {
      //TODO: Improve Error Trace here
      appendConsoleLog({'console': 'Python Binary Not Found'});
      processController.changeProcessStatus(ProcessStatus.Error);
      var contents = Directory(appNativeDir).listSync(recursive: true);
      for (var item in contents) {
        appendConsoleLog({'console': item.name()});
        appendConsoleLog({'console': item.path});
      }
    }
    return;
  }
}

final processController = Get.put(ProcessController());
