import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:demo/Utils/preference.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../Routes/routes.dart';
import '../Utils/preference.dart';
import '../Utils/constant_widgets.dart';
import '../utils/api_manager.dart' ;

class HomeController extends GetxController {
  var selectedBottomIndex = 0.obs;
  var selectedIndex = 0.obs;
  var isExpanded = false.obs;
  final ScrollController aboutController = ScrollController();
  TextEditingController detailsController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  // Rx<File> selectedImageFile = File('').obs;
  Rxn<Uint8List>? selectedImageBytes = Rxn<Uint8List>();
  String? _imagefilename;
  String? get imagefilename => _imagefilename;
  String? _imagefileextention;
  String? get imagefileextention => _imagefileextention;
  Uint8List? _encodedImage;
  Uint8List? get encodedImage => _encodedImage;
  List<Uint8List>? _serverImages = [];
  List<Uint8List>? get serverImages => _serverImages;

  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;
  String? _melResultViewDetails;
  String? get melResultViewDetails =>_melResultViewDetails ;
  String? _melBenResultViewDetails; 
  String? get melBenResultViewDetails => _melBenResultViewDetails ; 
  String? _melMaligResultViewDetails;
  String? get melMaligResultViewDetails  => _melMaligResultViewDetails ;
  String? _nVResultViewDetails;
  String? get nVResultViewDetails => _nVResultViewDetails ;
  String? _bKLResultViewDetails;
  String? get bKLResultViewDetails => _bKLResultViewDetails ; 
  String? _bCCResultViewDetails;
  String? get bCCResultViewDetails => _bCCResultViewDetails ;
  String? _akiecResultViewDetails;
  String? get akiecResultViewDetails => _akiecResultViewDetails ; 
  String? _vascResultViewDetails;
  String? get vascResultViewDetails => _vascResultViewDetails ;
  String? _dFResultViewDetails;
  String? get dFResultViewDetails => _dFResultViewDetails ;

  RxBool homeIsLoading = false.obs;

  

  var scanDoc = [
    {
    'NV': 'null',
     'Mel': 'null',
     'BKL': 'null ',
     'BCC': 'null',
     'Akiec': 'null',
     'Vasc': 'null',
     'DF': 'null',
     'MelBen' : 'null',
     'MelMalig' : 'null',
      "Scan": "null",
      "Date": "null",
      "About": "null",
      
    },
  ].obs;
  var selectedArea = 'selectArea'.obs;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: 'selectArea',
        child: Text('Select Area'),
      ),
      const DropdownMenuItem(
        value: 'Knee',
        child: Text('Knee'),
      ),
      const DropdownMenuItem(
        value: 'Arm',
        child: Text('Arm'),
      ),
      const DropdownMenuItem(
        value: 'Back',
        child: Text('Back'),
      ),
    ];
    return menuItems;
  }

  /// get entries
  Future<http.StreamedResponse> getEntries() async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse(API.URL  +'/getEntries'));

    
    request.fields['email'] = Preference.shared.getString('useremail')!;
    request.fields['pass'] = Preference.shared.getString('userpass')!;

    http.StreamedResponse response = await request.send();
    return response;
  }

// method to help get the scan doc
  Future<void> getEntriesHelper() async {
    homeIsLoading.value = true ;
    http.StreamedResponse response = await getEntries();

    

    var map = jsonDecode(await response.stream.bytesToString());

    var newList;
    _serverImages = [];

    for (var i = 0; i < map.length; i++) {
      if (map[i]["EntryDate"] == "NullList") {
        // no entries here
        scanDoc.value = [
          {
     'NV': 'null',
     'Mel': 'null',
     'BKL': 'null ',
     'BCC': 'null',
     'Akiec': 'null',
     'Vasc': 'null',
     'DF': 'null',
     'MelBen' : 'null',
     'MelMalig' : 'null',
      "Scan": "null",
      "Date": "null",
      "About": "null",
      
          }
        ];
        homeIsLoading.value = false ;
        return;
      }
      var about =
          (map[i]["about"] != null) ? (map[i]['about']).toString() : " ";
      var scan = (map[i]["scan"] != null) ? (map[i]['scan']).toString() : " ";
      var nVResult = (map[i]["nVResult"] != null) ? (map[i]['nVResult']).toString() : " ";
      var bKLResult = (map[i]["bKLResult"] != null) ? (map[i]['bKLResult']).toString() : " ";
      var bCCResult = (map[i]["bCCResult"] != null) ? (map[i]['bCCResult']).toString() : " ";
      var akiecResult = (map[i]["akiecResult"] != null) ? (map[i]['akiecResult']).toString() : " ";
      var vascResult = (map[i]["vascResult"] != null) ? (map[i]['vascResult']).toString() : " ";
      var dFResult = (map[i]["dFResult"] != null) ? (map[i]['dFResult']).toString() : " ";
      var melResult = (map[i]["melResult"] != null) ? (map[i]['melResult']).toString() : " ";
      var melBenResult = (map[i]["melBenResult"] != null) ? (map[i]['melBenResult']).toString() : " ";
      var melMaligResult = (map[i][" melMaligResult"] != null) ? (map[i][' melMaligResult']).toString() : " ";
      var date = (map[i]["date"] != null) ? (map[i]['date']).toString() : " ";
    
      var newScan = {
      'NV': nVResult,
     'Mel': melResult,
     'BKL': bKLResult,
     'BCC': bCCResult,
     'Akiec': akiecResult,
     'Vasc': vascResult,
     'DF': dFResult,
     'MelBen' : melBenResult,
     'MelMalig' : melMaligResult,
      "Scan": scan,
      "Date": date,
      "About": about,
      };
      var imageBin = map[i]["imageBinary"];
      var imageDec = base64Decode(imageBin);
      _serverImages?.add(imageDec);
      print(imageDec);
      if (i == 0) {
        newList = [newScan];
      } else {
        newList!.add(newScan);
      }
    }
    print(scanDoc);
    if (newList != null) {
      scanDoc.value = newList!;
    }
    homeIsLoading.value =false;
  
  }

// creating listener to call a method to change the scan doc when ever bottom index is changed
//calls get entries helper to get the entries of the scan doc
  void onInit() {
    super.onInit();
    ever(selectedBottomIndex, (value) {
      // ignore: unrelated_type_equality_checks
      if (selectedBottomIndex != 0) {
        getEntriesHelper();
      }
    });
  }

  /// delete entries
  ///
  ///
  ///
  Future<http.StreamedResponse> deleteEntries(int index) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse(API.URL +'/deleteEntries'));

    //request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    //Check if Uint8List populated, it will or will not have an image, this image
    request.fields['email'] = Preference.shared.getString('useremail')!;
    request.fields['pass'] = Preference.shared.getString('userpass')!;
    request.fields['entryID'] = scanDoc[index]["scan"]!;

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<void> deleteEntriesHelper(int index) async {
    if (serverImages?.isEmpty == true) //  meaning there are no entries in this list when called
    {
      errorSnackBar(message: "no saved Enties to delete");
      return;
    }
    http.StreamedResponse response = await deleteEntries(index);
    if (response.statusCode == 200) {
      serverImages?.removeAt(index);
      if (serverImages?.isEmpty ==true) {
        scanDoc.value = [
          {
         'NV': 'null',
     'Mel': 'null',
     'BKL': 'null ',
     'BCC': 'null',
     'Akiec': 'null',
     'Vasc': 'null',
     'DF': 'null',
     'MelBen' : 'null',
     'MelMalig' : 'null',
      "Scan": "null",
      "Date": "null",
      "About": "null",
          }
        ];
        return;
      } 
      else 
      {
        scanDoc.removeAt(index);
        return;
      }
     

    }
  }

  ///
  /// Get image from gallery/camera
  ///
  Future getImage({required ImageSource source}) async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );
      if (result != null) {
        Uint8List? file = result.files.first.bytes;
        print(file);
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
    }

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<void> addEntryHelper() async {
    http.StreamedResponse response = await addEntry(
        _imagefilename, _imagefileextention, selectedImageBytes?.value);

    Map map = jsonDecode(await response.stream.bytesToString());


      _nVResultViewDetails = (map["nVResult"] != null) ? (map['nVResult']).toString() : " ";
      _bKLResultViewDetails = (map["bKLResult"] != null) ? (map['bKLResult']).toString() : " ";
      _bCCResultViewDetails = (map["bCCResult"] != null) ? (map['bCCResult']).toString() : " ";
      _akiecResultViewDetails = (map["akiecResult"] != null) ? (map['akiecResult']).toString() : " ";
      _vascResultViewDetails = (map["vascResult"] != null) ? (map['vascResult']).toString() : " ";
      _dFResultViewDetails = (map["dFResult"] != null) ? (map['dFResult']).toString() : " ";
      _melResultViewDetails= (map["melResult"] != null) ? (map['melResult']).toString() : " ";
      _melBenResultViewDetails = (map["melBenResult"] != null) ? (map['melBenResult']).toString() : " ";
      _melMaligResultViewDetails= (map[" melMaligResult"] != null) ? (map[' melMaligResult']).toString() : " ";

   
    Get.toNamed(Routes
        .VIEW_DETAILS_SCREEN); // having this here to transition to next page
  }
}
