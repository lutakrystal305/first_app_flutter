import 'package:english_quotes/values/app_color.dart';
import 'package:english_quotes/values/app_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: const Color(0xffffffff))),
            child: Text(label,
                style: AppStyle.h5.copyWith(color: AppColor.textColor))));
  }
}
