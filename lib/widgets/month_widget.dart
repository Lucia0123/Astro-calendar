import 'package:calendar/providers.dart';
import 'package:calendar/widgets/week_widget.dart';
import 'package:calendar/widgets/weekday_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthWidget extends ConsumerWidget{

  final int year;
  final int month;
  
  const MonthWidget({required this.year, required this.month, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final textTheme = ref.watch(themeProvider).textTheme;
    final colorScheme = ref.watch(themeProvider).colorScheme;

    List<WeekWidget> weeks = createWeeks();
    debugPrint("Context: $context");
    var dayList = List<int>.generate(_getNumberOfDays(), (int index) => index + 1);
    debugPrint("$dayList");

    // voglio che il container si adatti alla dimensione dei figli
    return Container(
      alignment: AlignmentGeometry.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: colorScheme.primary, width: 1)),
            padding: const EdgeInsets.all(3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  WeekdayLabel("Monday"),
                  WeekdayLabel("Tuesday"),
                  WeekdayLabel("Wednesday"),
                  WeekdayLabel("Thursday"),
                  WeekdayLabel("Friday"),
                  WeekdayLabel("Saturday"),
                  WeekdayLabel("Sunday")
                ]),
                for (var i = 0; i < weeks.length; i++)
                weeks[i]
              ],
            ),
          ),
        ],
      ),
    );
  }

  // versione con gridview.builder al posto di WeekWidget:
  // GridView.builder(
  //           shrinkWrap: true,
  //           //physics: NeverScrollableScrollPhysics(),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 7,
  //             childAspectRatio: 1.0,
  //             mainAxisSpacing: 5.0,
  //             crossAxisSpacing: 5.0,
  //             ),
  //           itemCount: _getNumberOfDays(),
  //           itemBuilder: (context, index){
  //             final item = dayList[index];
  //             debugPrint("Building dayList element $index: $item");
  //             return DayWidget(date: DateTime(year, month, item));   // "item" + month + year
  //           })

  List<WeekWidget> createWeeks(){
    WeekWidget firstWeek = WeekWidget(initialDate: DateTime(year, month, 1));
    List<WeekWidget> weeks = [firstWeek];
    int i = 1;
    for (WeekWidget week = firstWeek; i < 6; week = weeks.last, i++) {
      debugPrint("Iterazione numero $i, week: $week con initialDate ${week.initialDate} e finalDate ${week.getFinalDate()}");
      DateTime date = DateTime(week.getFinalDate().year, week.getFinalDate().month, week.getFinalDate().day + 1);
      debugPrint("La nuova data iniziale è $date");
      if(date.month == month){
        weeks.add(WeekWidget(initialDate: date));
      }
    }
    return weeks;
  }

  int _getNumberOfDays(){
    int nDays = DateUtils.getDaysInMonth(DateTime.now().year, month);
    debugPrint("$nDays");
    return nDays;
  }

}