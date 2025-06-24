import 'dart:io';
import 'dart:math' as math;
import 'package:path_provider/path_provider.dart';

Future<String> createImagePath(int logKey) async {

  Directory appDir = await getApplicationDocumentsDirectory();
  String imagePath = "${appDir.path}/workoutLog/images/$logKey";
  // 5桁のランダム数
  int random = math.Random().nextInt(100000 - 10000) + 10000;
  String fileName = '$random.jpg';

  final Directory directory = Directory(imagePath);

  if (await directory.exists()) {
    // ディレクトリーを空にする
    await directory.list().forEach((element) {
      element.delete();
    });
  } else {
    // 存在しない場合ディレクトリー生成
    await directory.create(recursive: true);
  }

  return '$imagePath/$fileName';
}