
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;
  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    // join is from the path package
    print(path);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS students( 
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          roll_no INTEGER NOT NULL,
          studentclass TEXT NOT NULL
           photo BLOB 
        );
        // create more tables here
      ''');
      // The table 'students' will be created if it doesn't exist.
      print("Table Created");
    }, onUpgrade: (Database db, int oldVersion, int newVersion) {
      // Handle database schema changes here (if needed).
    });
  }

  Future<Map<String, dynamic>?> getStudent(int rollno) async {
    List<Map<String, dynamic>> maps = await db.query('students',
        where: 'roll_no = ?',
        whereArgs: [rollno]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}



















