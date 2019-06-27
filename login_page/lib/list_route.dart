import 'package:flutter/material.dart';
import 'package:login_page/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'add_emp.dart';

class ListRoute extends StatefulWidget {
  //final String name;

  ListRoute({Key key}) : super(key: key);

  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<ListRoute> {
  List<String> names = new List<String>();
  List<String> domains = new List<String>();
  List<String> colleges = new List<String>();
  List<String> emails = new List<String>();
  List<IconData> icons = new List<IconData>();
  //_ListState(){}

  @override
  void initState() {
    super.initState();
    loadEmps().then((c) {
      setState(() {});
    });
    //setState(() {

    //});
  }

  Widget _buildCategoryWidgets(List<Widget> employees) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => employees[index],
      itemCount: employees.length,
    );
  }

  Future<void> _refreshList() async {
    print('refreshing list...');
    med();
  }

  @override
  Widget build(BuildContext context) {
    final employees = <Employee>[];
    IconData x;

    for (var i = 0; i < names.length; i++) {
      if (domains[i].toLowerCase() == 'web') {
        x = Icons.language;
      } else {
        x = Icons.phone_android;
      }
      employees.add(Employee(
        name: names[i],
        domain: domains[i],
        college: colleges[i],
        email: emails[i],
        icon: x,
      ));
    }

    final listView = Container(
      color: Colors.lightBlue[200],
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(employees),
    );

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'WELCOME ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.indigo[300],
    );

    /*final xyz = CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          expandedHeight: 150.0,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Available seats'),
          ),
        ),
      ],
    );*/

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        elevation: 5.0,
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => AddEmp()))
              .whenComplete(med);
        },
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      appBar: appBar,
      body: new RefreshIndicator(
          child: listView,
          onRefresh: _refreshList,
        )
    );
  }

  void med() async {
    int p = await loadEmps();
    print(p);
    setState(() {});
  }

  Future<int> loadEmps() async {
    http.Response resp = await http.get(
        Uri.encodeFull('https://mobapp.eaiesb.com/mobapp/viewallemployees'),
        headers: {
          'Accept': 'application/json',
        });

    var data = json.decode(resp.body);

    names = new List<String>();
    domains = new List<String>();
    colleges = new List<String>();
    emails = new List<String>();

    int i = 0;
    try {
      while (data[i] != null) {
        names.add(data[i]['firstname']);
        domains.add(data[i]['domain']);
        colleges.add(data[i]['college']);
        emails.add(data[i]['email']);
        i++;
      }
    } on RangeError catch (_) {
      //setState(() {
      //});
    }

    return 999;
  }
}
