import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'models.dart';
import 'downloader.dart';

void callbackDispatcher() {
  const MethodChannel backgroundChannel =
  MethodChannel('vn.hunghd/downloader_background');

  WidgetsFlutterBinding.ensureInitialized();

  backgroundChannel.setMethodCallHandler((MethodCall call) async {
    final List<dynamic> args = call.arguments;

    final DownloadCallback callback = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(args[0]));

    final String id = args[1];
    final int status = args[2];
    final int progress = args[3];
    final int downloaded = args[4];
    final int all = args[5];

    callback(id, DownloadTaskStatus(status), progress, downloaded, all);
  });

  backgroundChannel.invokeMethod('didInitializeDispatcher');
}
