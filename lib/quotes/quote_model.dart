class Quote {
  String? id;
  String? content;
  String? author;
  String? authorId;
  List? tags;
  int? length;

  Quote(
      {this.id,
      this.content,
      this.author,
      this.authorId,
      this.tags,
      this.length});

  //Converts a individual json component map to Quote model with respective fields
  Quote.fromJson(Map json)
      : content = json['content'],
        id = json['_id'],
        author = json['author'],
        authorId = json['authorId'],
        tags = json['tags'],
        length = json['length'];

  String? getId() {
    return id;
  }

  String? getContent() {
    return content;
  }

  String? getAuthor() {
    return author;
  }

  String? getAuthorId() {
    return authorId;
  }

  List? getTags() {
    return tags;
  }

  int? getLength() {
    return length;
  }
}
