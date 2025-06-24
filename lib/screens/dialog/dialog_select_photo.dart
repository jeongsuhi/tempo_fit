import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:tempo_fit/screens/toast.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/utils/format_log_image.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:provider/provider.dart';

void showSelectPhotoDialog(BuildContext context, int logKey, Function() onPressed,) {
  String dialogName = "DA_SelectPhoto";
  FirebaseAnalyticsService.sendDialogEvent(dialogName: dialogName);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
          onTap: () {
            FirebaseAnalyticsService.sendButtonEvent(buttonName: "cancel", screenName: dialogName);
            Navigator.of(context).pop();
          },
          child: SelectPhotoDialog(logKey: logKey, onPressed: onPressed,),
      );
    }
  );
}

class SelectPhotoDialog extends StatelessWidget {
  final String dialogName = "DA_SelectPhoto";
  const SelectPhotoDialog({ super.key, required this.logKey, required this.onPressed });

  final int logKey;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppSettingsProvider>(context);
    final l10n = L10n.of(context);

    void updateImage(String path) {
      Provider.of<ExerciseLogProvider>(context, listen: false).updateImage(logKey, path);
      showToast(l10n.toastSaveComplete);
    }

    Future<void> getImage(BuildContext context, ImageSource source) async {
      try {
        final pickedImage = await ImagePicker().pickImage(source: source);

        if (pickedImage == null) return;
        File imageFile = File(pickedImage.path);
        String newPath = await createImagePath(logKey);

        // 画像をアプリのディレクトリに保存
        File savedImage = await imageFile.copy(newPath);
        updateImage(savedImage.path);

      } catch (e) {
        debugPrint('Error picking image: $e');
      } finally {
        // callback
        onPressed.call();
        // close
        Navigator.of(context).pop();
      }
    }

    /// ラベル
    String getTitle(PhotoActions item) {
      switch (item) {
        case PhotoActions.choosePicture:
          return l10n.buttonChoosePicture;
        case PhotoActions.takePicture:
          return l10n.buttonTakePicture;
        case PhotoActions.delete:
          return l10n.buttonDeletePicture;
      }
    }

    List<ListTile> buildButtons() {
      return PhotoActions.values.mapIndexed((index, value) =>
          ListTile(
            tileColor: appProvider.currentTheme.backgroundColor,
            leading: Icon(value.icon,
              size: Theme.of(context).textTheme.titleMedium!.fontSize,
              color: appProvider.currentTheme.onBackgroundColor,
            ),
            title: Text(
              getTitle(value),
              style: Theme.of(context).textTheme.titleMedium!.apply(
                color: appProvider.currentTheme.onBackgroundColor,
              ),
            ),
            onTap: () async {
              FirebaseAnalyticsService.sendButtonEvent(buttonName: value.name, screenName: dialogName);

              switch (value) {
                case PhotoActions.choosePicture:
                  getImage(context, ImageSource.gallery);
                case PhotoActions.takePicture:
                  getImage(context, ImageSource.camera);
                case PhotoActions.delete: {
                  updateImage("");
                  // callback
                  onPressed.call();
                  // close
                  Navigator.of(context).pop();
                }
              }
            },
          )
      ).toList();
    }

    return Dialog(
      backgroundColor: appProvider.currentTheme.backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.historyPictureLabel,
              style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: appProvider.currentTheme.onBackgroundColor
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              height: 1,
              color: appProvider.currentTheme.backgroundOverlayColor,
            ),
          ] + buildButtons(),
        ),
      ),
    );
  }
}

enum PhotoActions {
  /// ギャラリーから選ぶ
  choosePicture,
  /// 写真を撮る
  takePicture,
  /// 消す
  delete,
}

extension PhotoActionsExtension on PhotoActions {

  IconData get icon {
    switch (this) {
      case PhotoActions.choosePicture:
        return Icons.image_outlined;
      case PhotoActions.takePicture:
        return Icons.camera_alt_outlined;
      case PhotoActions.delete:
        return Icons.delete_outlined;
    }
  }

}