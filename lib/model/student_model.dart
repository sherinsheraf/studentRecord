import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'student_model.g.dart'; // Generated file


@HiveType(typeId: 0) // HiveType annotation with typeId
class StudentModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int rollNo;

  @HiveField(2)
  late String studentClass;
 @HiveField(3)
 late int? id;

  @HiveField(4)
  late Uint8List? photo;

  StudentModel({required this.name, required this.rollNo, required this.studentClass, this.id,this.photo});

  // StudentModel.fromMap(Map<String, dynamic> map) {
    
    
  //   id = map['id'] as int;
  //   name = map['name'] as String; 
  //   rollNo = map['rollNo'] as int;  
  //   studentClass = map['studentClass'] as String; 
   
    
  // }

  //   Map<String, dynamic> toJson() => {
  //       "name": name,
  //       "id": id,
  //       "rollNo": rollNo,
  //       "studentClass": studentClass,
  //   };

}
