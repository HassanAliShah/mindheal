class ProblemCategoryModel {
  final String id;
  final String title;
  final String description;
  final String iconUrl;

  ProblemCategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
  });

  factory ProblemCategoryModel.fromMap(Map<String, dynamic> data, String id) {
    return ProblemCategoryModel(
      id: id,
      title: data['title'],
      description: data['description'],
      iconUrl: data['iconUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'iconUrl': iconUrl,
    };
  }
}
