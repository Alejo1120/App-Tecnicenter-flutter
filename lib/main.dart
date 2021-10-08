import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruver/data/repository/calendary_repository_impl.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xFFFFCC80),
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        Provider<CalendaryRepository>(
          create: (_) => CalendaryRepositoryImpl(),
        ),
      ],
      builder: (_, __) => const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
