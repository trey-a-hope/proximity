import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proximity/pages/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity/pages/login_page.dart';
import 'package:proximity/services/auth_service.dart';
import 'package:proximity/services/db_service.dart';
import 'package:proximity/services/modal_service.dart';
import 'package:proximity/services/validater_service.dart';

final GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  getIt.registerSingleton<AuthService>(AuthServiceImplementation(),
      signalsReady: true);
  getIt.registerSingleton<DBService>(DBServiceImplementation(),
      signalsReady: true);
  getIt.registerSingleton<ModalService>(ModalServiceImplementation(),
      signalsReady: true);
  getIt.registerSingleton<ValidatorService>(ValidatorServiceImplementation(),
      signalsReady: true);

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
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        FirebaseUser user = snapshot.data;
        return user == null ? LoginPage() : HomePage();
      },
    );
  }
}
