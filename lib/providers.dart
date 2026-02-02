import 'dart:convert';

import 'package:calendar/json_store_cache.dart';
import 'package:calendar/models/custom_theme_data.dart';
import 'package:calendar/notifiers/date_notifier.dart';
import 'package:calendar/notifiers/navigation_notifier.dart';
import 'package:calendar/notifiers/seed_color_notifier.dart';
import 'package:calendar/pages/moonphase_content.dart';
import 'package:calendar/pages/moonrise_content.dart';
import 'package:calendar/widgets/month_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:riverpod/legacy.dart';
import 'package:riverpod/riverpod.dart';

// provider of the app name
final appNameProvider = Provider((ref){   // sort of a stateless provider
  debugPrint("Creating appNameProvider");
  return "Astro-calendar® v1.0";
});

// provider of the app theme
final themeProvider = Provider((ref) {
  debugPrint("Creating themeProvider");
  final seedColor = ref.watch(seedColorProvider);
  return CustomThemeData.build(seedColor);
});

// Provider per il colore seed dell'app
final seedColorProvider = StateNotifierProvider<SeedColorNotifier, Color>((ref) {
  localStorage.getItem("color");
  return SeedColorNotifier(Colors.green);
});

// provider of the month name
final monthNameProvider = Provider((ref){   // sort of a stateless provider
  debugPrint("Creating monthNameProvider");
  // placeholder is a trick to shift the index value of the month. Doing this, we are coherent wih DateTime indexes for months (1 to 12)
  return ["Placeholder", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
});

// provider of the actual viewed month
final monthProvider = StateProvider<MonthWidget>((ref){
    debugPrint("Creating monthProvider..");
    return MonthWidget(year: DateTime.now().year, month: DateTime.now().month);
});

// provider of the selected date
final dateProvider = StateNotifierProvider<DateNotifier,DateTime>((ref){
  return DateNotifier(DateTime.now());
});

// provider of the actual index of BottomNavigationBar
final indexProvider = StateNotifierProvider<NavigationNotifier, int>((ref){
  return NavigationNotifier(0);
});

// provider of the actual content when navigating the BottomNavigationBar
final activeContentProvider = StateProvider<Widget>((ref){
  final index = ref.watch(indexProvider);
  switch (index) {
    case 0:
      return MoonphaseContent();
    case 1:
      return MoonriseContent();
    default:
      return MoonphaseContent();
  }
});

// provider of rise and set times for moon and sun
final riseAndSetProvider = FutureProvider<Map<String, String>>((ref) async {
  final apiKey = "zOEEZcdLi_rnQfW1z0OBv";
  final startDate = ref.watch(dateProvider);
  final endDate = startDate.add(Duration(days: 1)).toUtc();
  final cache = JsonStoreCache();

  // if the data is available locally, there's no need to send a request
  final savedData = await cache.getData(startDate.toString());
  if(savedData.isEmpty){
    // make HTTP GET request
    final Map<String,String> queryParameters = {
      "apiKey" : apiKey,
      "observer" : "43.91,12.92,0",   // coordinate di Pesaro
      "body" : "sun,moon"
    };

    debugPrint("FETCHING ECLIPSE DATA");
    final url = Uri.https(
      'api.radiantdrift.com',
      '/rise-transit-set/$startDate/$endDate',
      queryParameters
    );

    final response = await http.get(url);

    if(response.statusCode != 200){
      debugPrint("FAILED TO FETCH DATA.. error ${response.statusCode}");
      throw Exception("Failed to fetch data - the status code of the response is ${response.statusCode}");
    }

    debugPrint("DATA FETCHED SUCCESSFULLY");
    debugPrint("RESPONSE BODY: ${response.body}");

    dynamic json = jsonDecode(response.body);
    Map<String, dynamic> jsonMap = json["response"] as Map<String, dynamic>;
    final todayDateKey = jsonMap.keys.first;
    final data = jsonMap[todayDateKey] as List<dynamic>;     // qua sono contenuti tutti i dati (sunrise, sunset, moonrise, moonset)

    final dataMap = <String, String>{};
    for (var d in data) {
      debugPrint("\n$d \n${d["date"]}");
      final String key = d["key"];
      final String date = d["date"];
      final time = DateTime.parse(date);
      final formattedTime = DateFormat('HH:mm:ss').format(time.toLocal());

      dataMap[key] = formattedTime;
    }
    debugPrint("dataMap: $dataMap");

    // save dataMap
    cache.saveData(startDate.toString(), dataMap);

    return dataMap;
  }
  // if the data was already saved, then:
  return savedData;
});