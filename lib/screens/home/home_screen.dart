// ignore_for_file: prefer_const_constructors

import 'package:chicnotes/widgets/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

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
          IconButton(onPressed: (){}, icon: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.black,
            ),
          ),
        ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomSearch(onChanged: (val){}),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(8, (index) => Slidable(
                    child: const TodoTile(),
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
                  )).toList(),
                  ),
              ))
          ],
        ),
      )
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              color: Color(0xff000000),
              fontWeight: FontWeight.w600,
            ),
          ),
        Text(
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
          style: TextStyle(
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