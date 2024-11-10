import 'package:flutter/material.dart';
import 'package:chicnotes/utils/shared_prefs.dart';
import 'package:chicnotes/models/note.dart';
import 'package:get/get.dart';
import 'package:chicnotes/controllers/note_controller.dart';

class DetailNoteScreen extends StatefulWidget {
  final Note note;

  const DetailNoteScreen({super.key, required this.note});

  @override
  // ignore: library_private_types_in_public_api
  _DetailNoteScreenState createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  Color selectedColor = const Color(0xffF7F7F7);
  final SharedPrefs sharedPrefs = SharedPrefs();

  final List<Color> availableColors = [
    const Color(0xffF7F7F7),
    Colors.pink[50]!,
    Colors.blue[50]!,
    Colors.green[50]!,
    Colors.yellow[50]!,
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedColor();
  }

  Future<void> _loadSelectedColor() async {
    if (widget.note.id != null) {
      Color color = await sharedPrefs.getColor(widget.note.id!);
      setState(() {
        selectedColor = color;
      });
    }
  }

  Future<void> _saveSelectedColor(Color color) async {
    if (widget.note.id != null) {
      await sharedPrefs.storeColor(widget.note.id!, color);
      final noteController = Get.find<NoteController>();
      noteController.updateColor(widget.note.id!, color);
    }
  }

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
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<Color>(
              icon: const Icon(Icons.color_lens, color: Colors.black),
              underline: const SizedBox.shrink(),
              onChanged: (Color? newColor) {
                if (newColor != null) {
                  setState(() {
                    selectedColor = newColor;
                  });
                  _saveSelectedColor(newColor);
                }
              },
              items: availableColors.map<DropdownMenuItem<Color>>((Color color) {
                return DropdownMenuItem<Color>(
                  value: color,
                  child: Container(
                    width: 24,
                    height: 24,
                    color: color,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: selectedColor,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.title, color: Color(0xff000000)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.note.title ?? 'Untitled',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xff000000)),
                  const SizedBox(width: 10),
                  Text(
                    widget.note.date ?? 'No Date',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xff777777),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 1,
                color: Color(0xffDCDCDC),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.description, color: Color(0xff000000)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.note.description ?? 'No Description',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}