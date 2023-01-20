import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:aptech_class/Screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

//INITIALIZING DIO LIBRARY
Dio dio=Dio(); //safer to use this way without/after annotating

//Variables and Functions Area
int id=1;
List studentsInfo = [];
List products=[];

//FUNCTION RESPONSIBLE FOR GETTING DATA FROM JSON FILE
Future<void> readJson() async {
  final String response =await rootBundle.loadString('assets/data.json');
  final data = await json.decode(response);
  setState(() {
    studentsInfo = data["studentsInfo"];
  });
}
//API CALL FOR GETTING DATA FROM API SERVER
Future<void> getAPIcall() async {
  var url = Uri.parse('https://dummyjson.com/products');
  var response =await http.get(url);
  var data = await json.decode(response.body);
  setState(() {
    products = data['products'];
  });
}

//SAME GET API CALL USING DIO LIBRARY
Future<void> getAPIcallDio() async {
  var url = 'https://dummyjson.com/products';
  try{ 
  var response = await dio.get(url);
  //var data = await json.decode(response.body);
  setState(() {
    products = response.data['products'];
  });
  } catch (e){
    print(e);
  }
}
@override
  void initState() {
   super.initState();
  //  readJson();
  // getAPIcall();
  getAPIcallDio();
}
  
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title:const Text(
          'Test',
           style: TextStyle(
           color: Colors.black,
           fontSize: 25,
           fontWeight: FontWeight.bold,
           ) ,
        ) ,
        centerTitle: true,
        
      ),
      body: products.isEmpty //better to use condition isNotEmpty (obvious case - and the obvious case should be written in if statement)
      ? const Center (
            child: CircularProgressIndicator(), //widget for loading
      )
      :ListView.builder(
        itemCount:products.length, 
        itemBuilder:(BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                //onTap: () {

                  //Navigation from One screen to Another
                 // Navigator.push(
                  //  context, 
                   // MaterialPageRoute(
                     // builder: (context) =>  SecondScreen(
                       // studentsInfo[index]['id'],
                       // studentsInfo[index]['name'],
                       // studentsInfo[index]['fatherName'],
                        //studentsInfo[index]['dept'],
                        //studentsInfo[index]['description'],
                      //),   //builder builds a bridge from first screen to the next
                    //),
                  //);
                //} ,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 20,
                    child:
                    CachedNetworkImage(
                      imageUrl: '${products[index]['thumbnail']}' ,
                      placeholder: ((context, url) =>  const CircularProgressIndicator()),
                      )
                      
                    //Image.network($'{products[index]['thumbnail']}'),

                    ),
                  // Text('${products[index]['id']}',
                  // style: const TextStyle(
                  //  color: Colors.black,
                  //   fontSize: 20,
                  // ),
                  // ),
                  title: Text ('${products[index]['title']}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  subtitle: Text ('${products[index]['brand']}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              
              /* Container(
              //  color: Colors.green,
              //  height:30,
                width: MediaQuery.of(context).size.width,
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),*/
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}