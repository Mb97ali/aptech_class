import 'dart:ffi';

import 'package:aptech_class/main.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen(this.id,this.name, this.fatherName, this.description, this.department,{super.key});

  final int id;
  final String name;
  final String fatherName;
  final String department;
  final String description;

  @override
  State<SecondScreen> createState() => _SecondScreenState(id, name, fatherName,department,description,);
}

class _SecondScreenState extends State<SecondScreen> {
  
  _SecondScreenState(this.id,this.name, this.fatherName, this.description, this.department,);

  final int id;
  final String name;
  final String fatherName;
  final String department;
  final String description;

  Widget textWidget(String content){
      return Text(
          content,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            ),
        );
  }

  @override
  void initState() {
     super.initState();

     print('id=$id');
     print('name=$name');
     print('fatherName=$fatherName');
     print('department=$department');
     print('desciption=$description');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$id'),
      ),
    body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            textWidget(name),
            textWidget(fatherName),
          ],
        ),
        const SizedBox(height:50),
        textWidget(department),
        const SizedBox(height:50),
        textWidget(description),
      ],
    ),
    );
  }
}