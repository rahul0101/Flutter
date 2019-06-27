import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'list_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
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
    bool hidePass;

    TextEditingController usernameController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    @override
    void initState() {
    super.initState();
    hidePass = true;
  }

  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      controller: usernameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        //labelStyle: TextStyle(color: Colors.black,fontSize: 16,),
        labelText: "Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
      ),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      obscureText: hidePass,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        labelText: "Password",
        //hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
        suffixIcon: IconButton(
          icon: Icon(
            hidePass ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {setState(() {
           hidePass = !hidePass; 
          });
          }
        )
      ),
    );

    final loginButton = Material(
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text("Employee Login")),
      ),
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
                  height: 155.0,
                  child: Image.asset(
                    "assets/eaiesb_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 5.0,),
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

  void _checkLogin() async{

    var body = '{"email": "'+usernameController.text+'","password": "'+passwordController.text+'"}';
    //print(body);

    var val;
   try{
      val = await checkUser(body);
   }
   on SocketException catch(_) {
     Fluttertoast.showToast(msg: "Server Down, Please Try Later");
     val = 999;
   }

    //print(val);

    if(val == 1)
    {
      Fluttertoast.showToast(msg: "Login Successful!");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListRoute()),
      );
    }
    else if(val == -1)
    {
      Fluttertoast.showToast(msg: "Incorrect Password!");
    }
    else if(val == 0)
    {
      Fluttertoast.showToast(msg: "User does not exist!");
    }
    else if(usernameController.text == '' || passwordController.text == '')
    {
      Fluttertoast.showToast(msg: "Please enter details!");
    }
  }

  Future<int> checkUser(String body) async {
    http.Response resp = await http.post(
      Uri.encodeFull('https://mobapp.eaiesb.com/mobapp/login'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    );

    var data = json.decode(resp.body);

    return data;
  }
}

