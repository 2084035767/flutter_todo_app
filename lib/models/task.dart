class Task {
  String title;
  bool isDone;
  String category;

  Task({required this.title, required this.isDone, required this.category});

  Task.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      isDone = json['isDone'],
      category = json['category'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'isDone': isDone,
    'category': category,
  };

  Task copyWith({String? title, bool? isDone, String? category}) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      category: category ?? this.category,
    );
  }
}
