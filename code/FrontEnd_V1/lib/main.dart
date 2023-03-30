import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'Routes/app_pages.dart';
import 'Utils/preference.dart';

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preference().instance();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, builder) {
        return GetMaterialApp(
          title: 'SPOT',
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
