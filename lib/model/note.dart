import 'package:json_class/model/description.dart';

final String tableNotes = 'notes';

class NotesFields {
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String isDeleted = 'isDeleted';
  static final String time = 'time';
  static final List<String> values = [id, title, description, time];
}

class Note {
  int? id;
  String? title;
  String? description;
  bool? isDeleted;
  DateTime? createdDate;
  // Note();
  Note copy({
    int? id,
    String? title,
    String? description,
    bool? isDeleted,
    DateTime? createdDate,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDeleted: isDeleted ?? this.isDeleted,
        createdDate: createdDate ?? this.createdDate,
      );
  Note(
      {this.id,
      required this.title,
      this.description,
      this.isDeleted,
      required this.createdDate});
  Note.fromJson(Map<String, dynamic> json) {
    id = json[NotesFields.id] as int?;
    title = json[NotesFields.title];
    description = json[NotesFields.description];
    isDeleted = json[NotesFields.isDeleted] == 0 ? false : true;
    createdDate = DateTime.parse(json[NotesFields.time]);
  }
  Map<String, Object?> toJson() => {
        NotesFields.id: id,
        NotesFields.title: title,
        NotesFields.description: description,
        NotesFields.isDeleted: isDeleted,
        NotesFields.time: createdDate!.toIso8601String(),
      };
}
