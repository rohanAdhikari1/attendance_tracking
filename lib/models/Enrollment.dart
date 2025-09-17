class Company {
  final String uid;
  final String name;
  final String phone;
  final String address1;
  final String address2;
  final String remark;

  Company({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        title: json['title'] ?? 'Untitled',
        description: json['description'] ?? '',
        dueDate: json['due_date'] ?? '',
        priority: json['priority'] ?? 0
    );
  }
}
