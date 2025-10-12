import 'dart:io';

/// To avoid invalid Cert Error
/// https://github.com/iiumschedule/albiruni_fetcher/issues/82
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (_, String host, __) => host == 'albiruni.iium.edu.my';
  }
}
