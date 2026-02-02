import 'package:calendar/widgets/day_widget.dart';
import 'package:flutter/material.dart';

// WeekWidget controlla quali DayWidget sono accesi, quali spenti, quali contrassegnati (domenica, ecc.)
class WeekWidget extends StatelessWidget {

  final DateTime? initialDate;  // prima data da mostrare nella settimana corrente
  //final DateTime finalDate;   // ultima data mostrata nella settimana corrente

  const WeekWidget({this.initialDate, super.key});

// ogni settimana va da lunedi a domenica, e quindi ha di default 7 DayWidget.
  @override
  Widget build(BuildContext context) {
    debugPrint("In questa settimana initialDate: $initialDate e finalDate: ${getFinalDate()}");
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for(var i = 1; i <= 7; i++)
        Flexible(child: DayWidget(date: getDateForDayWidget(i)))
      ],
    );
  }
  // come passo la data iniziale al daywidget giusto?

  // restituisce il giorno della settimana di una certa data
  static int getWeekDayOf(DateTime date){
    debugPrint("Il weekday di $date è ${date.weekday}");
    return date.weekday;
  }

  // restituisce la data finale/massima mostrata in questa settimana
  DateTime getFinalDate(){
    switch (initialDate?.weekday) {
      case 1:   // lunedi
        return initialDate!.add(Duration(days: 6));
      case 2:   // martedi
        return initialDate!.add(Duration(days: 5));
      case 3:   // mercoledi
        return initialDate!.add(Duration(days: 4));
      case 4:   // ..
        return initialDate!.add(Duration(days: 3));
      case 5:   
        return initialDate!.add(Duration(days: 2));
      case 6:  
        return initialDate!.add(Duration(days: 1));
      case 7:  
        return initialDate!;
      default:
        return initialDate!;
    }
  }

  // controlla se esiste una data con quel weekday nella settimana corrente
  // restituisce (se esistente) la data da mettere nello specifico weekday
  DateTime? getDateForDayWidget(int weekdayOfWidget){
    int initialWeekDay = initialDate!.weekday;
    int finalWeekDay = getFinalDate().weekday;

    if(weekdayOfWidget >= initialWeekDay && weekdayOfWidget <= finalWeekDay){
      // allora restituisco il DateTime corrispondente a quello specifico weekday
      for (var day = initialWeekDay, date = initialDate; day <= finalWeekDay; day++, date = date?.add(Duration(days: 1))) {
        if(day == weekdayOfWidget && date?.month == initialDate?.month){
          // restituisci data di quel giorno della settimana
          debugPrint("In questa settimana a $weekdayOfWidget corrisponde il $date");
          return date;
        }
      }
    }
    return null;
  }
}