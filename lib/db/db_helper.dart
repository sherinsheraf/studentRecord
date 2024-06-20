import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/model/student_model.dart';

import '../model/student_model.dart'; // Ensure to import hive_flutter for Flutter integration
 // Adjust import based on your file structure

class DatabaseHelper {
  static const String _boxName = 'students';

  // // Add Student
  // Future<void> addStudent(String name, int rollNo, String studentClass, Uint8List? photo) async {
  //   final studentBox = Hive.box<StudentModel>(_boxName);
  //   await studentBox.add(name);
  // }

  // Get All Students
  Future<List<StudentModel>> getStudents() async {
    final studentBox = Hive.box<StudentModel>(_boxName);
    return studentBox.values.toList();
  }

  // Update Student (Optional)
  Future<void> updateStudent(StudentModel updatedStudent) async {
    final studentBox = Hive.box<StudentModel>(_boxName);
    await studentBox.put(updatedStudent.key, updatedStudent); // Assuming student has a key field (HiveObject)
  }

  // Delete Student (Optional)
  Future<void> deleteStudent(int studentKey) async {
    final studentBox = Hive.box<StudentModel>(_boxName);
    await studentBox.delete(studentKey);
  }
}
