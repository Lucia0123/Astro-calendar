import 'package:calendar/providers.dart';
import 'package:calendar/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoonriseContent extends ConsumerWidget{
  const MoonriseContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = ref.watch(themeProvider).textTheme;
    final colorScheme = ref.watch(themeProvider).colorScheme;
    final asyncRiseAndSet = ref.watch(riseAndSetProvider);

    final textStyle = textTheme.displayMedium?.copyWith(color: colorScheme.onSurface);

    return asyncRiseAndSet.when(
      data: (map){
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(flex: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                TextWidget(Text("Sunrise: ${map["sunrise"]}", style: textStyle)),
                TextWidget(Text("Sunset: ${map["sunset"]}", style: textStyle)),
                TextWidget(Text("Moonrise: ${map["moonrise"]}", style: textStyle)),
                TextWidget(Text("Moonset: ${map["moonset"]}", style: textStyle)),
            ]),
            Spacer(flex: 1),
            Align(
              alignment: Alignment.bottomRight,
              child: Text("Information from https://www.radiantdrift.com",
                      style: textTheme.displaySmall?.copyWith(color: colorScheme.onPrimaryContainer)),
            )
          ],
        );
      },
      error: (error, stackTrace){
        // display the error
        return Center(child: Text("$error", style: textTheme.displaySmall?.copyWith(color: colorScheme.onPrimaryContainer)));
      },
      loading: (){
        // still loading the data
        return Center(child: CircularProgressIndicator());
      });
  }
}