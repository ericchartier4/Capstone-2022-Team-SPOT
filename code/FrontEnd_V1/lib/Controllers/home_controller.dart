import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:demo/Utils/glossery.dart';
import 'package:demo/Utils/preference.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sizer/sizer.dart';
import '../Routes/routes.dart';
import '../Utils/app_colors.dart';
import '../Utils/preference.dart';
import '../Utils/constant_widgets.dart';
import '../main.dart';
import '../utils/api_manager.dart' ;
import '../Utils/glossery.dart';

class HomeController extends GetxController {
  var selectedBottomIndex = 0.obs;
  var selectedIndex = 0.obs;
  var isExpanded = false.obs;
  final ScrollController aboutController = ScrollController();
  TextEditingController detailsController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
 
  Rxn<Uint8List>? selectedImageBytes = Rxn<Uint8List>();
  String? _imagefilename;
  String? get imagefilename => _imagefilename;
  String? _imagefileextention;
  String? get imagefileextention => _imagefileextention;
  Uint8List? _encodedImage;
  Uint8List? get encodedImage => _encodedImage;
  List<Uint8List>? _serverImages = [];
  List<Uint8List>? get serverImages => _serverImages;
  RxBool homeIsLoading = false.obs;
  RxBool noEntries = true.obs;









  var scanDocTemplate = 
  [
    {
    'Melanocytic nevi': 'null',
     'Melanoma': 'null',
     'Benign keratosis-like lesions': 'null ',
     'Basal cell carcinoma': 'null',
     'Actinic keratoses': 'null',
     'Vascular lesions': 'null',
     'Dermatofibroma': 'null',
     'Benign' : 'null',
     'Malignant' : 'null',
      "Scan": "null",
      "Date": "null",
      "About": "null",
      "Area": "null"
      
    },
  ];







  var scanDoc = [
 {
    'Melanocytic nevi': 'null',
     'Melanoma': 'null',
     'Benign keratosis-like lesions': 'null ',
     'Basal cell carcinoma': 'null',
     'Actinic keratoses': 'null',
     'Vascular lesions': 'null',
     'Dermatofibroma': 'null',
     'Benign' : 'null',
     'Malignant' : 'null',
      "Scan": "null",
      "Date": "null",
      "About": "null",
      "Area": "null"
      
    },
  ].obs;











void addToScanDoc(map)
{
   var newList;
  for (var i = 0; i < map.length; i++) {
      if (map[i]["date"] == "NullList") {
        scanDoc.value = scanDocTemplate;
        homeIsLoading.value = false ;
        return;
      }
      
    
      var newScan = {
      'Melanocytic nevi': (map[i]["nVResult"] != null) ? (map[i]['nVResult']).toString() : " ",
     'Melanoma':  (map[i]["melResult"] != null) ? (map[i]['melResult']).toString() : " ",
     'Benign keratosis-like lesions':  (map[i]["bKLResult"] != null) ? (map[i]['bKLResult']).toString() : " " ,
     'Basal cell carcinoma': (map[i]["bCCResult"] != null) ? (map[i]['bCCResult']).toString() : " ",
     'Actinic keratoses': (map[i]["akiecResult"] != null) ? (map[i]['akiecResult']).toString() : " " ,
     'Vascular lesions': (map[i]["vascResult"] != null) ? (map[i]['vascResult']).toString() : " " ,
     'Dermatofibroma': (map[i]["dFResult"] != null) ? (map[i]['dFResult']).toString() : " ",
     'Benign' : (map[i]["melBenResult"] != null) ? (map[i]['melBenResult']).toString() : " ",
     'Malignant' :  (map[i]["melMaligResult"] != null) ? (map[i]['melMaligResult']).toString() : " ",
      "Scan": (map[i]["scan"] != null) ? (map[i]['scan']).toString() : " ",
      "Date": (map[i]["date"] != null) ? (map[i]['date']).toString() : " ",
      "About":  (map[i]["about"] != null) ? (map[i]['about']).toString() : " ",
      "Area" : (map[i]["area"] != null) ? (map[i]['area']).toString() : " ",
      };
     
      if (i == 0) {
        newList = [newScan];
      } else {
        newList!.add(newScan);
      }

    }

   
    if (newList != null) {
      scanDoc.value = newList!;
    }
  
}












  var selectedArea = 'selectArea'.obs;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: 'selectArea',
        child: Text('Select Area'),
      ),
      const DropdownMenuItem(
        value: 'Head',
        child: Text('Head'),
      ),
       const DropdownMenuItem(
        value: 'Neck',
        child: Text('Neck'),
      ),
       const DropdownMenuItem(
        value: 'Back',
        child: Text('Back'),
      ),
       const DropdownMenuItem(
        value: 'Chest',
        child: Text('Chest'),
      ),
       const DropdownMenuItem(
        value: 'Torso',
        child: Text('Torso'),
      ),
       const DropdownMenuItem(
        value: 'Hips',
        child: Text('Hips'),
      ),
       const DropdownMenuItem(
        value: 'Right Arm',
        child: Text('Right Arm'),
      ),
       const DropdownMenuItem(
        value: 'Left Arm',
        child: Text('Left Arm'),
      ),
       const DropdownMenuItem(
        value: 'Right Hand',
        child: Text('Right Hand'),
      ),
       const DropdownMenuItem(
        value: 'Left Hand',
        child: Text('Left Hand'),
      ),
       const DropdownMenuItem(
        value: 'Right Leg',
        child: Text('Right Leg'),
      ),
       const DropdownMenuItem(
        value: 'Left Leg',
        child: Text('Left Leg'),
      ),
       const DropdownMenuItem(
        value: 'Right Foot',
        child: Text('Right Foot'),
      ),
       const DropdownMenuItem(
        value: 'Left Foot',
        child: Text('Left Foot'),
      ), 
    ];
    return menuItems;
  }

  
















  Future<http.StreamedResponse> getEntries() async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse(API.URL  +'/getEntries'));

    
    request.fields['email'] = Preference.shared.getString('useremail')!;
    request.fields['pass'] = Preference.shared.getString('userpass')!;

    http.StreamedResponse response = await request.send();
    return response;
  }





  Future<void> getEntriesHelper() async {
    homeIsLoading.value = true ;
    http.StreamedResponse response = await getEntries();

    

    var map = jsonDecode(await response.stream.bytesToString());

    var newList;
    _serverImages = [];

    for (var i = 0; i < map.length; i++) {
      if (map[i]["date"] == "NullList") {
        // no entries here
        scanDoc.value = scanDocTemplate;
        homeIsLoading.value = false ;
        return;
      }
      var imageBin = map[i]["imageBinary"];
      var imageDec = base64Decode(imageBin);
      _serverImages?.add(imageDec);
    
    }
    addToScanDoc(map);
 
    if(_serverImages!.isEmpty == true)
    {
      noEntries.value = true;
    }
    else 
    {
      noEntries.value = false;
    }
    homeIsLoading.value =false;
  
  }














  void onInit() {
    super.onInit();
    ever(selectedBottomIndex, (value) {
      // ignore: unrelated_type_equality_checks
      if (selectedBottomIndex != 0) {
        getEntriesHelper();
      }
    });
  }















  Future<http.StreamedResponse> deleteEntries(int index) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse(API.URL +'/deleteEntries'));

    request.fields['email'] = Preference.shared.getString('useremail')!;
    request.fields['pass'] = Preference.shared.getString('userpass')!;
    request.fields['entryID'] = scanDoc[index]["Scan"]!;
    http.StreamedResponse response = await request.send();
    return response;
  }









  Future<void> deleteEntriesHelper(int index) async {
    if (serverImages?.isEmpty == true) 
    {
      errorSnackBar(message: "no saved Enties to delete");
      return;
    }
    http.StreamedResponse response = await deleteEntries(index);
    if (response.statusCode == 200) {
      serverImages?.removeAt(index);
      if (serverImages?.isEmpty ==true) {
        scanDoc.value = scanDocTemplate;
      } 
      else 
      {
        scanDoc.removeAt(index);
      }

      if(_serverImages!.isEmpty == true)
     {
      noEntries.value = true;
     }
    else 
    {
      noEntries.value = false;
    }
     

    }
  }

  













  Future getImage({required ImageSource source}) async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );
      if (result != null) {
        Uint8List? file = result.files.first.bytes;
      
        selectedImageBytes!.value = file;
        _imagefilename = result.files.first.name.split(".").first;
        _imagefileextention = result.files.first.name.split(".").last;
        // ignore: unnecessary_null_comparison
      } else {
        log("No Image Picked");
      }
    } else {
      XFile? xfile = await imagePicker.pickImage(
        source: source,
      );
      var bytes = await xfile!.readAsBytes();
      if (xfile != null) {
        selectedImageBytes!.value = bytes;
        _imagefilename = xfile.name;
        _imagefileextention = xfile.mimeType!.split('/').last;
      }
    }
  }






















  Future<http.StreamedResponse> addEntry(
      String? filename, String? fileextention, Uint8List? data) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse(API.URL +'/addEntry'));

   
    //Check if Uint8List populated, it will or will not have an image, this image
    if (data != null) {
      request.files.add(http.MultipartFile.fromBytes("image", data,
          filename: filename,
          contentType: MediaType('image',
              fileextention!))); // can't do Multipart.from path as web has no acess to filesystem , try string , or byte
      request.fields['email'] = Preference.shared.getString('useremail')!;
      request.fields['pass'] = Preference.shared.getString('userpass')!;
      request.fields['details'] = detailsController.text;
      request.fields["area"] = selectedArea.value;
    }

    http.StreamedResponse response = await request.send();
    return response;
  }







  Future<void> addEntryHelper() async {
    http.StreamedResponse response = await addEntry(
        _imagefilename, _imagefileextention, selectedImageBytes?.value);

    var map = jsonDecode(await response.stream.bytesToString());
    
    addToScanDoc(map);

   
    Get.toNamed(Routes
        .VIEW_DETAILS_SCREEN); // having this here to transition to next page
  }
















  Future<http.StreamedResponse> deleteAccount() async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse(API.URL +'/deleteAccount'));

    request.fields['email'] = Preference.shared.getString('useremail')!;
    request.fields['pass'] = Preference.shared.getString('userpass')!;
    http.StreamedResponse response = await request.send();
    return response;
  }







  Future<void> deleteAccountHelper(BuildContext context) async {

    
    http.StreamedResponse response = await deleteAccount(
      
    );

    //_isLoading = false;
    if (response.statusCode == 200) {

      Get.offAllNamed(Routes.LOGIN_SCREEN);

    } else {
      errorSnackBar(
          message: "Unable to Delete Accounrt");
    }

  }

















Widget getPieChart(index)
{
   var copy = scanDoc[index];
   var valueList =[];
   valueList.add(copy['Melanocytic nevi']);
   valueList.add(copy['Benign keratosis-like lesions']);
   valueList.add(copy['Basal cell carcinoma']);
   valueList.add(copy['Actinic keratoses']);
   valueList.add(copy['Vascular lesions']);
   valueList.add(copy['Dermatofibroma']);
   valueList.add(copy['Melanoma']);
   valueList.add(copy['Benign']);
   valueList.add(copy['Malignant']);

   for (int i = 0 ; i < valueList.length;i++)
   {
    if ( double.parse(valueList[i]) < 1 )
    {
       valueList[i] = double.parse('0');
    }
    else
    {
      valueList[i] = double.parse(valueList[i]);
    }
   }

      Column pieCharts = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
             const Text("What our AI is predicting about your scan:"),
             PieChart( chartRadius: 40.w, legendOptions: const LegendOptions(legendPosition: LegendPosition.bottom), 
                      dataMap: {"Melanocytic nevi":valueList[0],
                           "Benign keratosis-like lesions":valueList[1],
                           "Basal cell carcinoma":valueList[2],
                           "Actinic keratoses":valueList[3],
                           "Vascular lesions":valueList[4],
                           "Dermatofibroma":valueList[5],
                           "Melanoma":valueList[6],      
                             }),
        const Text("More deatailed information on the melanoma prediction"),
        PieChart( chartRadius: 40.w , legendOptions: const LegendOptions(legendPosition: LegendPosition.bottom),
          dataMap: {"Benign":valueList[7],
           "Malignant":valueList[8]}),


        ],
      );
     return pieCharts;
}


}

















Card getHomeCard(context,cardName,index,homeController)
{
  Card cardMaker = 
   Card(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(cardName),
                const Text(":"),
                SizedBox(width: 0.5.w),
                Text(
                                      homeController.scanDoc[index][cardName]!,
                                      style: GoogleFonts.poppins(
                                        color: AppColor.textBlackColor
                                            .withOpacity(0.7),
                                        fontSize:
                                            isDesktop(context) ? 13 : 11.sp,
                                      ),
                ),
                SizedBox(width: 0.5.w),
                const Text("|"),
                IconButton(onPressed: ()
                {



                 showDialog(context: context,
                                    barrierDismissible: true,
                                     builder: (BuildContext context) {
                                      return
                                      AlertDialog(
                                        title:  Text(cardName),
                                        content: Text(glosseryTerms[cardName]!),
                                        actions: <Widget>[
                                        TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                          ),
                                        ],

                                     );
                                      }
                                      );




                },
                icon: const  Icon(Icons.question_mark_sharp)
                ),
              ],
            ),
           );

  return cardMaker;



  
  
}


















AlertDialog deleteAccountAssurance (context,homeController)
{
    AlertDialog deleteAccount =  AlertDialog(
       title:  const Text("You are about to delete your account"),
       content:const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:  Text("Are you sure you want to delete your account?"),
          ),
       
       actions: <Widget>[
            TextButton(
              onPressed: () {Navigator.pop(context, 'No');
                              
              
              } ,
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {Navigator.pop(context, 'Yes');
                         homeController.deleteAccountHelper(context);

              
              },
              child: const Text('Yes'),
            ),
          ],
       
       
        );

  


return deleteAccount;

}




















AlertDialog getExampleImage(context,homeController)
{
    AlertDialog legalDialog =  AlertDialog(
       title:  const Text("Picture taking recomendations and example"),
       content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
             Image.asset(
                      'assets/images/example.jpg',
                      height: 30.h,
                      width: 30.h,
                    ),
                  const Text("Tips to get the best results possible:"),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  
                  Text ("1. Use your device's flash"),
                  Icon(Icons.flash_on),
                  
                ],
               ), 
               const Text(" to fully light your area of concern"),                  
          ],
        ),
                


       ),
       
       actions: <Widget>[
            TextButton(
              onPressed: () async {Navigator.pop(context, 'OK');
              await homeController.getImage(source: ImageSource.gallery);
        if (homeController.selectedImageBytes!.value != null) {
          Get.toNamed(
            Routes.IMAGE_VIEW_SCREEN,
            arguments: ImageSource.gallery,
          );
        }
                            
              
              } ,
              child: const Text('OK'),
            ),
            
          ],
       
       
        );

  


return legalDialog;

}

