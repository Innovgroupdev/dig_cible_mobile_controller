import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget toastSuccess = Container(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: Colors.greenAccent,
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(Icons.check),
      SizedBox(
        width: 12.0,
      ),
      Text("This is a Custom Toast"),
    ],
  ),
);
Widget toastError(context, msg) => Container(
      //padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(255, 255, 223, 227),
      ),
      child: Container(
        height: 50,
        width:double.infinity,
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 20,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Center(
              child: Text(msg,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  )),
            ),
          ],
        ),
      ),
    );
Widget toastsuccess(context, msg) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(255, 223, 255, 225),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check,
            color: Color.fromARGB(255, 47, 150, 78),
            size: 20,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(msg,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              )),
        ],
      ),
    );
    Widget defaultValue(context, msg) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(255, 223, 223, 223),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check,
            color: Color.fromARGB(255, 37, 37, 37),
            size: 20,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(msg,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 49, 49, 49),
              )),
        ],
      ),
    );