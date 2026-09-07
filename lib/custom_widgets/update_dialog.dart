import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/app_update_service.dart';
import '../utils/color_constants.dart';

class UpdateDialog extends StatefulWidget {
  final AppUpdateInfo updateInfo;

  const UpdateDialog({super.key, required this.updateInfo});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  bool downloading = false;
  double progress = 0;
  String? error;

  void _startUpdate() {
    setState(() {
      downloading = true;
      error = null;
    });

    AppUpdateService.downloadAndInstall(
      widget.updateInfo.apkUrl,
      onProgress: (p) {
        if (mounted) setState(() => progress = p);
      },
      onComplete: () {
        if (mounted) setState(() => downloading = false);
      },
      onError: (e) {
        if (mounted) {
          setState(() {
            downloading = false;
            error = e;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text('Update Available'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('A new version (${widget.updateInfo.version}) of the app is available.'),
            if (widget.updateInfo.releaseNotes.trim().isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                widget.updateInfo.releaseNotes,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
            if (downloading) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(value: progress > 0 ? progress : null),
              const SizedBox(height: 6),
              Text('${(progress * 100).toStringAsFixed(0)}%'),
            ],
            if (error != null) ...[
              const SizedBox(height: 10),
              Text('Download failed: $error', style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
        actions: [
          if (!downloading)
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Later'),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(ColorConstants.primaryColor)),
            onPressed: downloading ? null : _startUpdate,
            child: Text(downloading ? 'Downloading...' : 'Update Now'),
          ),
        ],
      ),
    );
  }
}
