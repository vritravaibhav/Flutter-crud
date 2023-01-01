

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/updatestudentpage.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('student').snapshots();

  CollectionReference students = FirebaseFirestore.instance.collection('student');

  Future<void>  deleteUser(id){
    return students.doc(id).delete()
        .then((value) => print("user deleted"))
        .catchError((error)=> print('faled to delete user: $error'));

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream:  studentsStream ,
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot>
        snapshot ){
    if(snapshot.hasError){
      print('something went wrong');
    }
    if(snapshot.connectionState== ConnectionState.waiting){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final List storedocs=[];
    snapshot.data!.docs.map((DocumentSnapshot document){
      Map a = document.data() as Map<String,dynamic>;
      a['id']= document.id;
      storedocs.add(a);
    }).toList();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{1: FixedColumnWidth(140)},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              TableCell(
                child: Container(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(
                      'Action',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                ),
              ),
            ]),
            for(var i = 0; i<storedocs.length;i++)...[
            TableRow(children: [
              TableCell(
                  child: Center(
                    child: Text(storedocs[i]['name']),
                  )),
              TableCell(
                child: Center(
                  child: Text(storedocs[i]['email']),
                ),
              ),
              TableCell(
                  child: Row(
                    children: [
                      IconButton(onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder: (context )=>UpdateStudentPage(id:storedocs[i]["id"]),))
                      }, icon: Icon(Icons.edit,
                        color: Colors.orange,
                      )),
                      IconButton(onPressed: ()=> {deleteUser(storedocs[i]['id'])}, icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                    ],
                  ))
            ])
          ]
          ],
        ),
      ),
    );
    });
  }
}
