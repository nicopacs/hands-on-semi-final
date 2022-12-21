import 'package:flutter/material.dart';
import 'package:put_practice/models/model.dart';
class FormPage extends StatefulWidget {
  final String title;
  final int id, userId;
  final bool completed;

  const FormPage({Key? key,
    required this.id,
    required this.userId,
    required this.title,
    required this.completed}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController titleCon = TextEditingController();
  var formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    setState(() {
      titleCon.text = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
                textAlign: TextAlign.justify,
                keyboardType: TextInputType.text,
                controller: titleCon,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                validator: (value) {
                  return value == null || value.isEmpty ?
                  'Please Enter a Title' : null;
                }
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(formKey.currentState!.validate()){
                 Model update =Model(
                      id: widget.id,
                      userId: widget.userId,
                      title: titleCon.text,
                      completed: false);

                 Navigator.pop(context, update);
                }

              },
              child: const Text('Update'),
            ),

          ],
        ),
      ),
    );
  }
}