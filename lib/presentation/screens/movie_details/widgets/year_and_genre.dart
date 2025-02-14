import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YearAndGenre extends StatelessWidget {
  final int year;
  final List<String> genre;
  const YearAndGenre({super.key, required this.year, required this.genre});

  @override
  Widget build(BuildContext context) {
    String concatenatedString = genre.join('-');
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5.sp,
      children: [
        Text(
          '$year',
          style: TextStyle(
              fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.9)),
        ),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.9)),
        ),
        AutoSizeText(
          concatenatedString,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.9)),
        ),
      ],
    );
  }
}
