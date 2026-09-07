import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AppUpdateInfo {
  final String version;
  final String apkUrl;
  final String releaseNotes;

  AppUpdateInfo({required this.version, required this.apkUrl, required this.releaseNotes});
}

class AppUpdateService {
  static const String githubOwner = 'lakshaymehra-pixel';
  static const String githubRepo = 'ish-android-application';

  static Future<AppUpdateInfo?> checkForUpdate() async {
    if (!Platform.isAndroid) return null;

    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.github.com/repos/$githubOwner/$githubRepo/releases/latest',
        options: Options(headers: {'Accept': 'application/vnd.github+json'}),
      );

      if (response.statusCode != 200 || response.data == null) return null;

      final data = response.data as Map<String, dynamic>;
      final tagName = (data['tag_name'] ?? '').toString();
      final latestVersion = _extractVersion(tagName);
      if (latestVersion == null) return null;

      final assets = (data['assets'] as List?) ?? [];
      final apkAsset = assets.cast<Map<String, dynamic>>().firstWhere(
            (a) => (a['name'] ?? '').toString().toLowerCase().endsWith('.apk'),
            orElse: () => {},
          );
      final apkUrl = apkAsset['browser_download_url']?.toString();
      if (apkUrl == null) return null;

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      if (_isNewer(latestVersion, currentVersion)) {
        return AppUpdateInfo(
          version: latestVersion,
          apkUrl: apkUrl,
          releaseNotes: (data['body'] ?? '').toString(),
        );
      }
      return null;
    } catch (e) {
      debugPrint('AppUpdateService.checkForUpdate error: $e');
      return null;
    }
  }

  static String? _extractVersion(String tagName) {
    final match = RegExp(r'v?(\d+\.\d+\.\d+)').firstMatch(tagName);
    return match?.group(1);
  }

  static bool _isNewer(String latest, String current) {
    final l = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final c = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    for (var i = 0; i < 3; i++) {
      final lv = i < l.length ? l[i] : 0;
      final cv = i < c.length ? c[i] : 0;
      if (lv != cv) return lv > cv;
    }
    return false;
  }

  static Future<void> downloadAndInstall(
    String apkUrl, {
    required void Function(double progress) onProgress,
    required void Function() onComplete,
    required void Function(String error) onError,
  }) async {
    try {
      final installStatus = await Permission.requestInstallPackages.status;
      if (!installStatus.isGranted) {
        final result = await Permission.requestInstallPackages.request();
        if (!result.isGranted) {
          onError('Install permission not granted');
          return;
        }
      }

      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/salarytopup_update.apk';

      final dio = Dio();
      await dio.download(
        apkUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) onProgress(received / total);
        },
      );

      onComplete();
      await OpenFile.open(filePath);
    } catch (e) {
      onError(e.toString());
    }
  }
}
