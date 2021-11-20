import 'dart:convert';

import 'package:english_quotes/model/english_today.dart';
import 'package:english_quotes/values/app_color.dart';
import 'package:english_quotes/values/app_style.dart';
import 'package:english_quotes/values/share_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavorPage extends StatefulWidget {
  const FavorPage({Key? key}) : super(key: key);

  @override
  _FavorPageState createState() => _FavorPageState();
}

class _FavorPageState extends State<FavorPage> {
  late SharedPreferences prefs;
  List<EnglishToday> words = [];

  @override
  void initState() {
    super.initState();
    initDefaultFavor();
  }

  List<EnglishToday> a = [];
  void initDefaultFavor() async {
    prefs = await SharedPreferences.getInstance();
    final List<String> stringWords = prefs.getStringList(ShareKey.favor) ?? [];
    debugPrint('${jsonDecode(stringWords[0])}');
    a = stringWords.map((z) => EnglishToday.fromJson(jsonDecode(z))).toList();
    debugPrint('$a');
    setState(() {
      words = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<Widget> tiles = words.map((EnglishToday x) => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.green[900],
            border: Border.all(width: 1.0, color: const Color(0xffffffff))),
        child: ListTile(
            title: Text('${x.noun}',
                style: AppStyle.h4.copyWith(color: AppColor.textColor)))));
    final List<Widget> divide =
        ListTile.divideTiles(tiles: tiles, context: context).toList();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.secondColor,
            title: Text('Favorite words',
                style: AppStyle.h4
                    .copyWith(fontSize: 36, color: AppColor.textColor))),
        body: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: divide,
            )));
  }
}
