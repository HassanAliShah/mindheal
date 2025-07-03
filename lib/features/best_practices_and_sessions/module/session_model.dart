class SessionModel {
  final String id;
  final String title;
  final String type; // e.g., meditation, reflection, journaling
  final String problemId;
  final String mediaUrl; // optional audio/video content

  SessionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.problemId,
    required this.mediaUrl,
  });

  factory SessionModel.fromMap(Map<String, dynamic> data, String id) {
    return SessionModel(
      id: id,
      title: data['title'],
      type: data['type'],
      problemId: data['problemId'],
      mediaUrl: data['mediaUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'problemId': problemId,
      'mediaUrl': mediaUrl,
    };
  }
}
