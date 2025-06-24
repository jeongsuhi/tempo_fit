
enum App {
  version,
  store,
  contact,
}

extension AppExtension on App {

  String get value {
    switch (this) {
      case App.version:
        return "2.0.0";
      case App.store:
        return Uri(
            scheme: 'https',
            host: 'play.google.com',
            path: 'store/apps/details',
            queryParameters: {
              'id': 'com.dena.automotive.taxibell'
            }
        ).toString();
      case App.contact:
        return "guniee.mama@gmail.com";
    }
  }

  Uri? get uri {
    switch (this) {
      case App.store:
        return Uri(
            scheme: 'https',
            host: 'play.google.com',
            path: 'store/apps/details',
            queryParameters: {
              'id': 'com.dena.automotive.taxibell'
            }
        );
      case App.version: return null;
      case App.contact: return null;
    }
  }
}