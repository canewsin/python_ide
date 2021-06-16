// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'varstore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VarStore on _VarStore, Store {
  final _$eventAtom = Atom(name: '_VarStore.event');

  @override
  ObservableEvent get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(ObservableEvent value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  final _$zeroNetLogAtom = Atom(name: '_VarStore.zeroNetLog');

  @override
  String get zeroNetLog {
    _$zeroNetLogAtom.reportRead();
    return super.zeroNetLog;
  }

  @override
  set zeroNetLog(String value) {
    _$zeroNetLogAtom.reportWrite(value, super.zeroNetLog, () {
      super.zeroNetLog = value;
    });
  }

  final _$zeroNetAppbarStatusAtom = Atom(name: '_VarStore.zeroNetAppbarStatus');

  @override
  String get zeroNetAppbarStatus {
    _$zeroNetAppbarStatusAtom.reportRead();
    return super.zeroNetAppbarStatus;
  }

  @override
  set zeroNetAppbarStatus(String value) {
    _$zeroNetAppbarStatusAtom.reportWrite(value, super.zeroNetAppbarStatus, () {
      super.zeroNetAppbarStatus = value;
    });
  }

  final _$zeroNetStatusAtom = Atom(name: '_VarStore.zeroNetStatus');

  @override
  String get zeroNetStatus {
    _$zeroNetStatusAtom.reportRead();
    return super.zeroNetStatus;
  }

  @override
  set zeroNetStatus(String value) {
    _$zeroNetStatusAtom.reportWrite(value, super.zeroNetStatus, () {
      super.zeroNetStatus = value;
    });
  }

  final _$zeroNetInstalledAtom = Atom(name: '_VarStore.zeroNetInstalled');

  @override
  bool get zeroNetInstalled {
    _$zeroNetInstalledAtom.reportRead();
    return super.zeroNetInstalled;
  }

  @override
  set zeroNetInstalled(bool value) {
    _$zeroNetInstalledAtom.reportWrite(value, super.zeroNetInstalled, () {
      super.zeroNetInstalled = value;
    });
  }

  final _$zeroNetDownloadedAtom = Atom(name: '_VarStore.zeroNetDownloaded');

  @override
  bool get zeroNetDownloaded {
    _$zeroNetDownloadedAtom.reportRead();
    return super.zeroNetDownloaded;
  }

  @override
  set zeroNetDownloaded(bool value) {
    _$zeroNetDownloadedAtom.reportWrite(value, super.zeroNetDownloaded, () {
      super.zeroNetDownloaded = value;
    });
  }

  final _$loadingStatusAtom = Atom(name: '_VarStore.loadingStatus');

  @override
  String get loadingStatus {
    _$loadingStatusAtom.reportRead();
    return super.loadingStatus;
  }

  @override
  set loadingStatus(String value) {
    _$loadingStatusAtom.reportWrite(value, super.loadingStatus, () {
      super.loadingStatus = value;
    });
  }

  final _$loadingPercentAtom = Atom(name: '_VarStore.loadingPercent');

  @override
  int get loadingPercent {
    _$loadingPercentAtom.reportRead();
    return super.loadingPercent;
  }

  @override
  set loadingPercent(int value) {
    _$loadingPercentAtom.reportWrite(value, super.loadingPercent, () {
      super.loadingPercent = value;
    });
  }

  final _$_VarStoreActionController = ActionController(name: '_VarStore');

  @override
  void setObservableEvent(ObservableEvent eve) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.setObservableEvent');
    try {
      return super.setObservableEvent(eve);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setZeroNetLog(String status) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.setZeroNetLog');
    try {
      return super.setZeroNetLog(status);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setZeroNetAppbarStatus(String status) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.setZeroNetAppbarStatus');
    try {
      return super.setZeroNetAppbarStatus(status);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setZeroNetStatus(String status) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.setZeroNetStatus');
    try {
      return super.setZeroNetStatus(status);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isZeroNetInstalled(bool installed) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.isZeroNetInstalled');
    try {
      return super.isZeroNetInstalled(installed);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isZeroNetDownloaded(bool downloaded) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.isZeroNetDownloaded');
    try {
      return super.isZeroNetDownloaded(downloaded);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoadingStatus(String status) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoadingPercent(int percent) {
    final _$actionInfo = _$_VarStoreActionController.startAction(
        name: '_VarStore.setLoadingPercent');
    try {
      return super.setLoadingPercent(percent);
    } finally {
      _$_VarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
event: ${event},
zeroNetLog: ${zeroNetLog},
zeroNetAppbarStatus: ${zeroNetAppbarStatus},
zeroNetStatus: ${zeroNetStatus},
zeroNetInstalled: ${zeroNetInstalled},
zeroNetDownloaded: ${zeroNetDownloaded},
loadingStatus: ${loadingStatus},
loadingPercent: ${loadingPercent}
    ''';
  }
}
