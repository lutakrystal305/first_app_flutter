import 'package:english_quotes/bloc/counter_bloc.dart';
import 'package:english_quotes/pages/landing_page.dart';
import 'package:english_quotes/quotes/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterBloc _counterBloc = CounterBloc(5);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
        create: (_) => _counterBloc,
        child: const MaterialApp(home: LandingPage()));
  }
}
