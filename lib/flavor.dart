
enum FLAVOR {
  production,
  develop,
}

extension FLAVORExtension on FLAVOR {

  String get value {
    switch (this) {
      case FLAVOR.production:
        return "prd";
      case FLAVOR.develop:
        return "dev";
    }
  }
}

// ビルド環境判定
bool isProduction() {
  const String flavor = String.fromEnvironment('FLAVOR');
  return flavor == FLAVOR.production.value;
}