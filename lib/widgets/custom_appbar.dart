import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomAppbar extends StatelessWidget {
  final AppbarType appbarType;
  final Function onTap;

  const CustomAppbar({@required this.appbarType, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 55),
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appbarType == AppbarType.ADD_NOTE_SCREEN
              ? InkWell(
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
                )
              : Text(
                  'Notes',
                  style: GoogleFonts.ubuntu(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          appbarType == AppbarType.ADD_NOTE_SCREEN
              ? InkWell(
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
                )
              : InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.blue,
                  onTap: onTap,
                  child: Ink(
                    padding: EdgeInsets.only(bottom: 5),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/search.json',
                        frameRate: FrameRate(60),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

enum AppbarType { NOTE_SCREEN, ADD_NOTE_SCREEN }
