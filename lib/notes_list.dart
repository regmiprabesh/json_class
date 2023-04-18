import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_class/database/db_helper.dart';
import 'package:json_class/model/note.dart';
import 'package:http/http.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  var formKey = GlobalKey<FormState>();
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescriptionController = TextEditingController();
  late List<Note> myNotes = [
    // Note(title: 'Note 1', description: 'Description 1'),
    // Note(title: 'Note 2', description: 'Description 2'),
  ];
  Future getNotes() async {
    this.myNotes = await DBHelper.instance.showNotes();
  }

  Future addNote() async {
    final note = Note(
        title: noteTitleController.text,
        description: noteDescriptionController.text,
        createdDate: DateTime.now());
    await DBHelper.instance.create(note);
  }

  @override
  void dispose() {
    noteDescriptionController.dispose();
    noteTitleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    getNotes();
    // TODO: implement initState
    super.initState();
  }

  // {'title': '', 'description': 'This is Description'},
  // var myArray = ['title', 'description', 'priority'];
  @override
  Widget build(BuildContext context) {
    // Note myNote = Note.fromJson(jsonData);
    // return Center(
    //   child: Text(myNote.description!.desc2),
    // );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNote(context);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: myNotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myNotes[index].title!),
            subtitle: Text(myNotes[index].description!),
            trailing: Wrap(
              spacing: 10.0,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showAddNote(context, true, index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      myNotes.removeAt(index);
                    });
                  },
                )
              ],
            ),
          );
          // return Card(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(myNotes[index].title!),
          //       Text(myNotes[index].description!)
          //     ],
          //   ),
          // );
        },
      ),
    );
  }

  _showAddNote(context, [isEdit, index]) {
    if (isEdit != null) {
      setState(() {
        noteTitleController.text = myNotes[index].title!;
        noteDescriptionController.text = myNotes[index].description!;
      });
    }
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEdit != null ? 'Edit Note' : 'Add Note',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('test');
                            if (formKey.currentState!.validate()) {
                              addNote();
                              Navigator.pop(context);
                              // Note n = Note(
                              //     title: noteTitleController.text,
                              //     description: noteDescriptionController.text);
                              // setState(() {
                              //   isEdit == null
                              //       ? myNotes.add(n)
                              //       : myNotes[index] = n;
                              // });
                              // noteTitleController.clear();
                              // noteDescriptionController.clear();
                              // Navigator.pop(context);
                            }
                          },
                          child: Text('Save',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                    Divider(),
                    TextFormField(
                      controller: noteTitleController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Title",
                          hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500)),
                      validator: (String? title) {
                        if (title!.isEmpty) {
                          return "Title cant be empty";
                        } else if (title.length < 3) {
                          return "Title must be at least 3 characters";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: noteDescriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Description",
                            hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500)),
                        validator: (String? description) {
                          if (description!.isEmpty) {
                            return "Description cant be empty";
                          } else if (description.length < 3) {
                            return "Description must be at least 3 characters";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }
}
