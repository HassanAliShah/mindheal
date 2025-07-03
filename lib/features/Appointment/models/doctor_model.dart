import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String profileImage;
  final List<DateTime> availableSlots;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.profileImage,
    required this.availableSlots,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> data, String id) {
    return DoctorModel(
      id: id,
      name: data['name'],
      specialization: data['specialization'],
      profileImage: data['profileImage'],
      availableSlots: (data['availableSlots'] as List)
          .map((slot) => (slot as Timestamp).toDate())
          .toList(),
    );
  }
}
