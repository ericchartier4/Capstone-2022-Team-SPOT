// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/home_controller.dart';
import '../Utils/preference.dart';
import '../main.dart';
import '../Routes/routes.dart';
import '../Utils/app_colors.dart';
import '../Utils/constant_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  String? luserEmail;
  String? luserPass;
  @override
  void initState() {
    super.initState();

    luserEmail = Preference.shared.getString('useremail');
    luserPass = Preference.shared.getString('userpass');
    print("$luserEmail | $luserPass");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: false,
        isShowMenuIcon: false,
        title: 'Demo',
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.more_vert),
          //   onPressed: () {

          //   },
          // ),

          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Logout"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Get.offAllNamed(Routes.LOGIN_SCREEN);
            }
          }),
        ],
      ),
      body: Obx(
        () => homeController.selectedBottomIndex.value == 0
            ? home(context)
            : scan(context),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: const Color(0xffFEEAE6),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color(0xff442C2E),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.document_scanner,
                color: Color(0xff442C2E),
              ),
              label: 'Scan',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.greenColor,
          currentIndex: homeController.selectedBottomIndex.value,
          onTap: (int index) {
            homeController.selectedBottomIndex.value = index;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.NEW_SCAN_SCREEN);
        },
        backgroundColor: const Color(0xff442C2E),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget home(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: isDesktop(context) ? 30.h : 25.h,
            width: isDesktop(context) ? 100.w : 100.w,
            decoration: BoxDecoration(
              color: const Color(0xffFEEAE6),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: const Text('Image'),
          ),
          SizedBox(height: 2.h),
          Text(
            'About the App',
            style: GoogleFonts.poppins(
              color: AppColor.textBlackColor,
              fontSize: isDesktop(context) ? 20 : 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Let reset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            style: GoogleFonts.poppins(
              color: AppColor.textBlackColor.withOpacity(0.7),
              fontSize: isDesktop(context) ? 15 : 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget scan(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isDesktop(context) ? 55.w : 100.w,
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: isDesktop(context) ? 15 : 4.w, vertical: 1.h),
          itemCount: homeController.scanDoc.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  homeController.selectedIndex.value = index;
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  shadowColor: const Color(0xffFEDBD0),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 7, top: 7, right: 7, bottom: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Processing Status
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // photobox
                              height: isDesktop(context) ? 10.h : 8.h,
                              width: isDesktop(context) ? 10.w : 30.w,
                              color: Colors.lightBlue.withOpacity(0.2),
                              child: homeController.serverImages?.isNotEmpty ==true 
                              ? Image.memory(homeController.serverImages![index])
                              : Image.asset('assets/images/placeholder.png',)
                            )
                              ,
                            
                            SizedBox(width: 2.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Processing Status:\n',
                                    style: GoogleFonts.poppins(
                                      fontSize: isDesktop(context) ? 14 : 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textBlackColor
                                          .withOpacity(0.7),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "complete",
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              isDesktop(context) ? 14 : 10.sp,
                                          color: AppColor.textBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  errorSnackBar(
                                      message:
                                          "Scan $index deleted Successfully");
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    alignment: Alignment.topRight,
                                    child: const Icon(Icons.delete_outline)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        // Scan-Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text.rich(
                                TextSpan(
                                  text: 'Scan: ',
                                  style: GoogleFonts.poppins(
                                    fontSize: isDesktop(context) ? 14 : 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textBlackColor
                                        .withOpacity(0.7),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: homeController.scanDoc[index]
                                          ['scan'],
                                      style: GoogleFonts.poppins(
                                        fontSize:
                                            isDesktop(context) ? 14 : 10.sp,
                                        color: AppColor.textBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text.rich(
                                TextSpan(
                                  text: 'Date Uploaded: ',
                                  style: GoogleFonts.poppins(
                                    fontSize: isDesktop(context) ? 14 : 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textBlackColor
                                        .withOpacity(0.7),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: homeController.scanDoc[index]
                                          ['date'],
                                      style: GoogleFonts.poppins(
                                        fontSize:
                                            isDesktop(context) ? 14 : 10.sp,
                                        color: AppColor.textBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Expanded part
                        Visibility(
                          visible: homeController.selectedIndex.value == index
                              ? true
                              : false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 0.5.h),
                              // About this scan text
                              Text(
                                'About this scan',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // About this scan description
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: isDesktop(context) ? 15.h : 12.h,
                                  maxWidth: isDesktop(context) ? 60.w : 85.w,
                                ),
                                padding: EdgeInsets.only(
                                  left: isDesktop(context) ? 0.7.w : 2.5.w,
                                  top: 0.5.h,
                                  right: isDesktop(context) ? 0.5.w : 1.5.w,
                                  bottom: 0.5.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.greyColor),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Scrollbar(
                                  controller: homeController.aboutController,
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    controller: homeController.aboutController,
                                    child: Text(
                                      homeController.scanDoc[index]['about']!,
                                      style: GoogleFonts.poppins(
                                        color: AppColor.textBlackColor
                                            .withOpacity(0.7),
                                        fontSize:
                                            isDesktop(context) ? 13 : 11.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              // benign comment text
                              Text(
                                'Benign',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Benign comment description
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: isDesktop(context) ? 15.h : 12.h,
                                  maxWidth: isDesktop(context) ? 60.w : 85.w,
                                ),
                                padding: EdgeInsets.only(
                                  left: isDesktop(context) ? 0.7.w : 2.5.w,
                                  top: 0.5.h,
                                  right: isDesktop(context) ? 0.5.w : 1.5.w,
                                  bottom: 0.5.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.greyColor),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Scrollbar(
                                  controller: homeController.doctorController,
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    controller: homeController.doctorController,
                                    child: Text(
                                      homeController.scanDoc[index]['benign']!,
                                      style: GoogleFonts.poppins(
                                        color: AppColor.textBlackColor
                                            .withOpacity(0.7),
                                        fontSize:
                                            isDesktop(context) ? 13 : 11.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                               SizedBox(height: 0.5.h),
                              // Malignant comment text
                              Text(
                                'Malignent',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Doctors comment description
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: isDesktop(context) ? 15.h : 12.h,
                                  maxWidth: isDesktop(context) ? 60.w : 85.w,
                                ),
                                padding: EdgeInsets.only(
                                  left: isDesktop(context) ? 0.7.w : 2.5.w,
                                  top: 0.5.h,
                                  right: isDesktop(context) ? 0.5.w : 1.5.w,
                                  bottom: 0.5.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.greyColor),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Scrollbar(
                                  controller: homeController.doctorController,
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    controller: homeController.doctorController,
                                    child: Text(
                                      homeController.scanDoc[index]['malignent']!,
                                      style: GoogleFonts.poppins(
                                        color: AppColor.textBlackColor
                                            .withOpacity(0.7),
                                        fontSize:
                                            isDesktop(context) ? 13 : 11.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
