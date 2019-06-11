import 'package:flutter/material.dart';
import 'package:login_page/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'add_emp.dart';

class ListRoute extends StatefulWidget{
  final String name;

  ListRoute({Key key, @required this.name}) : super(key: key);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListRoute> {

  List<String> names  = new List<String>();
  List<String> domains  = new List<String>();
  List<String> colleges  = new List<String>();
  List<String> emails = new List<String>();
  //_ListState(){}

  @override
  void initState(){
    super.initState();
    loadEmps().then((c){
      setState(() {
        
      });
    }
    );
    //setState(() {
      
    //});
  }

  Widget _buildCategoryWidgets(List<Widget> employees) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => employees[index],
      itemCount: employees.length,
    );
  }
  

  @override
  Widget build(BuildContext context) {

    final employees = <Employee>[];

    for (var i = 0; i < names.length; i++) {
      employees.add(Employee(
        name: names[i],
        domain: domains[i],
        college: colleges[i],
        email: emails[i],
      ));
      /*print(names[i]);
      print(domains[i]);
      print(colleges[i]);
      print(emails[i]);*/
    }

    final listView = Container(
      color: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(employees),
    );

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Welcome '+widget.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.tealAccent,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        onPressed: () {
          print("addemp");
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEmp()),
          );
        },
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      appBar: appBar,
      body: listView,
    );
  }

  void med() async{
    int p = await loadEmps();
    print(p);
    //setState(() {
      
    //});
  }

  Future<int> loadEmps() async {
    http.Response resp = await http.get(
      Uri.encodeFull('http://mobapp.eaiesb.com/mobapp/viewallemployees'),
      headers: {
        'Accept': 'application/json',
      }
    );

    var data = json.decode(resp.body);

    names  = new List<String>();
    domains  = new List<String>();
    colleges  = new List<String>();
    emails = new List<String>();

    int i=0;
    try{
    while(data[i]!=null)
    {
      names.add(data[i]['firstname']);
      domains.add(data[i]['domain']);
      colleges.add(data[i]['college']);
      emails.add(data[i]['email']);
      i++;
    }
    }
    on RangeError catch(_){
      //setState(() {
      //});
    }

    return 999;
  }

}