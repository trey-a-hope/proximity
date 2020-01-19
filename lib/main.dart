import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proximity/pages/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity/services/db.dart';
import 'package:proximity/services/modal.dart';

final GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<Modal>(ModalImplementation(), signalsReady: true);
  getIt.registerSingleton<DB>(DBImplementation(), signalsReady: true);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
