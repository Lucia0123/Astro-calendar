import 'package:riverpod/legacy.dart';

class DateNotifier extends StateNotifier<DateTime>{
  DateNotifier(super.date);

  void updateDate(DateTime newDate){
    state = newDate;
  }

}