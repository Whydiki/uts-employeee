import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'add_employee_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: EmployeeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseReference employeeRef =
    FirebaseDatabase.instance.reference().child('employees');

    return StreamBuilder(
      stream: employeeRef.onValue,
      builder: (context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          List<Map<dynamic, dynamic>> employees = [];
          snapshot.data!.snapshot.value.forEach((key, value) {
            employees.add(value);
          });
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(employees[index]['name']),
                subtitle: Text(employees[index]['position']),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}