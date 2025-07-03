import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String userId;
  final String doctorId;
  final DateTime slot;
  final String status;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.slot,
    required this.status,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> data, String id) {
    return AppointmentModel(
      id: id,
      userId: data['userId'],
      doctorId: data['doctorId'],
      slot: (data['slot'] as Timestamp).toDate(),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'doctorId': doctorId,
      'slot': slot,
      'status': status,
    };
  }
}
