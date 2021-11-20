import 'package:english_quotes/bloc/counter_bloc.dart';
import 'package:english_quotes/pages/home_page.dart';
import 'package:english_quotes/values/app_color.dart';
import 'package:english_quotes/values/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter/services.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        home: Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome to',
                      style: AppStyle.h3,
                    ),
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('English',
                          style: AppStyle.h2.copyWith(
                              color: Colors.red[900],
                              fontWeight: FontWeight.bold)),
                      Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Quotes',
                            style: AppStyle.h4.copyWith(height: 0.5),
                            textAlign: TextAlign.right,
                          ))
                    ],
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 72),
                    child: IconButton(
                      padding: const EdgeInsets.all(32.0),
                      iconSize: 60,
                      icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000.0),
                              color: Colors.lightGreen[400]),
                          child: const Icon(Icons.navigate_next)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MaterialApp(home: HomePage())),
                        );
                      },
                    ),
                  ))
                ],
              ),
            )));
  }
}
//BlocProvider<CounterBloc>(
  //                                create: (_) => CounterBloc(5),
    //                              child:
