import 'dart:convert';
import 'package:chicnotes/models/note.dart';
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

  bool isProcessing = false;

  void setProcessing(bool value) {
    isProcessing = value;
    update(); // Perbarui UI agar tombol bisa di-disable/enable
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllNotes();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   titleController.dispose();
  //   descriptionController.dispose();
  // }

  Future<Map<String, String>> getHeaders() async {
    String? token = await SharedPrefs().getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  fetchAllNotes() async {
  try {
    var headers = await getHeaders();

    var response = await http.get(
      Uri.parse('${baseurl}note/all'),
      headers: headers,
    );
    var res = json.decode(response.body);

    if (response.statusCode == 200) {
      notes = res['notes'] != null ? AllNotes.fromJson(res).notes! : [];
      filteredNote = notes;
      update(); 
    } else {
      notes = [];
      filteredNote = [];
      update(); 
    }
  } catch (err) {
    notes = [];
    filteredNote = [];
    update();  
  }
}

  search(String val) {
    if (val.isEmpty) {
      filteredNote = notes;
    } else {
      filteredNote = notes.where((note) => note.title?.toLowerCase().contains(val.toLowerCase()) ?? false).toList();
    }
    update();
  }

  fetchDetailNote(String noteId) async {
    try {
      var headers = await getHeaders();
      var response = await http.get(Uri.parse('${baseurl}note/$noteId'), headers: headers);

      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        detailNote = Note.fromJson(res['note']);
        update();
      } else {
        customSnackbar("Error", res['message'] ?? "Failed to retrieve record details", "error");
      }
    } catch (err) {
      customSnackbar("Error", "An error occurred on the server", "error");
    }
  }

  addNote() async {
    try {
      var headers = await getHeaders();
      var response = await http.post(Uri.parse('${baseurl}note'), headers: headers, body: jsonEncode({
        "title": titleController.text,
        "description": descriptionController.text,
      }));

      var res = json.decode(response.body);
      if (response.statusCode == 201) {
        customSnackbar("Success", res['message'], "success");
        titleController.clear();
        descriptionController.clear();
        fetchAllNotes();
      } else {
        customSnackbar("Error", res['message'] ?? "Failed to add note", "error");
      }
    } catch (err) {
      customSnackbar("Error", "An error occurred on the server", "error");
    }
  }

  editNote(String id) async {
    try {
      var headers = await getHeaders();
      var response = await http.put(Uri.parse('${baseurl}note/$id'), headers: headers, body: jsonEncode({
        "title": titleController.text,
        "description": descriptionController.text,
      }));

      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        customSnackbar("Success", res['message'], "success");
        titleController.clear();
        descriptionController.clear();
        fetchAllNotes();
      } else {
        customSnackbar("Error", res['message'] ?? "Failed to edit note", "error");
      }
    } catch (err) {
      customSnackbar("Error", "An error occurred on the server", "error");
    }
  }

  deleteNote(String id) async {
  try {
    var headers = await getHeaders();
    var response = await http.delete(Uri.parse('${baseurl}note/$id'), headers: headers);

    var res = json.decode(response.body);
    if (response.statusCode == 200) {
      customSnackbar("Success", res['message'], "success");
      await fetchAllNotes();
      update(); 
    } else {
      customSnackbar("Error", res['message'] ?? "Failed to delete note", "error");
    }
  } catch (err) {
    customSnackbar("Error", "An error occurred on the server", "error");
  }
}


  var selectedColorMap = <String, Color>{}.obs;

  void updateColor(String noteId, Color color) {
    selectedColorMap[noteId] = color;
    update();
  }

  Color getColorForNote(String noteId) {
  return selectedColorMap[noteId] ?? const Color(0xffF7F7F7); // Warna default
}
}