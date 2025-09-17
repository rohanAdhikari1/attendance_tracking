class Enrollment {
  final String uid;
  final String name;
  final String? phone;
  final String? address1;
  final String? address2;
  final String? remark;
  final String? startTime;
  final String? endTime;

  Enrollment({
    required this.uid,
    required this.name,
    this.phone,
    this.address1,
    this.address2,
    this.remark,
    this.startTime,
    this.endTime,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
        uid: json['site']['uid'],
        name: json['site']['name'] ?? 'N/A',
        phone: json['site']?['phone'],
        address1: json['site']?['address1'],
      address2: json['site']?['address2'],
      remark: json['remarks'],
        startTime: json['from_time'],
      endTime: json['to_time'],
    );
  }
}
