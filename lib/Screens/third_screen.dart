
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {

  var userInfo;
  //List <Map<String,dynamic>>userInfo = [];


  Future<void> getAPIcall() async {
  var url = Uri.parse('https://randomuser.me/api/');
  var response =await http.get(url);
  var data = await json.decode(response.body);
  setState(() {
    userInfo = data['results'];
  });
}
@override
  void initState() {
   super.initState();
  //  readJson();
    getAPIcall();
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 37, 6, 78),
      ),
       body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: AssetImage('assets/4.jpg'),
            opacity: 0.4,
           fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const  Text(
              'Name:', 
               style: TextStyle(fontSize: 20),
               ),
               Text(
                '${userInfo[0]}',
               ),
               ],
               ),
      ),
    );
  }
}