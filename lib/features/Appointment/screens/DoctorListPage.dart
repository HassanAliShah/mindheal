import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/appointment_controller.dart';
import 'AppointmentPage.dart';

class DoctorListPage extends StatelessWidget {
  final controller = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    controller.loadDoctors();
    return Scaffold(
      appBar: AppBar(title: Text('Available Doctors')),
      body: Obx(() {
        if (controller.isLoading.value) return Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: controller.doctors.length,
          itemBuilder: (context, index) {
            final doc = controller.doctors[index];
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(doc.profileImage)),
              title: Text(doc.name),
              subtitle: Text(doc.specialization),
              onTap: () => Get.to(() => AppointmentPage(doctor: doc)),
            );
          },
        );
      }),
    );
  }
}
