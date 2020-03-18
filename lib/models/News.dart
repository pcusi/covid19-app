class News {

  final String title;
  final String description;
  final String dni;
  final String link;
  final String createdAt;

  News({this.title, this.description, this.dni, this.link, this.createdAt});


  factory News.fromJson(Map<String, dynamic> json) {

    return News(
      title: json['title'],
      description: json['description'],
      link: json['link'],
      createdAt: json['created_at']
    );

  }


}