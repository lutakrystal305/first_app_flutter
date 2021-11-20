class EnglishToday {
  String? id;
  String? noun;
  String? quote;
  EnglishToday({this.id, this.noun, this.quote});

  EnglishToday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noun = json['noun'];
    quote = json['quote'];
    //isFavor = json['isFavor'];
  }

  Object? toJson() => {'id': id, 'noun': noun, 'quote': quote.toString()};
}
