import 'package:flutter/material.dart';
import 'package:todo_assessment/helpers/sizer_helper.dart';

class _LoadingController {
  final bool Function() isActive;
  final bool Function() close;

  _LoadingController({
    required this.isActive,
    required this.close,
  });
}

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._();
  LoadingOverlay._();
  factory LoadingOverlay.instance() => _instance;

  _LoadingController? _loadingController;

  void show({required BuildContext context}) {
    if (_loadingController != null) return;
    _loadingController ??= _showOverlay(context: context);
  }

  void hide() {
    _loadingController?.close();
    _loadingController = null;
  }

  bool isActive() => _loadingController?.isActive() ?? false;

  _LoadingController _showOverlay({
    required BuildContext context,
  }) {
    final overlay = OverlayEntry(builder: (_) => const _LoadingDialogue());
    Overlay.of(context).insert(overlay);

    return _LoadingController(
      close: () {
        overlay.remove();
        return true;
      },
      isActive: () => true,
    );
  }
}

class _LoadingDialogue extends StatelessWidget {
  const _LoadingDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Material(
        color: Colors.black.withAlpha(150),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 3.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator.adaptive(),
                SizedBox(height: 3.h),
                const Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
