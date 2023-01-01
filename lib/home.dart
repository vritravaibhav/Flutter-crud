import 'package:flutter/material.dart';

import 'addStudentpage.dart';
import 'listStudentPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('FireStore Crud'),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentPage(),
                ),
              );
            }, child: Text(
            'Add',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          )
        ],
      )),
      body: ListStudentPage(),
    );
  }
}
