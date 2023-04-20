import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_class/database/db_helper.dart';
import 'package:json_class/model/note.dart';

class DeletedNotes extends StatefulWidget {
  const DeletedNotes({super.key});

  @override
  State<DeletedNotes> createState() => _DeletedNotesState();
}

class _DeletedNotesState extends State<DeletedNotes> {
  List<Note> deletedNotes = [];
  Future getNotes() async {
    var n = await DBHelper.instance.showDeletedNotes();
    setState(() {
      deletedNotes.addAll(n);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deleted Notes'),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
          itemCount: deletedNotes.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(deletedNotes[index].title!),
              subtitle: Text(deletedNotes[index].description!),
              trailing: Wrap(
                spacing: 10.0,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await DBHelper.instance.delete(deletedNotes[index].id!);
                      setState(() {
                        deletedNotes.removeAt(index);
                      });
                    },
                  )
                ],
              ),
            );
          })),
    );
  }
}
