import 'dart:math';
import 'quotes.dart';
import 'quote_model.dart';

class Quotes {
  static Quotes _instance = Quotes._internal();
  static List<Quote> datas = [];
  Quotes._internal();

  factory Quotes() => _instance;
  getAll() {
    datas = allquotes.map((e) => Quote.fromJson(e)).toList();
  }

  static List<Quote> convert(List<dynamic> quotes) {
    return quotes.map((e) => Quote.fromJson(e)).toList();
  }

  Quote? getByWord(String word) {
    List<Quote> quotes = datas.where((element) {
      String content = element.getContent() ?? " ";
      return content.contains(word);
    }).toList();
    Random ran = Random();
    return quotes.isEmpty ? null : quotes[ran.nextInt(quotes.length)];
  }

  int _getRandomIndex() {
    return Random.secure().nextInt(allquotes.length);
  }

  // //Returns first quote

  // static Quote getFirst() {
  //   return new Quote.fromJson(allquotes[0]);
  // }

  // //Returns last quote

  // static Quote getLast() {
  //   return new Quote.fromJson(allquotes[allquotes.length - 1]);
  // }

  // //Returns random quote

  Quote getRandom() {
    return datas[_getRandomIndex()];
  }
}
