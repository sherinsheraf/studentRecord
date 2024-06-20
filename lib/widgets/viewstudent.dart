import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/model/student_model.dart';
import 'package:student/widgets/editstudent.dart';

class ListStudents extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListStudentsState();
  }
}

class _ListStudentsState extends State<ListStudents> {
  List<StudentModel> slist = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    Box<StudentModel> box = await Hive.openBox<StudentModel>('student');
    setState(() {
      slist = List<StudentModel>.from(box.values);
    });
  }

  Widget buildListTile(int index, StudentModel stuone) {
    Widget? leadingWidget;
    if (stuone.photo != null && stuone.photo!.isNotEmpty) {
      leadingWidget = Image.memory(stuone.photo!); // Assuming stuone.photo is Uint8List?
    } else {
      leadingWidget = Icon(Icons.person); // Placeholder if no photo is available
    }

    return Card(
      color: Colors.lightGreen[50], // Adjust the shade of green here
      child: ListTile(
        leading: leadingWidget,
        title: Text(stuone.name),
        subtitle: Text("Roll No: ${stuone.rollNo}, Class: ${stuone.studentClass}"),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return EditStudent(index: index);
                })).then((_) => getdata()); // Refresh the list after editing
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () async {
                var box = await Hive.openBox<StudentModel>('student');
                await box.deleteAt(index);
                print("Data Deleted");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Deleted")));
                getdata();
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Students"),
        backgroundColor: Colors.green, // Set app bar color
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightGreen[100], // Set container color
          padding: EdgeInsets.all(10.0),
          child: slist.isEmpty
              ? Center(child: Text("No students to show.", style: TextStyle(color: Colors.black54)))
              : Column(
                  children: slist.asMap().entries.map((entry) {
                    int index = entry.key;
                    StudentModel stuone = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: buildListTile(index, stuone),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
