import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
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
          padding: EdgeInsets.only(top: 20),
          child: TextFormField(
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
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: TextFormField(
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
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: TextFormField(
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
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: TextFormField(
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
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: TextFormField(
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
        )
      ],
    ));
  }
}
