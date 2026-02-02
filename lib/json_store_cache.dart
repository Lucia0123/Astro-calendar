import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class JsonStoreCache {

 void saveData(String startDate, Map<String,String> map) async {
    final dataToSave = jsonEncode(map);
    localStorage.setItem(startDate, dataToSave);
  }

  Future<Map<String, String>> getData(String startDate) async {
    final savedData = localStorage.getItem(startDate);
    if(savedData != null){
      dynamic json = jsonDecode(savedData);
      Map<String, String> data = Map<String, String>.from(json as Map<String, dynamic>);
      debugPrint("Data: $data of type ${data.runtimeType}");
      return data;
    }
    return {};
  }
}