import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proj/features/details_screen/details_screen.dart';
import 'package:proj/models/section_model.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SectionModel> sections = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSection();
    Workmanager().registerPeriodicTask(
      "1",
      "periodic Notification",
      frequency: Duration(minutes: 360),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding:  EdgeInsets.only(right: 12.0),
            child: Text(
              'أذكار المسلم',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return sectionCard(section: sections[index]);
            },
            itemCount: sections.length,
          ),
        ),
      ),
    );
  }

  Widget sectionCard({required SectionModel section}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  title: section.name!,
                  id: section.id!,
                ),
              ),
            );
          },
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.lightGreenAccent,
                      Colors.green,
                      Colors.lightGreen
                    ])),
            child: Center(
              child: Text(
                section.name!,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  loadSection() async {
    DefaultAssetBundle.of(context)
        .loadString('assets/database/sections_db.json')
        .then((value) {
      var response = json.decode(value);
      response.forEach((section) {
        SectionModel _section =
            SectionModel.fromJson(section as Map<String, dynamic>);
        sections.add(_section);
      });
      setState(() {});
      // print(response.toString());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
