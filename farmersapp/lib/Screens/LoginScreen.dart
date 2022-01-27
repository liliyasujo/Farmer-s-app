import 'package:flutter/material.dart';
import 'package:farmersapp/Methods.dart';
import 'package:farmersapp/Screens/CreateAccountScreen.dart';
import 'package:farmersapp/Screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        // ignore: prefer_const_constructors
        title: Text(
          "Farmer's App",
          style: TextStyle(
            color: Colors.green[700],
            fontSize: 35,
          ),
        ),
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            // Container(
            //   alignment: Alignment.centerLeft,
            //   width: size.width / 0.5,
            //   child: IconButton(
            //       icon: Icon(Icons.arrow_back_ios), 
            //       color: Colors.grey[700],
            //       onPressed: () {}),
            // ),
            SizedBox(
              height: size.height / 50,
            ),
            Container(
              width: size.width / 1.1,
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                  letterSpacing: 2,
                ),
              ),
            ),
            Container(
              width: size.width / 1.1,
              child: Text(
                "Login In to Continue!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    style: TextStyle(color: Colors.grey[300]),
                    controller: _email,
                    cursorColor: Colors.green[700],
                    decoration: InputDecoration(
                      hintText: "email",
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green.shade700,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green.shade700,
                        ),
                      ),
                      prefixIcon: Icon(
                          Icons.email,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 15,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.grey[300]),
                    cursorColor: Colors.green[700],
                    controller: _password,
                    obscureText: isHiddenPassword,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green.shade700,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green.shade700,
                        ),
                      ),
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      prefixIcon: Icon(
                          Icons.lock,
                        color: Colors.grey[700],
                      ),
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          Icons.visibility,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            customButton(size),
            SizedBox(
              height: size.height / 40,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CreateAccount())),
              child: Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Successful");
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.green[700],
          ),
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
  void _togglePasswordView(){

    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}