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
import 'package:pie_chart/pie_chart.dart';

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
      body: 
      Obx(
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
            "Getting a medical evaluation for every minor skin blemish can be a costly and time-consuming hassle that many individuals simply cannot afford. However, the consequences of neglecting skin health can be dire, as even small changes in the appearance or texture of the skin may indicate the presence of skin cancers or diseases. Unfortunately, not everyone has access to medical facilities or the necessary knowledge to identify such conditions. That's where SPOT steps in as a game-changing solution – a cutting-edge AI-powered medical diary that provides users with a comprehensive and accurate assessment of their skin's health status. By utilizing advanced artificial intelligence technology, SPOT offers a quick, easy, and affordable alternative to traditional medical evaluations. Users can simply upload images of their skin blemishes or areas of concern, and SPOT's algorithms will analyze them to identify any potential skin cancers or diseases. With SPOT, you can have peace of mind knowing that your skin health is being monitored by advanced technology, providing you with accurate and reliable evaluations. Although SPOT's assessment is not a substitute for professional medical advice, it empowers users to take informed action and seek professional assistance where necessary. By taking control of your skin health with SPOT, you can make informed decisions and take proactive steps towards maintaining your overall well-being.",
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
      child: 
      Obx(() => homeController.homeIsLoading.value
      ? const Center(child: CircularProgressIndicator())
       :
       Container(
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
      
                                child:
                                GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                    barrierDismissible: true,
                                     builder: (BuildContext context) {
                                      return
                                      Dialog(
                                        child: SizedBox(
                                // photobox
                                height: isDesktop(context) ? 60.h : 80.h,
                                width: isDesktop(context) ? 80.w : 80.w,
                                child:
                                homeController.serverImages?.isNotEmpty ==
                                            true
                                        ? Image.memory(
                                            homeController.serverImages![index])
                                        : Image.asset(
                                            'assets/images/placeholder.png',
                                          )


                                    )
                                     );
                                      }
                                      );
                                
                                  },


                                  child:
                                    homeController.serverImages?.isNotEmpty ==
                                            true
                                        ? Image.memory(
                                            homeController.serverImages![index])
                                        : Image.asset(
                                            'assets/images/placeholder.png',
                                          )
                                      )
                                  ),
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
                                  homeController.deleteEntriesHelper(index);
                                  //errorSnackBar(
                                  //    message:
                                  //        "Scan $index deleted Successfully");
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
                                      text: homeController.scanDoc[index]['scan'],
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
                                      text: homeController.scanDoc[index]['date'],
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
                              //    header
                              Text(
                                'Area Affected:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Area affected text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['area']!,
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
                          Text("What our AI is predicting about your scan:"),
                       
                        Container(
                          height: isDesktop(context) ? 10.w : 5.h,
                          width: isDesktop(context) ? 15.w :  7.5.w,
                          child: PieChart(dataMap: {"Melanocytic Nevi (Heathy Skin)":double.parse(homeController.scanDoc[index]['nV']!),
                          "Benign Keratosis-Like Lesions":double.parse(homeController.scanDoc[index]['bKL']!),
                          "Basal Cell Carcinoma":double.parse(homeController.scanDoc[index]['bCC']!),
                          "Actinic Keratose":double.parse(homeController.scanDoc[index]['akiec']!),
                          "Vascular Lesions":double.parse(homeController.scanDoc[index]['vasc']!),
                          "Dermatofibroma":double.parse(homeController.scanDoc[index]['dF']!),
                          "Melanoma":double.parse(homeController.scanDoc[index]['mel']!),      
                        }),
                    ),
                      SizedBox(height: 0.5.h),
                          Text("More deatailed information on the melanoma prediction:"),
                        Container(
                          height: isDesktop(context) ? 10.w : 5.h,
                          width: isDesktop(context) ? 15.w :  7.5.w,
                          child: PieChart(dataMap: {"Benign":double.parse(homeController.scanDoc[index]['melBen']!), "Mlignent":double.parse(homeController.scanDoc[index]['melMalig']!)}),
                    ),
                 





                              


                              SizedBox(height: 0.5.h),
                              //  Melanocytic nevi header
                              Text(
                                'Melanocytic Nevi (Heathy Skin) prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Melanocytic nevi text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['nV']!,
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
                              //  Benign Keratosis-Like Lesions header
                              Text(
                                'Benign Keratosis-Like Lesions prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Benign keratosis-like lesions text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['bKL']!,
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
                              //  Basal cell carcinoma header
                              Text(
                                ' Basal Cell Carcinoma prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Basal cell carcinoma text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['bCC']!,
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
                              //  Actinic keratose header
                              Text(
                                ' Actinic Keratose prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Actinic keratose text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['akiec']!,
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
                              //  Vascular lesions header
                              Text(
                                ' Vascular Lesions prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Vascular lesions text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['vasc']!,
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
                              //  Dermatofibroma header
                              Text(
                                ' Dermatofibroma prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Dermatofibroma text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['dF']!,
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
                              //  melanoma header
                              Text(
                                ' Melanoma prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // melanoma text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['melBen']!,
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
                              //  benign header
                              Text(
                                'Benign Melanoma prediction:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // benign text
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['melBen']!,
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
                              // Malignant  header
                              Text(
                                'Malignent Melanoma prediction',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                              // Malignant Melanoma text 
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
                                  radius: const Radius.circular(15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      homeController.scanDoc[index]['melMalig']!,
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
      ),
    );
  }
}
