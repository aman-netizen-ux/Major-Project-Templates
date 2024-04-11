import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project__widget_testing/constants/colors.dart';
import 'package:major_project__widget_testing/constants/fontfamily.dart';
import 'package:major_project__widget_testing/utils/scaling.dart';
import 'package:major_project__widget_testing/utils/text_lineheight.dart';
import 'package:major_project__widget_testing/views/Screens/MainNavigation/Desktop/Sections/Profile/User%20Profile/educational_qualifications.dart';
import 'package:major_project__widget_testing/views/Screens/MainNavigation/Desktop/Sections/Profile/User%20Profile/general_information.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int selectedInfoTab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: scaleHeight(context, 820),
        decoration: const BoxDecoration(
            color: Color(0xffdfe1e2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))),
        child: Row(
          children: [
            Expanded(
                flex: 705,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: scaleWidth(context, 28),
                        vertical: scaleHeight(context, 37)),
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                              height: scaleHeight(context, 217),
                              margin: EdgeInsets.only(
                                  bottom: scaleHeight(context, 77)),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xff44a6bb),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: scaleWidth(context, 157.5),
                                      top: scaleHeight(context, 40)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Student',
                                          style: GoogleFonts.getFont(
                                              fontFamily2,
                                              fontSize: scaleWidth(context, 14),
                                              color: const Color(0xfff4f4f4)
                                                  .withOpacity(0.8),
                                              height: lineHeight(19.2, 14),
                                              fontWeight: FontWeight.w300)),
                                      Text('Hello Shanaya',
                                          style: GoogleFonts.getFont(
                                              fontFamily2,
                                              fontSize: scaleWidth(context, 38),
                                              color: const Color(0xfff4f4f4),
                                              height: lineHeight(48, 38),
                                              fontWeight: FontWeight.w500)),
                                      Text(
                                          'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. ',
                                          maxLines: 2,
                                          style: GoogleFonts.getFont(
                                              fontFamily2,
                                              fontSize: scaleWidth(context, 16),
                                              color: const Color(0xfff4f4f4),
                                              height: lineHeight(21.6, 16),
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: scaleHeight(context, 51),
                                  ),
                                  child: SvgPicture.asset(
                                      width: scaleWidth(context, 129),
                                      height: scaleHeight(context, 166),
                                      'assets/images/profile/Dashboard.svg'),
                                )
                              ])),

                          // USER NAME
                          Positioned(
                            bottom: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                    width: scaleWidth(context, 159),
                                    height: scaleHeight(context, 159),
                                    'assets/images/profile/displayPicture.png'),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('@shanaya_12',
                                            style: GoogleFonts.getFont(
                                                fontFamily2,
                                                fontSize:
                                                    scaleWidth(context, 19),
                                                color: const Color(0xff1a202c),
                                                height: lineHeight(25.2, 19),
                                                fontWeight: FontWeight.w400)),
                                        SvgPicture.asset(
                                            width: scaleWidth(context, 16),
                                            height: scaleHeight(context, 16),
                                            'assets/images/profile/dIcon.svg'),
                                      ],
                                    ),
                                    Text(
                                        'Ajay Kumar Gupta  Engineering  College',
                                        maxLines: 2,
                                        style: GoogleFonts.getFont(fontFamily2,
                                            fontSize: scaleWidth(context, 14),
                                            color: const Color(0xff1a202c),
                                            height: lineHeight(19.2, 14),
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: scaleHeight(context, 5))
                                  ],
                                ),
                                SizedBox(width: scaleWidth(context, 150)),
                                Container(
                                    height: scaleHeight(context, 40),
                                    width: scaleWidth(context, 89),
                                    margin: EdgeInsets.only(
                                        bottom: scaleHeight(context, 10)),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.transparent,
                                        border: Border.all(color: black1)),
                                    alignment: Alignment.center,
                                    child: Text('Edit',
                                        style: GoogleFonts.getFont(fontFamily2,
                                            fontSize: scaleWidth(context, 14),
                                            color: const Color(0xff1a202c),
                                            height: lineHeight(19.2, 14),
                                            fontWeight: FontWeight.w400)))
                              ],
                            ),
                          ),
                        ]),
                        Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(top: scaleHeight(context, 21)),
                          padding: EdgeInsets.symmetric(
                              horizontal: scaleWidth(context, 24),
                              vertical: scaleHeight(context, 24)),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText('About Me',
                                  style: GoogleFonts.getFont(fontFamily2,
                                      fontSize: scaleWidth(context, 14),
                                      color: const Color(0xff1a202c),
                                      height: lineHeight(19.2, 14),
                                      fontWeight: FontWeight.w300)),
                              SizedBox(height: scaleHeight(context, 8)),
                              AutoSizeText(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse porttitor, arcu elementum sollicitudin dapibus, velit dui facilisis nisi,',
                                  style: GoogleFonts.getFont(fontFamily2,
                                      fontSize: scaleWidth(context, 14),
                                      color: const Color(0xff1a202c),
                                      height: lineHeight(19.2, 14),
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: scaleHeight(context, 280),
                          margin:
                              EdgeInsets.only(top: scaleHeight(context, 15)),
                          padding: EdgeInsets.only(
                              left: scaleWidth(context, 24),
                              right: scaleWidth(context, 24),
                              top: scaleHeight(context, 24)),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedInfoTab = 0;
                                      });
                                    },
                                    child: Text('General Information',
                                        style: GoogleFonts.getFont(fontFamily2,
                                            shadows: [
                                              Shadow(
                                                  color: selectedInfoTab == 0
                                                      ? const Color(0xff1a202c)
                                                      : const Color(0xff1a202c)
                                                          .withOpacity(0.4),
                                                  offset: const Offset(0, -5))
                                            ],
                                            color: Colors.transparent,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                selectedInfoTab == 0
                                                    ? const Color(0xff71bec9)
                                                    : Colors.transparent,
                                            decorationThickness: 2.0,
                                            fontWeight: FontWeight.w400,
                                            height: lineHeight(18, 14),
                                            fontSize: scaleWidth(context, 13))),
                                  ),
                                  SizedBox(width: scaleWidth(context, 15)),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedInfoTab = 1;
                                      });
                                    },
                                    child: Text('Educational Qualifications',
                                        style: GoogleFonts.getFont(fontFamily2,
                                            shadows: [
                                              Shadow(
                                                  color: selectedInfoTab == 1
                                                      ? const Color(0xff1a202c)
                                                      : const Color(0xff1a202c)
                                                          .withOpacity(0.4),
                                                  offset: const Offset(0, -5))
                                            ],
                                            color: Colors.transparent,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                selectedInfoTab == 1
                                                    ? const Color(0xff71bec9)
                                                    : Colors.transparent,
                                            decorationThickness: 2.0,
                                            fontWeight: FontWeight.w400,
                                            height: lineHeight(18, 14),
                                            fontSize: scaleWidth(context, 13))),
                                  )
                                ],
                              ),
                              selectedInfoTab == 0
                                  ? const Expanded(child: GeneralInfo())
                                  : const Expanded(
                                      child: Educational(eduType: 'Undergrad'))
                            ],
                          ),
                        ),
                      ],
                    ))),
            Expanded(
                flex: 295,
                child: Container(
                  margin: EdgeInsets.only(top: scaleHeight(context, 29)),
                  decoration: const BoxDecoration(
                      color: Color(0xffE8EBEC),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                ))
          ],
        ));
  }
}
