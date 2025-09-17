class Task {
  final int id;
  final String title;
  final String description;
  int? reportId;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
    this.reportId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['name'] ?? 'Untitled',
      description: json['description'] ?? '',
      isComplete: json['is_complete'],
      reportId: json['report_id'],
    );
  }
}
