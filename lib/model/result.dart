class Result {
  final int number;
  final String title;
  final String name;
  final int score;

  Result({
    required this.number,
    required this.title,
    required this.name,
    required this.score
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      number: json['number'],
      title: json['title'],
      name: json['name'],
      score: json['score'],
    );
  }
}