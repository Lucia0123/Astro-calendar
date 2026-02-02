import 'package:calendar/pages/day_page.dart';
import 'package:calendar/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_phase/moon_phase.dart';

class DayWidget extends ConsumerWidget {

  final DateTime? date; // date with day, month and year

  const DayWidget({this.date, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(themeProvider).colorScheme;
    final textTheme = ref.watch(themeProvider).textTheme;
    //final pageProvider = ref.watch(dayPageProvider);

    debugPrint("Created DayWidget");
    return Material(
      child: InkWell(
        mouseCursor: date != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onTap: (date != null) ? () {
          debugPrint("TAPPED ON DAY $date");
          // this will push the new page on top of the existing one:
          //ref.read(dayPageProvider.notifier).state = DayPage(date!);
          // ref.read(dateProvider.notifier).state = date!;
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DayPage(selectedDate)));
          final dateNotifier = ref.read(dateProvider.notifier);
          dateNotifier.updateDate(date!);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DayPage()));
        } : null,
        hoverColor: colorScheme.primaryContainer,
        splashColor: colorScheme.onPrimaryContainer,
        child: Container(
          margin: const EdgeInsets.all(8),
          width: 75,
          height: 60,
          child: Column(
            children: [
              if (date != null)
                Align(
                alignment: Alignment.centerRight,
                child: MoonWidget.simple(
                  date: date!,
                  size: 20,
                  moonColor: Colors.amber,
                  earthshineColor: Colors.black87,
                  pixelSize: 0.4,
                ),
              ),
              Center(
                child: Text(
                  "${getDay() ?? ' '}",
                  style: (date?.weekday == 7) ? textTheme.displayMedium?.copyWith(color: Colors.red) : textTheme.displayMedium?.copyWith(color: colorScheme.onPrimaryContainer))),
            ],
          )),
      ),
    );
  }

  int? getDay(){
    return date?.day;
  }
  
}