class AllNotes {
  List<Note>? notes;

  AllNotes({this.notes});

  AllNotes.fromJson(Map<String, dynamic> json) {
    if (json['notes'] != null) {
      notes = <Note>[];
      json['notes'].forEach((v) {
        notes!.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Note {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? userId;

  Note({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}
