import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../forms/edit_form.dart';
import '../models/model.dart';
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
   List todoItems = [];
   List <Model> todoModel = [];
   var baseUrl = 'https://jsonplaceholder.typicode.com/todos';

   @override
   void initState() {
     super.initState();
     todoConverter();
   }
  /// CONVERT GET TODO TO LIST
  void todoConverter() async {
    await get();
    for(int a = 0; a < todoItems.length; a++){
      todoModel.add(Model.fromJson(todoItems[a]));
    }
  }
 /// GET TODO
  Future get() async {
    var response = await http.get (Uri.parse(baseUrl));
    if(response.statusCode == 200){
      setState(() {
        todoItems = convert.jsonDecode(response.body) as List <dynamic>;
      });
    } else {
      throw Exception('Request Code Error ${response.statusCode}');
    }
  }

  /// UPDATE TODO

   Future <Model> update (String title,int id,
       int userId, bool completed) async {
     var response = await http.patch(Uri.parse(
         '$baseUrl/$id?userId=$userId&title=$title&completed=$completed'),
         body: convert.jsonEncode(<String, dynamic>{
           'title' : title,
           'userId' : userId,
           'completed' : completed,
         })
     );
     if (response.statusCode == 200){
      print('Updated Successfully');
      print(response.body);
       return Model.fromJson(convert.jsonDecode(response.body));
     } else {
       print('Request failed with a status: ${response.statusCode}');
       throw Exception('Failed to update todo');
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,

      ),
      body: ListView.builder(
        itemCount: todoModel.length,
        itemBuilder: (context, index){
          final item = todoModel[index];
          return Column(
            children: [
              Card(
                elevation: 10,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(item.title.toString()),
                  subtitle: Text(item.userId.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async{
                      Model todoModel = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FormPage(id: item.id,
                          userId: item.userId,
                          title: item.title, completed: item.completed)));
                      setState(() {
                        update(
                            todoModel.title,
                            todoModel.id,
                            todoModel.userId,
                            todoModel.completed);
                      });
                    },
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
