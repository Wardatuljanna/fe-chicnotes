// ignore_for_file: prefer_const_constructors

import 'package:chicnotes/controllers/note_controller.dart';
import 'package:chicnotes/routes.dart';
import 'package:chicnotes/utils/shared_prefs.dart';
import 'package:chicnotes/widgets/custom_button.dart';
import 'package:chicnotes/widgets/custom_search.dart';
import 'package:chicnotes/widgets/custom_textfield.dart';
import 'package:chicnotes/widgets/loader.dart';
import 'package:chicnotes/screens/home/detail_note_screen.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:chicnotes/models/note.dart';
import 'package:intl/intl.dart'; 

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ChicNotes',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            color: Color(0xff000000),
            fontWeight: FontWeight.w600,
          ),
          softWrap: false,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: ManipulateNote(),
                ),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Logout?"),
                  content: Text("Are you sure you want to log out?"),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        await SharedPrefs().removeUser();
                        Get.offAllNamed(GetRoutes.login);
                      },
                      child: Text("Confirm")),
                  ],
                ),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<NoteController>(builder: (controller) {
          return Column(
            children: [
              CustomSearch(onChanged: (val) {
                noteController.search(val);
              }),
              const SizedBox(height: 30),
              Expanded(
                child: controller.notes.isEmpty
                    ? Center(
                        child: Text(
                          "No note yet",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : controller.filteredNote.isEmpty
                        ? Center(
                            child: Text(
                              "Note not found",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.filteredNote.length,
                            itemBuilder: (context, index) {
                              final note = controller.filteredNote[index];
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        controller.titleController.text = note.title ?? '';
                                        controller.descriptionController.text =
                                            note.description ?? '';
                                        controller.update();
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: ManipulateNote(
                                              edit: true,
                                              id: note.id!.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      backgroundColor: Color(0xff8394FF),
                                      foregroundColor: Colors.white,
                                      icon: FontAwesomeIcons.pencil,
                                      label: "Edit",
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text("Delete Note?"),
                                            content: Text(
                                                "Are you sure you want to delete this note?"),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  controller.update();
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  foregroundColor: Colors.white,
                                                ),
                                                onPressed: () async {
                                                  await Get.showOverlay(
                                                    asyncFunction: () => controller
                                                        .deleteNote(note.id!.toString()),
                                                    loadingWidget: const Loader(),
                                                  );
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                    controller.update();
                                                  }
                                                },
                                                child: Text("Confirm"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: FontAwesomeIcons.trash,
                                      label: "Delete",
                                    ),
                                  ],
                                ),
                                child: TodoTile(note: note),
                              );
                            },
                          ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.note});

  final Note note;
  String formatDate(String isoDate) {
    try {
      DateTime dateTime = DateTime.parse(isoDate); 
      return DateFormat('dd-MM-yyyy').format(dateTime); // Format dd-MM-yyyy
    } catch (e) {
      return ''; 
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
      future: SharedPrefs().getColor(note.id!.toString()), // Convert id to String
      builder: (context, snapshot) {
        // Default to white if no color is saved
        Color tileColor = const Color(0xffF7F7F7); // Default color for new notes
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            tileColor = snapshot.data!;
        }

        return GestureDetector(
          onTap: () {
            Get.to(DetailNoteScreen(note: note));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: tileColor, // Default or saved color
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 21,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formatDate(note.createdAt ?? ''), 
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 60, 
                  ),
                  child: Text(
                    note.description ?? '',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xff949494),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1, 
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ManipulateNote extends StatelessWidget {
  const ManipulateNote({super.key, this.edit = false, this.id = ""});

  final bool edit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetBuilder<NoteController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${edit ? "Edit" : "Add"} Note",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 21,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30),
            CustomTextField(
                hint: "Title", controller: controller.titleController),
            SizedBox(height: 10),
            CustomTextField(
                hint: "Description",
                maxLines: 5,
                controller: controller.descriptionController),
            SizedBox(height: 30),
            CustomButton(
            label: edit ? "Edit" : "Add",
            onPressed: () async {
              if (controller.isProcessing) return; // Cegah klik ganda
              controller.setProcessing(true); // Tandai sedang diproses

              if (!edit) {
                await Get.showOverlay(
                  asyncFunction: () => controller.addNote(),
                  loadingWidget: const Loader(),
                );
              } else {
                await Get.showOverlay(
                  asyncFunction: () => controller.editNote(id),
                  loadingWidget: const Loader(),
                );
              }

              controller.setProcessing(false); // Tandai selesai diproses

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
          ],
        );
      }),
    );
  }
}