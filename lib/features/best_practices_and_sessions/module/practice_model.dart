class PracticeModel {
  final String id;
  final String title;
  final String description;
  final String problemId;
  final List<String> steps;

  PracticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.problemId,
    required this.steps,
  });

  factory PracticeModel.fromMap(Map<String, dynamic> data, String id) {
    return PracticeModel(
      id: id,
      title: data['title'],
      description: data['description'],
      problemId: data['problemId'],
      steps: List<String>.from(data['steps']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'problemId': problemId,
      'steps': steps,
    };
  }
}
