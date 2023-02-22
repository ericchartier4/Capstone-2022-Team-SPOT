import 'dart:developer';
import 'dart:io';
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

class HomeController extends GetxController {
  var selectedBottomIndex = 0.obs;
  var selectedIndex = 0.obs;
  var isExpanded = false.obs;
  final ScrollController aboutController = ScrollController();
  final ScrollController doctorController = ScrollController();
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
  List<Uint8List>? _serverImages;
  List<Uint8List>? get serverImages => _serverImages;

  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;
  String? _bresults;
  String? get bresult => _bresults;
  String? _mresults;
  String? get mresult => _mresults;

  var scanDoc = [
    {
      "status": "Complate",
      "scan": "#doc1597",
      "date": "14-Nov-2022",
      "about":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "doctor":
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "status": "In-Progress",
      "scan": "#doc1598",
      "date": "15-Nov-2022",
      "about":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "doctor":
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "status": "Complate",
      "scan": "#doc1597",
      "date": "14-Nov-2022",
      "about":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "doctor":
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "status": "In-Progress",
      "scan": "#doc1598",
      "date": "15-Nov-2022",
      "about":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "doctor":
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "status": "Complate",
      "scan": "#doc1597",
      "date": "14-Nov-2022",
      "about":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "doctor":
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "status": "In-Progress",
      "scan": "#doc1598",
      "date": "15-Nov-2022",
      "about":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "doctor":
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    }
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

// method to help get the scan doc
  Future<void> getEntriesHelper() async {
    http.StreamedResponse response = await getEntries();

    //_isLoading = false;
    //if (response.statusCode == 200) {

    var map = jsonDecode(await response.stream.bytesToString());

    print(map);
    var newList;
    _serverImages = [];
    for (var i = 0; i < map.length; i++) {
      var about =
          (map[i]["about"] != null) ? (map[i]['about']).toString() : " ";
      var scan = (map[i]["scan"] != null) ? (map[i]['scan']).toString() : " ";
      var status =
          (map[i]["status"] != null) ? (map[i]['status']).toString() : " ";
      var date = (map[i]["date"] != null) ? (map[i]['date']).toString() : " ";
      var doctor =
          (map[i]["doctor"] != null) ? (map[i]['doctor']).toString() : " ";
      print(about);
      print(scan);
      print(status);
      print(date);
      print(doctor);
      var newScan = {
        "status": status,
        "scan": scan,
        "date": date,
        "about": about,
        "doctor": doctor,
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
    print(scanDoc);
    //_imagePath=message;
    // _pickedFile = null;
    //await getUserInfo();
    //print(message);
    //} else {
    //print("error posting the image");
    //} // having this here to transition to next page
  }

  Future<http.StreamedResponse> getEntries() async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/getEntries'));

    //request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    //Check if Uint8List populated, it will or will not have an image, this image
    request.fields['email'] = Preference.shared.getString('useremail')!;
    request.fields['pass'] = Preference.shared.getString('userpass')!;

    http.StreamedResponse response = await request.send();
    return response;
  }

// creating listener to call a method to change the scan doc when ever bottom index is changed
//calls get entries helper to get the entries of the scan doc
  void onInit() {
    super.onInit();
    ever(selectedBottomIndex, (value) {
      getEntriesHelper();
    });
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
        _imagefilename = result.files.first.name.split(".").first;
        _imagefileextention = result.files.first.name.split(".").last;
        selectedImageBytes!.value = file;
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

  Future<void> addEntryHelper() async {
    http.StreamedResponse response = await addEntry(
        _imagefilename, _imagefileextention, selectedImageBytes?.value);

    //_isLoading = false;
    //if (response.statusCode == 200) {
    Map map = jsonDecode(await response.stream.bytesToString());
    String benign = map["benign"];
    //malignent
    String malignent = map["malignent"];

    _mresults = malignent;
    _bresults = benign;
    //_imagePath=message;
    // _pickedFile = null;
    //await getUserInfo();
    //print(message);
    //} else {
    //print("error posting the image");
    //}
    Get.toNamed(Routes
        .VIEW_DETAILS_SCREEN); // having this here to transition to next page
  }

  Future<http.StreamedResponse> addEntry(
      String? filename, String? fileextention, Uint8List? data) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/addEntry'));

    //request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
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
}
