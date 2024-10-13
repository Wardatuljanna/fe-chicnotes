// ignore_for_file: prefer_const_constructors

import 'package:chicnotes/controllers/note_controller.dart';
import 'package:chicnotes/models/note.dart';
import 'package:chicnotes/widgets/custom_button.dart';
import 'package:chicnotes/widgets/custom_search.dart';
import 'package:chicnotes/widgets/custom_textfield.dart';
import 'package:chicnotes/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
                        ));
              },
              icon: const FaIcon(
                FontAwesomeIcons.plus,
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
                    child: SingleChildScrollView(
                  child: Column(
                    children: controller.filteredNote
                        .map((note) => Slidable(
                              child: TodoTile(note: note),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {},
                                      backgroundColor: Color(0xff8394FF),
                                      foregroundColor: Colors.white,
                                      icon: FontAwesomeIcons.pencil,
                                      label: "Edit",
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {},
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: FontAwesomeIcons.trash,
                                      label: "Delete",
                                    ),
                                  ]),
                            ))
                        .toList(),
                  ),
                ))
              ],
            );
          }),
        ));
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
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
            note.date ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            note.description ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xff949494),
            ),
          )
        ],
      ),
    );
  }
}

class ManipulateNote extends StatelessWidget {
  const ManipulateNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetBuilder<NoteController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add Note",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 21,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30),
            CustomTextField(hint: "Title", 
            controller: controller.titleController
            ),
            SizedBox(height: 10),
            CustomTextField(
              hint: "Description",
              maxLines: 5, 
              controller: controller.descriptionController
            ),
            SizedBox(height: 30),
            CustomButton(
                label: "Add",
                onPressed: () async {
                  await Get.showOverlay(
                      asyncFunction: () => controller.addTodo(),
                      loadingWidget: const Loader());
                }),
          ],
        );
      }),
    );
  }
}
