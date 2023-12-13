import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project__widget_testing/constants/colors.dart';
import 'package:major_project__widget_testing/constants/fontfamily.dart';
import 'package:major_project__widget_testing/utils/scaling.dart';
import 'package:major_project__widget_testing/utils/text_lineheight.dart';

class DefaultRoundsDescription extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final String description;
  const DefaultRoundsDescription({super.key, required this.description, required this.containerHeight, required this.containerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: defaultEditScaleWidth(containerWidth, 550),
        height: defaultEditScaleHeight(containerHeight, 453),
        child: Stack(children: [
          Positioned(
            left: defaultEditScaleWidth(containerWidth, 31),
            top: defaultEditScaleHeight(containerHeight, 0),
            child: Container(
              width: defaultEditScaleWidth(containerWidth, 486),
              height: defaultEditScaleHeight(containerHeight, 318),
              decoration: ShapeDecoration(
                  color: black1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: const [
                    BoxShadow(
                        blurRadius: 3,
                        offset: Offset(0, -4),
                        spreadRadius: 0,
                        color: Colors.black)
                  ]),
            ),
          ),
          Positioned(
              left: 0,
              top: 33,
              child: Container(
                  width: defaultEditScaleWidth(containerWidth, 550),
                  height: defaultEditScaleHeight(containerHeight, 360),
                  padding: EdgeInsets.only(top : defaultEditScaleHeight(containerHeight, 21), left : defaultEditScaleWidth(containerWidth, 31), right : defaultEditScaleWidth(containerWidth, 19), bottom : defaultEditScaleHeight(containerHeight, 66)),
                  decoration: ShapeDecoration(
                      color: lavender,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      ),
                  child: Text('Welcome to the electrifying first round of Velocity Vista - the "UX Face-Off!" Here, we separate design champions from budding creators as they embark on a quest to showcase their UI/UX design skills. Your mission: craft a dazzling UI/UX design for a website or app, and this is your moment to shine. The submission window is open from October 21st, 2023, at 12:00 AM to October 23rd, 2023, at midnight. Brace yourself; it''s an elimination round, so bring your absolute best! The submission form awaits, with the label "Submit Your Design" and PDF as the only accepted format',
                  textAlign: TextAlign.center,
                   style: GoogleFonts.getFont(fontFamily2,
                  fontSize: defaultEditScaleWidth(containerWidth, 15),
                  color: greyish1,
                  fontWeight: FontWeight.w400,
                  height: lineHeight(27, 18))))),
          Positioned(
              left: defaultEditScaleWidth(containerWidth, 229),
              top: defaultEditScaleHeight(containerHeight, 339),
              child: Container(
                width: defaultEditScaleWidth(containerWidth, 114),
                height: defaultEditScaleHeight(containerHeight, 114),
                decoration:
                    const ShapeDecoration(color: black1, shape: CircleBorder()),
              ))
        ]));
  }
}
