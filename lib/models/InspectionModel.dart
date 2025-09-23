class InspectionModel {
  final int id;
  final String title;
  final String siteName;
  final String frequency;
  final String date;

  InspectionModel({
    required this.id,
    required this.title,
    required this.siteName,
    required this.frequency,
    required this.date,
  });

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      id: json['id'],
      title: json['name'] ?? 'Untitled',
      siteName: json['name'] ?? 'Untitled',
      frequency: json['frequency'],
      date: json['created_at'],
    );
  }
}
