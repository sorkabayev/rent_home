import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar homeAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: const Image(
      image: AssetImage('assets/logo/picco.png'),
      width: 70,
      height: 71,
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          CupertinoIcons.person,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Padding categoryTextWithPadding(String text) => Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
      ),
    );
