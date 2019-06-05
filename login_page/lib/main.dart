import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();  
  }
  
  class _MyHomePageState extends State<MyHomePage>{
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    TextEditingController usernameController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      controller: usernameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () => _checkLogin(),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold,
          )
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 55.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0,),
                emailField,
                SizedBox(height: 25.0,),
                passwordField,
                SizedBox(height: 35.0,),
                loginButton,
                SizedBox(height: 15.0,),
              ],
            ),
          ),
        ),
      ),
    );

  }

  void _checkLogin() {
    if(usernameController.text == 'user' && passwordController.text == 'pass')
    {
      Fluttertoast.showToast(msg: "Login Successful!");
    }
    else if(usernameController.text == 'user' && passwordController.text != 'pass')
    {
      Fluttertoast.showToast(msg: "Incorrect Password!");
    }
    else 
    {
      Fluttertoast.showToast(msg: "User does not exist!");
    }
  }
}