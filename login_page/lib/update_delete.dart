import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateDelete extends StatefulWidget {
  UpdateDelete({Key key, this.email, this.icon}) : super(key: key);

  final String email;
  final IconData icon;

  @override
  _UpdateDeleteState createState() => _UpdateDeleteState();
}

class _UpdateDeleteState extends State<UpdateDelete> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final idController = TextEditingController();
  final fnController = TextEditingController();
  final lnController = TextEditingController();
  final emController = TextEditingController();
  final passController = TextEditingController();
  final domController = TextEditingController();
  final collController = TextEditingController();
  final deptController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getDetails(widget.email).then((x) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      enabled: false,
      controller: emController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );
    final employeeid = TextField(
      controller: idController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "EID",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );

    final passwordField = TextField(
      controller: passController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );
    final firstname = TextField(
      controller: fnController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Firstname",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );
    final lastname = TextField(
      controller: lnController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Lastname",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );
    final domain = TextField(
      controller: domController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Domain",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );
    final college = TextField(
      controller: collController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "College",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );
    final department = TextField(
      controller: deptController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Department",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(23.0))),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Employee'),
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
                  height: 8.0,
                ),
                employeeid,
                SizedBox(
                  height: 8.0,
                ),
                firstname,
                SizedBox(
                  height: 8.0,
                ),
                lastname,
                SizedBox(
                  height: 8.0,
                ),
                emailField,
                SizedBox(height: 8.0),
                passwordField,
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                department,
                SizedBox(
                  height: 8.0,
                ),
                college,
                SizedBox(
                  height: 8.0,
                ),
                domain,
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  FlatButton(
                    color: Colors.green,
                  onPressed: () {updateEmp();},
                  child: Text(
                    "Update",
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                FlatButton(
                  color:Colors.red,

                  onPressed: () {deleteEmp();},
                  child: Text(
                    "Delete",
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateEmp() async {
    var body = '{"college": "' +
        collController.text +
        '","dept": "' +
        deptController.text +
        '","domain": "' +
        domController.text +
        '","eid":' +
        idController.text +
        ',"email": "' +
        emController.text +
        '","firstname": "' +
        fnController.text +
        '","lastname": "' +
        lnController.text +
        '","password": "' +
        passController.text +
        '"}';
    print(body);
    await insert(body);
    Fluttertoast.showToast(msg:'Employee Updated!');
    Navigator.pop(context);
  }

  Future<void> insert(String body) async {
    String url = 'https://mobapp.eaiesb.com/mobapp/updateemployee/'+emController.text;
    http.Response resp = await http.put(
        Uri.encodeFull(url),
        body: body,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
  }

  Future<void> getDetails(String email) async {
    String url = 'https://mobapp.eaiesb.com/mobapp/viewemployeebyid/' + email;
    http.Response resp = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});

    var data = json.decode(resp.body);

    idController.text = data['eid'].toString();
    emController.text = email;
    fnController.text = data['firstname'];
    lnController.text = data['lastname'];
    passController.text = data['password'];
    collController.text = data['college'];
    deptController.text = data['dept'];
    domController.text = data['domain'];

    print(data['eid']);
  }

  Future<void> deleteEmp() async {
    String url = 'https://mobapp.eaiesb.com/mobapp/deleteemployee/' + emController.text;
    http.Response resp = await http.delete(
      Uri.encodeFull(url),
      headers: {
        'Accept': 'application/json'
      }
    );

    Fluttertoast.showToast(msg: "Employee Deleted!");
    Navigator.pop(context);
  }
}
