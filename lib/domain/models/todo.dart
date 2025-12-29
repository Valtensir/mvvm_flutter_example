class Todo {
  final String id;
  final String name;
  final String description;
  final bool done;

  const Todo({
    required this.id,
    required this.name,
    required this.description,
    required this.done,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      done: json['done'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'namme': name, 'description': description, 'done': done};
  }

  Todo copyWith({String? id, String? name, String? description, bool? done}) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }
}
