import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/model/student_model.dart';
import 'package:student/widgets/editstudent.dart';


class ListStudents extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListStudents();
  }
}

class _ListStudents extends State<ListStudents> {
  List<Student> slist = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    var box = await Hive.openBox<Student>('studentBox');
    setState(() {
      slist = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Students"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.isEmpty
              ? Text("No any students to show.")
              : Column(
                  children: slist.asMap().entries.map((entry) {
                    int index = entry.key;
                    Student stuone = entry.value;
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.people),
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
                                var box = await Hive.openBox<Student>('studentBox');
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
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
