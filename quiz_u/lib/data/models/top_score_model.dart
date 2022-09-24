class TopScore{
  String? name;
  int? score;

  TopScore({this.name, this.score});

  TopScore.fromJson(Map<String,dynamic>json){
    name = json['name'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['score'] = score;
    return data;
  }
}