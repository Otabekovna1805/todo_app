class Todo {
  int id;
  String title;
  String description;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, Object?> json) => Todo(
      id: json["id"] as int,
      title: json["title"] as String,
      description: json["description"] as String,
      isCompleted: json["isCompleted"] == 1 ? true : false,
  );

  Map<String, Object?> toJson() => {
    "id" : id,
    "title" : title,
    "description" : description,
    "isCompleted" : isCompleted ? 1 : 0,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode => Object.hash(id, title, isCompleted);

  @override
  String toString() {
    return 'Todo{title: $title, description: $description}';
  }
}
