class Book {
  final String title;
  final String coverUrl;

  Book({required this.title, required this.coverUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      coverUrl: json['cover_url'],
    );
  }
}
