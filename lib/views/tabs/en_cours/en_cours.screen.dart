import 'dart:convert';

import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/views/tabs/en_cours/en_cours.widgets.dart';
import 'package:flutter/material.dart';

import '../../../constants/api.dart';
import '../../../helpers/sharedPreferences.dart';

import '../../../models/categorie.dart';

class EnCoursScreen extends StatefulWidget {
  EnCoursScreen({required this.categories, Key? key}) : super(key: key);
  final List<Categorie> categories;

  @override
  State<EnCoursScreen> createState() => _EnCoursScreenState();
}

class _EnCoursScreenState extends State<EnCoursScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var categorie in widget.categories) ...[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  categorie.titre,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
              ),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categorie.events.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyCards(
                          image: categorie.events[index].image == null
                              ? Image.asset(
                                  '$imagesPath/dadju.jpg',
                                  height: 130,
                                  fit: BoxFit.fitHeight,
                                )
                              : Image.network(categorie.events[index].image,
                                  height: 130, fit: BoxFit.cover),
                          name: categorie.events[index].titre,
                          lieu: categorie.events[index].newLieu,
                          date: categorie.events[index].date,
                          eventId: categorie.events[index].id,
                        ),
                      ],
                    );
                  })
            ]
          ],
        ),
      ),
    );
  }
}
