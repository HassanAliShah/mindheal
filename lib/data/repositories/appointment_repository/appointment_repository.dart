import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/Appointment/models/appointment_model.dart';
import '../../../features/Appointment/models/doctor_model.dart';


class AppointmentRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<DoctorModel>> getDoctors() async {
    final snapshot = await _db.collection('doctors').get();
    return snapshot.docs.map((doc) => DoctorModel.fromMap(doc.data(), doc.id)).toList();
  }

  Future<void> bookAppointment(AppointmentModel appointment) async {
    await _db.collection('appointments').add(appointment.toMap());
  }

  Future<List<AppointmentModel>> getUserAppointments(String userId) async {
      final snapshot = await _db
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) => AppointmentModel.fromMap(doc.data(), doc.id)).toList();
  }
}
