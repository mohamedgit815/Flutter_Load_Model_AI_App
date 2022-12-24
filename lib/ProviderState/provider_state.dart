import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class BooleanState extends ChangeNotifier {
  bool boolean = true;

  bool switchBoolean(){
    notifyListeners();
    return boolean = !boolean;
  }

  bool trueBoolean(){
    notifyListeners();
    return boolean = true;
  }

  bool falseBoolean(){
    notifyListeners();
    return boolean = false;
  }
}

class IntegerState extends ChangeNotifier {
  /// Integer
  int integer = 0;

  int equalValueInteger(int v) {
    notifyListeners();
    return integer = v;
  }
}

class StringState extends ChangeNotifier {
  /// Strings
  String strings = '';

  String equalValueString(String v){
    notifyListeners() ;
    return strings = v;
  }

  void equalStringNull(){
    strings = '';
    notifyListeners();
  }
}

// class PreferencesState extends ChangeNotifier {
//   /// To Load Data by Shared Preferences
//
//   late String _key;
//   SharedPreferences? _prefs;
//   late bool _darkTheme;
//
//   bool get darkTheme => _darkTheme;
//
//   PreferencesState(String key) {
//     _darkTheme = true;
//     _key = key;
//     _loadFromPrefs();
//   }
//
//
//   toggleTheme() {
//     _darkTheme = !_darkTheme;
//     _saveToPrefs();
//     notifyListeners();
//   }
//
//
//   _initPrefs() async {
//     _prefs ??= await SharedPreferences.getInstance();
//   }
//
//
//   _loadFromPrefs() async {
//     await _initPrefs();
//     _darkTheme = _prefs!.getBool(_key) ?? true;
//     notifyListeners();
//   }
//
//
//   _saveToPrefs() async {
//     await _initPrefs();
//     await _prefs!.setBool(_key, _darkTheme);
//   }
// }

class ImagePickerState extends ChangeNotifier {
  /// To Get Images from Gallery or Camera

  File? fileImage;
  Future<void> getImagePicker({
    required GlobalKey<ScaffoldMessengerState> scaffoldState ,
    required BuildContext context,required ImageSource imageSource}) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: imageSource);

      if (image != null) {
        fileImage = File(image.path);
      }
      else {
        scaffoldState.currentState!.showSnackBar(const SnackBar(content: Text('your arn\'t selected Image')));
      }
      notifyListeners();
    }on PlatformException catch(_) {
      scaffoldState.currentState!.showSnackBar(const SnackBar(content: Text('your arn\'t selected Image')));
    }
  }

  void deleteImagePicker(){
    fileImage = null;
    notifyListeners();
  }


}

class LoadImageAIState extends ChangeNotifier {
  List<dynamic>? outputs;


  Future<List<dynamic>?> classifyImage(File image) async {
    final List<dynamic>? output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
      outputs = output!;
      notifyListeners();
    return output;
  }


  void deleteOutPuts() {
    outputs = null;
    notifyListeners();
  }
}