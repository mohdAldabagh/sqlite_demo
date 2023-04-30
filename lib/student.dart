class Student {
  final int? id;
  final String name;
  final String mark;

  Student({this.id, required this.name, required this.mark});

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'],
        name: json['name'],
        mark: json['mark'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mark': mark,
      };
}
