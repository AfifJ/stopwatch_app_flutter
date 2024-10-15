class ProgrammingLanguage {
  final String name;
  final String imageUrl;
  final String link;

  ProgrammingLanguage(
      {required this.name, required this.imageUrl, required this.link});

  factory ProgrammingLanguage.fromMap(Map<String, dynamic> data) {
    return ProgrammingLanguage(
      name: data['name'],
      imageUrl: data['imageUrl'],
      link: data['link'],
    );
  }
}
