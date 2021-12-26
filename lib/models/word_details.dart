class WordDetails {
  late List<Definitions> _definitions;
  late String _word;
  late String _pronunciation;

  WordDetails(
      {required List<Definitions> definitions, required String word, required String pronunciation}) {
    this._definitions = definitions;
    this._word = word;
    this._pronunciation = pronunciation;
  }

  List<Definitions> get definitions => _definitions;
  set definitions(List<Definitions> definitions) => _definitions = definitions;
  String get word => _word;
  set word(String word) => _word = word;
  String get pronunciation => _pronunciation;
  set pronunciation(String pronunciation) => _pronunciation = pronunciation;

  WordDetails.fromJson(Map<String, dynamic> json) {
    if (json['definitions'] != null) {
      _definitions = <Definitions>[];
      json['definitions'].forEach((v) {
        _definitions.add(new Definitions.fromJson(v));
      });
    }
    _word = json['word'];
    _pronunciation = json['pronunciation'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._definitions != null) {
      data['definitions'] = this._definitions.map((v) => v.toJson()).toList();
    }
    data['word'] = this._word;
    data['pronunciation'] = this._pronunciation;
    return data;
  }
}

class Definitions {
  late String _type;
  late String _definition;
  late String _example;
  late String _imageUrl;
  late String _emoji;

  Definitions(
      {required String type,
        required String definition,
        required String example,
        required String imageUrl,
        required String emoji}) {
    this._type = type;
    this._definition = definition;
    this._example = example;
    this._imageUrl = imageUrl;
    this._emoji = emoji;
  }

  String get type => _type;
  set type(String type) => _type = type;
  String get definition => _definition;
  set definition(String definition) => _definition = definition;
  String get example => _example;
  set example(String example) => _example = example;
  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) => _imageUrl = imageUrl;
  String get emoji => _emoji;
  set emoji(String emoji) => _emoji = emoji;

  Definitions.fromJson(Map<String, dynamic> json) {
    _type = json['type'].toString();
    _definition = json['definition'].toString();
    _example = json['example'].toString();
    _imageUrl = json['image_url'].toString();
    _emoji = json['emoji'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['definition'] = this._definition;
    data['example'] = this._example;
    data['image_url'] = this._imageUrl;
    data['emoji'] = this._emoji;
    return data;
  }
}