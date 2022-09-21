import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/home_screen/cubit/details_cubit.dart';
import 'package:proj/features/home_screen/cubit/details_state.dart';
import 'dart:convert';

import 'package:proj/models/details_screen_model.dart';

import '../../cubit/counter_cubit.dart';

class DetailsScreen extends StatefulWidget {
  final String title;
  final int id;

  const DetailsScreen({Key? key, required this.title, required this.id})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<DetailsScreenModel> sections = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSection();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(widget.title),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return detailedCard(section: sections[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
              height: 5,
              thickness: 2,
            );
          },
          itemCount: sections.length,
        ),
      ),
    );
  }

  Widget detailedCard({required DetailsScreenModel section}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.description!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              section.content!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              section.reference!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Text(
                    section.count!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) => Text(
                      CounterCubit.get(context).counter.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  CounterCubit.get(context)
                      .increament(int.parse(section.count!));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadSection() async {
    sections = [];
    DefaultAssetBundle.of(context)
        .loadString('assets/database/section_details_db.json')
        .then((value) {
      var response = json.decode(value);
      response.forEach((section) {
        DetailsScreenModel _section =
            DetailsScreenModel.fromJson(section as Map<String, dynamic>);
        if (_section.section_id == widget.id) {
          sections.add(_section);
        }
      });
      setState(() {});
      // print(response.toString());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
