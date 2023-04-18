import 'package:json_class/model/description.dart';

final String tableNotes = 'notes';

class NotesFields {
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
  static final List<String> values = [id, title, description, time];
}

class Note {
  int? id;
  String? title;
  String? description;
  DateTime? createdDate;
  // Note();
  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdDate,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
      );
  Note(
      {this.id,
      required this.title,
      this.description,
      required this.createdDate});
  Note.fromJson(Map<String, dynamic> json) {
    id = json[NotesFields.id] as int?;
    title = json[NotesFields.title];
    description = json[NotesFields.description];
    createdDate = DateTime.parse(json[NotesFields.time]);
  }
  Map<String, Object?> toJson() => {
        NotesFields.id: id,
        NotesFields.title: title,
        NotesFields.description: description,
        NotesFields.time: createdDate!.toIso8601String(),
      };
}
