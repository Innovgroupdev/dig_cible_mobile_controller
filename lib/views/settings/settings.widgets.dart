import 'dart:ui';

import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 115,
            width: 115,
            child: ClipRRect(
              // backgroundImage: AssetImage("$imagesPath/s.jpeg"),
              child: Image.network(
                  // 'https://img.icons8.com/material-rounded/96/013d1b/user.png',
                  'https://img.icons8.com/ios-glyphs/90/013d1b/qr-code--v1.png'),
            )),
        Visibility(
          visible: SharedPreferencesHelper.getNom() != null &&
              SharedPreferencesHelper.getPrenoms() != null,
          child: Text(
            '${Provider.of<UserProvider>(context).nom} ${Provider.of<UserProvider>(context).prenoms}',
            style: const TextStyle(
              color: AppColor.primary,
              fontSize: 15,
            ),
          ),
        ),
        Visibility(
          visible: SharedPreferencesHelper.getEmail() != null,
          child: Text(
            Provider.of<UserProvider>(context).email,
            style: const TextStyle(
              color: AppColor.primary,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });

  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: AppColor.secondary,
          elevation: 0,
          shadowColor: Color.fromARGB(31, 160, 195, 176),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: press,
        child: ListTile(
          leading: icon,
          title: Text(
            text,
            style: const TextStyle(color: AppColor.primary),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
