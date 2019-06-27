import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Employee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddEmp(title: 'add employee'),
    );
  }
}

class AddEmp extends StatefulWidget {
  AddEmp({Key key, this.title}) : super(key: key);

  final String title;

  var pad = EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0);
  @override
  _AddEmpState createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  String dropdownValue = 'Select';
  String dropDownValue = "";
  String dropDownVAlue = "";
  List _doms = ['Mobile                                 ', 'Web'];
  List _colls = ['BML                                    ', 'MIT'];
  List _deps = ['CSE                                    ', 'IT'];

  final idController = TextEditingController();
  final fnController = TextEditingController();
  final lnController = TextEditingController();
  final emController = TextEditingController();
  final passController = TextEditingController();

  List<DropdownMenuItem<String>> _dropDoms;
  List<DropdownMenuItem<String>> _dropColls;
  List<DropdownMenuItem<String>> _dropDeps;

  String _currentDom;
  String _currentColl;
  String _currentDep;

  @override
  void initState() {
    super.initState();
    _dropDoms = getDoms();
    _dropColls = getColls();
    _dropDeps = getDeps();

    _currentDom = null;
    _currentColl = null;
    _currentDep = null;
  }

  List<DropdownMenuItem<String>> getDoms() {
    List<DropdownMenuItem<String>> items = new List();
    for (String dom in _doms) {
      items.add(new DropdownMenuItem(
        value: dom,
        child: Text(dom),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getColls() {
    List<DropdownMenuItem<String>> items = new List();
    for (String coll in _colls) {
      items.add(new DropdownMenuItem(
        value: coll,
        child: Text(coll),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDeps() {
    List<DropdownMenuItem<String>> items = new List();
    for (String dep in _deps) {
      items.add(new DropdownMenuItem(
        value: dep,
        child: Text(dep),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
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
    final submit = Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.blueGrey,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        onPressed: () {
          addEmp();
        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
            )),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ADD Employee'),
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
                new DropdownButton(
                  hint: Text('Domain'),
                  value: _currentDom,
                  items: _dropDoms,
                  onChanged: changedDom,
                ),
                SizedBox(
                  height: 8.0,
                ),
                new DropdownButton(
                  hint: Text('College'),
                  value: _currentColl,
                  items: _dropColls,
                  onChanged: changedColl,
                ),
                SizedBox(
                  height: 8.0,
                ),
                new DropdownButton(
                  hint: Text('Department'),
                  value: _currentDep,
                  items: _dropDeps,
                  onChanged: changedDep,
                ),
                SizedBox(
                  height: 8.0,
                ),
                submit,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changedDom(String x) {
    setState(() {
      _currentDom = x;
    });
  }

  void changedColl(String x) {
    setState(() {
      _currentColl = x;
    });
  }

  void changedDep(String x) {
    setState(() {
      _currentDep = x;
    });
  }

  void addEmp() async {
    var body = '{"college": "' +
        _currentColl.trim() +
        '","dept": "' +
        _currentDep.trim() +
        '","domain": "' +
        _currentDom.trim() +
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
    Fluttertoast.showToast(msg: "Employee Added!");
    Navigator.pop(context);
  }

  Future<void> insert(String body) async {
    http.Response resp = await http.post(
        Uri.encodeFull('https://mobapp.eaiesb.com/mobapp/addemployee'),
        body: body,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
  }
}