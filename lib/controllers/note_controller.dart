import 'dart:convert';

import 'package:chicnotes/models/note.dart';
import 'package:chicnotes/models/user.dart';
import 'package:chicnotes/utils/baseurl.dart';
import 'package:chicnotes/utils/custom_snackbar.dart';
import 'package:chicnotes/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NoteController extends GetxController {
  List<Note> notes = [];
  List<Note> filteredNote = [];
  Note? detailNote;
  late TextEditingController titleController, descriptionController;
  @override
  void onInit() {
    super.onInit();

    fetchAllNotes();

    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();

    titleController.dispose();
    descriptionController.dispose();
  }

  fetchAllNotes() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.get(
      Uri.parse('${baseurl}notes.php?user_id=${user.id}'), 
    );
    var res = await json.decode(response.body);

    if (res['success']) {
      notes = AllNotes.fromJson(res).note!;
      filteredNote = AllNotes.fromJson(res).note!;
      update();
    } else {
      customSnackbar("Error", "Failed to fetch todos", "error");
    }
  }

  search(String val) {
    if (val.isEmpty) {
      filteredNote = notes;
      update();
      return;
    }

    filteredNote = notes.where((note) {
      return note.title!.toLowerCase().contains(val.toLowerCase());
    }).toList();

    update();
  }

  fetchDetailNote(String noteId) async {
  var usr = await SharedPrefs().getUser();
  User user = User.fromJson(json.decode(usr));

  var response = await http.get(
      Uri.parse('${baseurl}detail_note.php?user_id=${user.id}&id=$noteId'),
    );

  var res = await json.decode(response.body);

  if (res['success']) {
    detailNote = Note.fromJson(res['note']); 
    update(); 
  } else {
    customSnackbar("Error", res['message'], "error");
  }}

  addNote() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse('${baseurl}add_note.php'), body: {
      "user_id": user.id,
      "title": titleController.text,
      "description": descriptionController.text,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      titleController.text = "";
      descriptionController.text = "";
      fetchAllNotes();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }

  editNote(id) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse('${baseurl}edit_note.php'), body: {
      "id": id,
      "user_id": user.id,
      "title": titleController.text,
      "description": descriptionController.text,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      titleController.text = "";
      descriptionController.text = "";
      fetchAllNotes();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }

  deleteNote(id) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse('${baseurl}delete_note.php'), body: {
      "id": id,
      "user_id": user.id,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      fetchAllNotes();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }
}
