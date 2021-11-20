import 'dart:convert';
import 'dart:math';

import 'package:english_quotes/bloc/counter_bloc.dart';
import 'package:english_quotes/model/english_today.dart';
import 'package:english_quotes/pages/counter_page.dart';
import 'package:english_quotes/pages/favorite_page.dart';
import 'package:english_quotes/values/app_color.dart';
import 'package:english_quotes/values/app_style.dart';
import 'package:english_quotes/values/share_key.dart';
import 'package:english_quotes/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:english_words/english_words.dart';
import 'package:english_quotes/quotes/quote.dart';
import 'package:english_quotes/quotes/quote_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:english_quotes/quotes/quotes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  int _currentIndex = 0;
  var _pageController = PageController();

  List<EnglishToday> words = [];
  List<EnglishToday> favorWordList = [];
  List<String> favorWords = [];

  late List<EnglishToday> _b = [];
  String quote = Quotes().getRandom().content!;

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKey.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    for (var index in rans) {
      newList.add(nouns[index]);
    }
    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });
  }

  getEngLishFavor() async {
    prefs = await SharedPreferences.getInstance();
    favorWords = prefs.getStringList(ShareKey.favor)!;
    //favorWordList = jsonDecode(favorWords);
    _b = (favorWordList.isNotEmpty ? favorWordList : []);
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);
    //debugPrint('$words');
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColor.secondColor,
        appBar: AppBar(
          backgroundColor: AppColor.secondColor,
          elevation: 0,
          title: Text(
            'English today',
            style:
                AppStyle.h4.copyWith(fontSize: 36, color: AppColor.textColor),
          ),
          leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(Icons.menu, color: AppColor.textColor)),
        ),
        body: BlocBuilder<CounterBloc, int>(
          bloc: _counterBloc,
          builder: (context, state) => Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                RichText(
                    text: TextSpan(
                        text:
                            '"It does not do to dwell on dreams and forget to live."',
                        style: AppStyle.h5.copyWith(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: AppColor.textColor),
                        children: [
                      TextSpan(
                          text: '$state',
                          style: AppStyle.h5.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black))
                    ])),
                Container(
                  height: size.height * 2 / 3,
                  margin: const EdgeInsets.only(top: 20.0),
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: words.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        String letter =
                            words[index].noun != null ? words[index].noun! : '';
                        String stLetter = letter.substring(0, 1);
                        String otherLetter = letter.substring(1);
                        //debugPrint(otherLetter);

                        String quoteDefault =
                            'Don’t cry because it’s over, smile because it happened.';
                        String quote = words[index].quote != null
                            ? words[index].quote!
                            : quoteDefault;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: AppColor.primaryColor),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildIconFavor(words[index]),
                                RichText(
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: (stLetter),
                                        style: AppStyle.h5.copyWith(
                                            fontSize: 89,
                                            fontWeight: FontWeight.bold,
                                            shadows: const [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 6)
                                            ]),
                                        children: [
                                          TextSpan(
                                              text: (otherLetter),
                                              style: AppStyle.h5.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 54,
                                                  shadows: const [
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        offset: Offset(3, 6),
                                                        blurRadius: 6)
                                                  ]))
                                        ])),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text('"$quote"',
                                      overflow: TextOverflow.clip,
                                      style: AppStyle.h5.copyWith(
                                          fontSize: 24, letterSpacing: 0.9)),
                                )
                              ]),
                        );
                      }),
                ),
                Container(
                  height: 30.0,
                  margin: const EdgeInsets.symmetric(vertical: 14.0),
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return buildIndicator(index == _currentIndex);
                      }),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              getEnglishToday();
            });
          },
          child: const Icon(Icons.restart_alt_outlined),
        ),
        drawer: Drawer(
            child: Container(
                color: AppColor.lightGreen,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('English Today',
                          style: AppStyle.h3.copyWith(
                              color: AppColor.textColor, fontSize: 32)),
                    ),
                    AppButton(
                        label: 'Favourites',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavorPage()));
                        }),
                    AppButton(
                        label: 'Setting',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CounterPage()));
                        })
                  ],
                ))));
  }

  Widget buildIndicator(bool isActive) {
    //debugPrint('$isActive');
    return Container(
      width: isActive ? 64.0 : 24.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: isActive ? Colors.lightGreen[300] : Colors.green[900],
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }

  // ignore: prefer_typing_uninitialized_variables
  //List<EnglishToday> a = [];
  // ignore: prefer_typing_uninitialized_variables
  List<EnglishToday> c = [];
  Widget _buildIconFavor(EnglishToday x) {
    final bool already = _b.contains(x);
    //debugPrint('$x');
    return Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: Icon(already ? Icons.favorite : Icons.favorite_border,
              color: already ? Colors.red[600] : null, size: 24),
          onPressed: () async {
            prefs = await SharedPreferences.getInstance();
            c = _b;

            setState(() {
              if (already) {
                _b.remove(x);
              } else {
                _b.add(x);
              }
            });
            //Iterable<String> wordMap = c.map((x) => jsonEncode(x));
            debugPrint('$c');
            //favorWords = wordMap.toList();
            //debugPrint('${c[0].toJson()}');
            favorWords = c.map((z) => jsonEncode(z.toJson())).toList();
            debugPrint('$favorWords');
            await prefs.setStringList(ShareKey.favor, favorWords);
          },
        ));
  }

  void addElement(x) {
    //c = a.add(x);
    debugPrint('$c');
  }
}
