

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/screens/home.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  FocusNode _focusNode = FocusNode();
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();
  String key ="SAVE_KEY_NAME";

  final  TextStyle regularTextStyle = TextStyle(
  fontFamily: 'YourRegularFont', // Replace with the actual font family for regular text
  fontSize: 16, // Set the desired font size
);

final TextStyle textFieldTextStyle = TextStyle(
  fontFamily: 'YourTextFieldFont', // Replace with the actual font family for text fields
  fontSize: 16, // Set the desired font size
);

  String predefinedUsername = "admin";

  String predefinedPassword = "password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SafeArea(
       
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          
          child: Center(
            child: Column(
               children: 
              
              [
                
                Image.asset('assets/image/studentgrad.jpg',width: 50,height:50),
                       Text("Student Book",
                       style: TextStyle(fontSize:40, fontWeight:FontWeight.bold),),
           
                       Text("Enter your credential to login",  style: regularTextStyle),
                        const SizedBox(
                  height: 50,
                ),
                
                TextFormField(
                  
                    controller: _usernameController,
                    style: textFieldTextStyle,
                     
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                   Icons.person,
                    color: _focusNode.hasFocus ? Colors.black : Color.fromARGB(255, 26, 22, 22), // Set the color based on focus state
    ),
                        hintText: 'Username',
                        border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(18),
                       borderSide:BorderSide.none),
                       fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                       filled: true,
                      
                    )),
                const SizedBox(
                  height: 20,
                ),
               
                TextFormField(
                  
                  controller: _passwordController,
                  obscureText: true,

                  
                  style: textFieldTextStyle,
                  decoration:  InputDecoration(
                  

                   prefixIcon: Icon(Icons.password_outlined,color: _focusNode.hasFocus ? Colors.black : Color.fromARGB(255, 26, 22, 22),),
                    hintText: 'Password',
                     border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(18),
                       borderSide:BorderSide.none),
                       fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                       filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 1, 30, 2)),),
                  
                  onPressed: () {
                    checkLogin(context);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Login'),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
  final _username = _usernameController.text;
  final _password = _passwordController.text;
  final _errorMessage = 'Invalid Username or Password';
 
  String error = "";

  if (_username.isEmpty) {
    error = 'Please enter a username';
  } else if (_password.isEmpty) {
    error = 'Please enter a password';
  } else if (_username == predefinedUsername && _password == predefinedPassword) {
    final _sharedPrefs = await SharedPreferences.getInstance();
   
    
    await _sharedPrefs.setBool(key, true);
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenHome()));
  } else {
    error = _errorMessage;
  }

  if (error.isNotEmpty) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 15, 14, 14),
      margin: const EdgeInsets.all(10),
      content: Text(error),
    ));

    // Set the error message text to be displayed next to the text fields.
    setState(() {
      error = error;
    });
  }
}
}
