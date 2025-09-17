class AnswerModel {
  final int questionId;
  int? selectedOptionId;
  String? imagePath;

  AnswerModel({required this.questionId, this.selectedOptionId, this.imagePath});
}