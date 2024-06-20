import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String rollNo;

  @HiveField(2)
  String studentClass;

  Student(this.name, this.rollNo, this.studentClass);
}
