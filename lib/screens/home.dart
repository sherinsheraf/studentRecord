import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/screens/login.dart';
import 'package:student/widgets/addstudent.dart';
import 'package:student/widgets/viewstudent.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
      Text(
    '"Teaching is a work of heart"',
    style: TextStyle(
      color: Color.fromARGB(255, 204, 199, 199), // Text color
      fontSize: 20, // Text size
      fontWeight: FontWeight.bold, 
      // Text weight
    ),
  ),
     centerTitle: true,
    
       
      backgroundColor: Colors.green,
      actions: [
        IconButton(
            onPressed: () {
              signout(context);
            },
            icon: const Icon(Icons.exit_to_app)),
      ]),
     
     
      body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
       const Text (
          'Hi Sherin, Good Day!',
           style: TextStyle(
    color: Color.fromARGB(255, 53, 9, 2),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ClipOval(
  child: Image.asset(
    'assets/image/she.jpg', // Use your image path
    width: 200, // Set the width of the circular image
    height: 200, // Set the height of the circular image
    fit: BoxFit.cover, // Adjust the fit property to determine how the image is scaled and positioned within the circular shape
  ),
),
 SizedBox(
          height: 50,
        ),
        


         InkWell(
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent()));
  },
  child: Container(
    width: 500, // Expand to the full available width
    height: 50,
    decoration: BoxDecoration(
      color: Color(0xFF5CC060), // Use Color(int) to define the color
      borderRadius: BorderRadius.circular(10), // Add rounded corners
    ),
    child: Center(
      child: Text(
        'Add Student',
        style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 18, // Text size
          fontWeight: FontWeight.bold, // Text weight
        ),
      ),
    ),
  ),
),


            SizedBox(
          height: 20,
        ),
                InkWell(
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ListStudents()));
  },
  child: Container(
    width: 500, // Expand to the full available width
    height: 50,
    decoration: BoxDecoration(
      color: Color(0xFF5CC060), // Use Color(int) to define the color
      borderRadius: BorderRadius.circular(10), // Add rounded corners
    ),
    child: Center(
      child: Text(
        'View Student',
        style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 18, // Text size
          fontWeight: FontWeight.bold, // Text weight
        ),
      ),
    ),
  ),
),
      ],
    ),
  ),
        
  );}

  
  signout(BuildContext ctx) async {
    showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          title: const Text("Confirm Sign Out"),
          content: const Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx1) => ScreenLogin()),
                    (route) => false);
              },
              child: const Text("Sign Out"),
            ),
          ],
        );
      },
    );
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
  }
}
