class Candidate {
  final int number;
  final String title;
  final String name;

  Candidate({
    required this.number,
    required this.title,
    required this.name,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      number: json['number'],
      title: json['title'],
      name: json['name'],
    );
  }
}