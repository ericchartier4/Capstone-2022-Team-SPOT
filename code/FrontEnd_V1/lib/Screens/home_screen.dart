
import 'dart:math';
import 'package:demo/Utils/legal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/home_controller.dart';
import '../Controllers/home_controller.dart';
import '../Utils/preference.dart';
import '../Utils/tilesbuilder.dart';
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
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: false,
        isShowMenuIcon: false,
        title: 'Home',
        actions: [
   

          PopupMenuButton(
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Logout"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Delete Account"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Legal Licences "),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Get.offAllNamed(Routes.LOGIN_SCREEN);
            }
            if (value == 1) {
               showDialog(context: context,
                                    barrierDismissible: false,
                                     builder: (BuildContext context) {
                                      return deleteAccountAssurance(context, homeController);
                                     }
                    );
           

              
            } 
            if (value == 2) {
              showAboutDialog(context: context, applicationLegalese: legalText,applicationName: "SPOT", );
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
              label: 'History',
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
      floatingActionButton: FloatingActionButton.extended(
        
        onPressed: () {
          Get.toNamed(Routes.NEW_SCAN_SCREEN);
        },
        label: const Text(" New Scan"),
        backgroundColor: const Color(0xff442C2E),
        icon: const Icon(
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      child:
     
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
                    padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Image.asset(
                       
                      'assets/images/FullLogo_Transparent.png',
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.cover,
                    ),
                  ),
          SizedBox(height: 2.h),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10), 
            child:
           SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*2,
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Expanded(
            child:
            ListView(
            
            shrinkWrap: true,
            children: homeExpndable.map(buildTile).toList(),),
           
            
            ),
            ],

            ),
            
           ),
          ),
        ],
      ),
     
    );
  }




















  Widget scan(BuildContext context) {
    
    return 
    Center(
      child: Obx(() => homeController.noEntries.value
      ? const Text("You do not have any saved entries in your History")
      :
    Center(
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
                child: 
                  
                   
                Card(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  shadowColor: const Color(0xffFEDBD0),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child:  
                
                   Container(
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
                        
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                       
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
                                      text: homeController.scanDoc[index]['Scan'],
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
                                      text: homeController.scanDoc[index]['Date'],
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
                     
                        Visibility(
                          visible: homeController.selectedIndex.value == index
                              ? true
                              : false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 0.5.h),
                            




















                              Text(
                                'About this scan',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                        
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
                                      homeController.scanDoc[index]['About']!,
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
                             
                              Text(
                                'Area Affected:',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop(context) ? 16 : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff442C2E),
                                ),
                              ),
                           
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
                                      homeController.scanDoc[index]['Area']!,
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

          
                        
                            

                  
                             
                          
                        
                          SizedBox(height: 0.5.h),
                            
                 ExpansionTile(
                  title: Row ( children: 
                  const [(Icon(Icons.info )),
                  Text("full values found under here")
                  
                  ]
                  
                  ),
                  children:[
                 getHomeCard(context,"Melanocytic nevi", index, homeController),
                 getHomeCard(context,"Benign keratosis-like lesions", index, homeController),
                 getHomeCard(context, "Basal cell carcinoma", index, homeController),
                 getHomeCard(context, "Actinic keratoses", index, homeController),
                 getHomeCard(context, "Vascular lesions", index, homeController),
                 getHomeCard(context, "Dermatofibroma", index, homeController),
                 getHomeCard(context, "Melanoma", index, homeController),
                 getHomeCard(context, "Benign", index, homeController),
                 getHomeCard(context, "Malignant", index, homeController),
                  ],
                 ),


                  homeController.getPieChart(index),       





          


        

           





        

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
    ),
    ),
    );
    
  }
}




