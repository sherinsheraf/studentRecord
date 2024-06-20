import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'package:student/model/student_model.dart';

class EditStudent extends StatefulWidget {
  final int index;

  EditStudent({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditStudentState();
  }
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController studentclass = TextEditingController();
  Uint8List? _photoData; // Store the photo data

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
    var box = await Hive.openBox<StudentModel>('student');
    var student = box.getAt(widget.index);
    if (student != null) {
      name.text = student.name;
      rollno.text = student.rollNo.toString();
      studentclass.text = student.studentClass;
      _photoData = student.photo; // Load photo data
      setState(() {});
    } else {
      print("No data found for index: ${widget.index}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Student"),
        backgroundColor: Colors.green, // Set app bar color
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.lightGreen[100], // Set container color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage, // Function to pick image
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green[200], // Adjust the shade of green here
                  border: Border.all(color: Colors.green[700]!), // Adjust the shade of green here
                ),
                child: _photoData != null
                    ? Image.memory(_photoData!, fit: BoxFit.cover)
                    : Icon(Icons.person, size: 50, color: Colors.green[700]), // Adjust the shade of green here
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Student Name",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: rollno,
              decoration: InputDecoration(
                hintText: "Roll No.",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: studentclass,
              decoration: InputDecoration(
                hintText: "Class:",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateStudentData,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color
              ),
              child: Text("Update Student Data"),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List? bytes = await pickedFile.readAsBytes();
      setState(() {
        _photoData = bytes;
      });
    }
  }

  void _updateStudentData() async {
    var box = await Hive.openBox<StudentModel>('student');
    var student = StudentModel(
      name: name.text,
      rollNo: int.parse(rollno.text),
      studentClass: studentclass.text,
      photo: _photoData, // Assign photo data to student model
    );
    await box.putAt(widget.index, student);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Updated")));
  }
}
