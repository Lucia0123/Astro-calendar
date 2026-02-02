import 'dart:math';

import 'package:apsl_sun_calc/apsl_sun_calc.dart';
import 'package:calendar/providers.dart';
import 'package:calendar/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_phase/moon_widget.dart';

class MoonphaseContent extends ConsumerWidget{
  const MoonphaseContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final DateTime date;
    // coordinate di Pesaro
    final double latitude = 43.91;
    final double longitude = 12.92;
    final date = ref.watch(dateProvider);
    final colorScheme = ref.watch(themeProvider).colorScheme;
    final textTheme = ref.watch(themeProvider).textTheme;
    final textStyle = textTheme.displayMedium?.copyWith(color: colorScheme.onSurface);

    final moonPosition = SunCalc.getMoonPosition(date, latitude, longitude);
    debugPrint("$moonPosition");

    // Conversione da radianti a gradi
    double azimuthDegrees = moonPosition['azimuth']! * 180 / pi;
    double altitudeDegrees = moonPosition['altitude']! * 180 / pi;
    double parallacticAngleDegrees = moonPosition['parallacticAngle']! * 180 / pi;

    return Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MoonWidget.simple(
                            date: date,
                            size: 150,
                            moonColor: Colors.amber,
                            earthshineColor: Colors.black87,
                            pixelSize: 0.4,
                          ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
            TextWidget(Text("Azimuth: ${normalizeAzimuth(azimuthDegrees).round()} °", style: textStyle)),
            TextWidget(Text("Altitude: ${normalizeAzimuth(altitudeDegrees).round()} °", style: textStyle)),
            TextWidget(Text("Parallactic angle: ${normalizeAzimuth(parallacticAngleDegrees).round()} °", style: textStyle))
          ],)
        ],
      );
  }

  static double normalizeAzimuth(double degrees) {
    return degrees < 0 ? degrees + 360 : degrees;
  }
}