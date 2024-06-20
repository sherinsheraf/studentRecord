
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';

class AddStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddStudent();
  }
}

class _AddStudent extends State<AddStudent> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController studentclass = TextEditingController();

  Uint8List? _pickedImage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _pickedImage = result.files.single.bytes;
      });
    }
  }

  Future<void> _saveStudentData() async {
    final studentBox = await Hive.openBox('students');

    await studentBox.add({
      'name': name.text,
      'rollno': rollno.text,
      'studentclass': studentclass.text,
      'image': _pickedImage
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Student Added")));

    name.clear();
    rollno.clear();
    studentclass.clear();
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/image/she.jpg'),
              radius: 20,
            ),
          ),
        ],
        title: Text("Add Student"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Student Name",
              ),
            ),
            TextField(
              controller: rollno,
              decoration: InputDecoration(
                hintText: "Roll No.",
              ),
            ),
            TextField(
              controller: studentclass,
              decoration: InputDecoration(
                hintText: "Class:",
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: _pickImage,
              child: _pickedImage == null
                  ? Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: Icon(Icons.camera_alt, size: 50, color: Colors.grey[600]),
                    )
                  : Image.memory(_pickedImage!, width: 100, height: 100),
            ),
            ElevatedButton(
              onPressed: _saveStudentData,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Save Student Data"),
            ),
          ],
        ),
      ),
    );
  }
}
