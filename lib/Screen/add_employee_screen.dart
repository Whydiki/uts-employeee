import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddEmployeeScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addEmployee(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void addEmployee(BuildContext context) {
    DatabaseReference employeeRef =
    FirebaseDatabase.instance.reference().child('employees');
    String name = nameController.text.trim();
    String position = positionController.text.trim();

    if (name.isNotEmpty && position.isNotEmpty) {
      employeeRef.push().set({
        'name': name,
        'position': position,
      }).then((_) {
        Navigator.pop(context); // Kembali ke halaman sebelumnya setelah berhasil menambahkan karyawan
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter name and position.'),
        ),
      );
    }
  }
}