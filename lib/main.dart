import 'package:deenfitapp/app/Theme/theme.dart';
import 'package:deenfitapp/app/AppBinding.dart';
import 'package:deenfitapp/app/Di.dart';
import 'package:deenfitapp/app/routes/app_pages.dart';
import 'package:deenfitapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Deenfit",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: darkmode(),
      theme: lightmode(),
      builder: EasyLoading.init(),
      initialBinding: Appbinding(),
    );
  }
}
