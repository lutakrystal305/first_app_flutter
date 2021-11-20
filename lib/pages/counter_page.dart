import 'package:english_quotes/bloc/counter_bloc.dart';
import 'package:english_quotes/values/app_color.dart';
import 'package:english_quotes/values/app_style.dart';
import 'package:english_quotes/values/share_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  double valueWord = 5;
  late SharedPreferences prefs;
  //@override
  //void initState() {
  //  super.initState();
  //  initDefaultValue();
  //}

  /*initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKey.counter) ?? 5;
    setState(() {
      valueWord = value.toDouble();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);
    return BlocBuilder<CounterBloc, int>(
        bloc: _counterBloc,
        builder: (context, state) => Scaffold(
            backgroundColor: AppColor.secondColor,
            appBar: AppBar(
              backgroundColor: AppColor.secondColor,
              title: Text(
                'English today',
                style: AppStyle.h4
                    .copyWith(fontSize: 36, color: AppColor.textColor),
              ),
              /*leading: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt(ShareKey.counter, valueWord.toInt());
                Navigator.pop(context);
              },
              child:
                  const Icon(Icons.arrow_back_ios, color: AppColor.textColor))*/
            ),
            body: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                child: Column(children: [
                  const Spacer(),
                  Text('How much a number words at once',
                      style: AppStyle.h4.copyWith(color: Colors.black38)),
                  const Spacer(),
                  Text('$state'),
                  Slider(
                    value: state.toDouble(),
                    min: 5,
                    max: 100,
                    divisions: 95,
                    onChanged: (value) {
                      context.read<CounterBloc>().changeCount(value);
                    },
                  ),
                  const Spacer(),
                  const Spacer(),
                ]))));
  }
}
