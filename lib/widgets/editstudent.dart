import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/model/student_model.dart';
 // Import your model to register the adapter

class EditStudent extends StatefulWidget {
  final int index;

  EditStudent({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditStudent();
  }
}

class _EditStudent extends State<EditStudent> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController studentclass = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
    var box = await Hive.openBox<Student>('studentBox');
    var student = box.getAt(widget.index);
    if (student != null) {
      name.text = student.name;
      rollno.text = student.rollNo;
      studentclass.text = student.studentClass;
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
            ElevatedButton(
              onPressed: _updateStudentData,
              child: Text("Update Student Data"),
            ),
          ],
        ),
      ),
    );
  }

  void _updateStudentData() async {
    var box = await Hive.openBox<Student>('studentBox');
    var student = Student(name.text, rollno.text, studentclass.text);
    await box.putAt(widget.index, student);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Updated")));
  }
}
