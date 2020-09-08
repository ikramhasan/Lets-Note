import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CustomAppbar extends StatelessWidget {
  final Function onTap;

  CustomAppbar({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 55),
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pop(context);
            },
            child: Ink(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: FaIcon(FontAwesomeIcons.arrowLeft),
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Ink(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
