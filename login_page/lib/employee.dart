import 'package:flutter/material.dart';
import 'package:login_page/update_delete.dart';

final _rowHeight = 120.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Employee extends StatelessWidget {
  final String name;
  final String domain;
  final String college;
  final String email;
  final IconData icon;

  const Employee({
    Key key,
    @required this.name,
    @required this.domain,
    @required this.college,
    @required this.email,
    @required this.icon,
  })  : assert(name != null),
        assert(domain != null),
        assert(college != null),
        assert(email != null),
        assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return Material(
      color: Colors.lightBlue,
      child: Container(
        height: _rowHeight,
        color: Colors.white,
        child: InkWell(
            borderRadius: _borderRadius,
            highlightColor: Colors.deepOrange,
            splashColor: Colors.teal,
            onTap: () {
              print('hello');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateDelete(email: email)),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                      child: Text(
                    name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline,
                  )),
                  Center(
                    child: Text(
                      domain,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  Center(
                    child: Text(
                      college,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  )
                ],
              ),
            )),
      ),
    );*/

    return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateDelete(email: email)),
          );
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.black))),
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(college, style: TextStyle(color: Colors.black, fontSize: 12.0))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 36.0));
  }
}
