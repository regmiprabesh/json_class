import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_class/database/db_helper.dart';
import 'package:json_class/deleted_notes.dart';
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
  late List<Note> myNotes = [];
  Future getNotes() async {
    var n = await DBHelper.instance.showNotes();
    setState(() {
      myNotes.addAll(n);
    });
  }

  Future searchNotes(String query) async {
    var d = await DBHelper.instance.searchNotes(query);
    setState(() {
      myNotes.clear();
      myNotes.addAll(d);
    });
  }

  Future addNote() async {
    final note = Note(
        title: noteTitleController.text,
        description: noteDescriptionController.text,
        isDeleted: false,
        createdDate: DateTime.now());
    Note n = await DBHelper.instance.create(note);
    setState(() {
      myNotes.add(n);
    });
    noteTitleController.clear();
    noteDescriptionController.clear();
  }

  Future editNote([bool? isEdit, int? index]) async {
    final note = Note(
        id: myNotes[index!].id,
        title: noteTitleController.text,
        description: noteDescriptionController.text,
        createdDate: DateTime.now());
    int a = await DBHelper.instance.update(note);
    setState(() {
      myNotes[index] = note;
    });
    noteTitleController.clear();
    noteDescriptionController.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return DeletedNotes();
              })));
            },
            child: Icon(Icons.delete),
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              _showAddNote(context);
            },
            child: Icon(Icons.add),
            heroTag: null,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onChanged: (value) {
                searchNotes(value);
              },
              decoration: InputDecoration(hintText: 'Search'),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                        onPressed: () async {
                          // await DBHelper.instance.delete(myNotes[index].id!);
                          Note deleteNote = Note(
                              id: myNotes[index].id,
                              title: myNotes[index].title,
                              description: myNotes[index].description,
                              isDeleted: true,
                              createdDate: DateTime.now());
                          await DBHelper.instance.temporaryDelete(deleteNote);
                          setState(() {
                            myNotes.removeAt(index);
                          });
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                              isEdit != null
                                  ? editNote(isEdit, index)
                                  : addNote();
                              Navigator.pop(context);
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
