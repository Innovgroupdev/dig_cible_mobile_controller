import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/models/Event.dart';
import 'package:cible_controller/views/tabs/en_cours/en_cours.widgets.dart';
import 'package:flutter/material.dart';

class EnCoursScreen extends StatefulWidget {
  EnCoursScreen({required this.events, Key? key}) : super(key: key);
  final List<Event> events;

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
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:  widget.events.length,
                  itemBuilder: (context, index) {
                    print(widget.events[index].dates);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyCards(
                          image: widget.events[index].image == null
                              ? Image.asset(
                                  '$imagesPath/dadju.jpg',
                                  height: 130,
                                  fit: BoxFit.fitHeight,
                                )
                              : Image.network(widget.events[index].image,
                                  height: 130, fit: BoxFit.cover),
                          name: widget.events[index].title,
                          lieu: widget.events[index].location,
                          date: widget.events[index].dates.first,
                          eventId: widget.events[index].id,
                        ),
                      ],
                    );
                  })

          ],
        ),
      ),
    );
  }
}
