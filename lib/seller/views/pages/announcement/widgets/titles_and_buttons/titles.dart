import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rent_home/seller/views/pages/announcement/provider.dart';
import 'package:provider/provider.dart';

class Titles extends StatelessWidget {
  const Titles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headers =
        context.select((AnnouncementProvider provider) => provider.headers);
    final currentPageIndex = context
        .select((AnnouncementProvider provider) => provider.currentPageIndex);
    return Text(
      headers[currentPageIndex],
      style: TextStyle(
        color: Colors.white,
        fontSize: 23.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
