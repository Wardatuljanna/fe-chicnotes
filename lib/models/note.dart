class AllNotes {
  bool? success;
  String? message;
  List<Note>? note;

  AllNotes({this.success, this.message, this.note});

  AllNotes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      note = <Note>[];
      json['data'].forEach((v) {
        note!.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (note != null) {
      data['data'] = note!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Note {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? date;

  Note({this.id, this.userId, this.title, this.description, this.date});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}
