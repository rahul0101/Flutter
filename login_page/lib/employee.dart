import 'package:flutter/material.dart';

final _rowHeight = 120.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Employee extends StatelessWidget {
  final String name;
  final String domain;
  final String college;

  const Employee({
    Key key,
    @required this.name,
    @required this.domain,
    @required this.college,
  })  : assert(name != null),
        assert(domain != null),
        assert(college != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                      )
                  ),
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
    );
  }
}