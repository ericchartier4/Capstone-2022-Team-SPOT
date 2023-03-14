// ignore_for_file: constant_identifier_names

import 'package:demo/Routes/routes.dart';
import 'package:demo/Screens/view_image_screen.dart';
import 'package:get/get.dart';
import '../Screens/add_details_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/new_scan_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/sign_up_screen.dart';
import '../Screens/view_details_screen.dart';

const Transition transition = Transition.cupertino;

class AppPages {
  static const INITIAL_ROUTE = Routes.LOGIN_SCREEN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => LogInScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.SIGN_UP_SCREEN,
      page: () => SignUpScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => HomeScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.NEW_SCAN_SCREEN,
      page: () => NewScanScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.IMAGE_VIEW_SCREEN,
      page: () => ViewImageScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.ADD_DETAILS_SCREEN,
      page: () => AddDetailsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.VIEW_DETAILS_SCREEN,
      page: () => ViewDetailsScreen(),
      transition: transition,
    ),
  ];
}
