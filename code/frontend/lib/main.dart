import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'Routes/app_pages.dart';

bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 600;

void main() async {
  // binds the framework to the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();
  // manage portrait lock
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, builder) {
        return GetMaterialApp(
          title: 'Cancer App',
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL_ROUTE,
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        );
      },
    );
  }
}
