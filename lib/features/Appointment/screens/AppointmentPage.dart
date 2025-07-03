import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mindheal/utils/popups/loaders.dart';
import '../controller/appointment_controller.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';

class AppointmentPage extends StatelessWidget {
  final DoctorModel doctor;
  final controller = Get.find<AppointmentController>();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  AppointmentPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment' , style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          _buildDoctorHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: doctor.availableSlots.length,
              itemBuilder: (context, index) {
                final slot = doctor.availableSlots[index];
                final isPast = slot.isBefore(now);
                final formattedTime = DateFormat('EEEE, MMM d • hh:mm a').format(slot);

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(Icons.access_time, color: Colors.deepPurple),
                    title: Text(formattedTime, style: TextStyle(fontWeight: FontWeight.w500)),
                    trailing: ElevatedButton(
                      onPressed: isPast
                          ? null
                          : () async {
                        final appointment = AppointmentModel(
                          id: '',
                          userId: userId,
                          doctorId: doctor.id,
                          slot: slot,
                          status: 'scheduled',
                        );
                        await controller.bookAppointment(appointment);
                        TLoaders.successSnackBar(title: 'Success' ,message: "Appointment booked");
                        //Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isPast ? Colors.grey : Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text("Book"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(doctor.profileImage),
            radius: 30,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doctor.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(doctor.specialization, style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),
        ],
      ),
    );
  }
}
