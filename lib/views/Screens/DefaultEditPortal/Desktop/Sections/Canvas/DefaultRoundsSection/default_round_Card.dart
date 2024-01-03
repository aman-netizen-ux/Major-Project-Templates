import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project__widget_testing/constants/colors.dart';
import 'package:major_project__widget_testing/constants/fontfamily.dart';
import 'package:major_project__widget_testing/constants/radius.dart';
import 'package:major_project__widget_testing/state/hackathonDetailsProvider.dart';
import 'package:major_project__widget_testing/state/rulesAndRoundsProvider.dart';
import 'package:major_project__widget_testing/utils/scaling.dart';
import 'package:major_project__widget_testing/utils/text_lineheight.dart';
import 'package:provider/provider.dart';

// This file was created in order to create the card for the rounds section.
class DefaultRoundCard extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final String title;
  final int index;
  final void Function()? onTap;
  final String enddate;
  final String startDate;
  const DefaultRoundCard(
      {super.key,
      required this.title,
      required this.enddate,
      required this.startDate,
      this.onTap,
      required this.index,
      required this.containerHeight,
      required this.containerWidth});

  @override
  Widget build(BuildContext context) {
    final rulesProvider = Provider.of<RulesProvider>(context);
    final hackathonDetailsProvider =
        Provider.of<HackathonDetailsProvider>(context);
    final roundNameController = TextEditingController();
    final roundStartDateController = TextEditingController();
    final roundEndDateController = TextEditingController();

    if (hackathonDetailsProvider.roundsList[index].name.isNotEmpty) {
      roundNameController.text =
          hackathonDetailsProvider.roundsList[index].name;
    }


    if (hackathonDetailsProvider.roundsList[index].startTimeline.isNotEmpty) {
      roundStartDateController.text = hackathonDetailsProvider.roundsList[index].startTimeline;
    }


    if (hackathonDetailsProvider.roundsList[index].endTimeline.isNotEmpty) {
      roundEndDateController.text = hackathonDetailsProvider.roundsList[index].endTimeline;
    }

    return InkWell(
      hoverColor: Colors.white,
      onTap: onTap,
      child: Container(
          height: defaultEditScaleHeight(containerHeight, 85), //67
          width: double.infinity,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              bottom: defaultEditScaleHeight(containerHeight, 23),
              left: defaultEditScaleWidth(containerWidth, 47),
              right: defaultEditScaleWidth(containerWidth, 26),
              top: defaultEditScaleHeight(containerHeight, 23)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(rad5_3),
              border: Border.all(
                  color: rulesProvider.editSelectedIndex == index
                      ? black1
                      : Colors.transparent),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: defaultEditScaleWidth(containerWidth, 25),
                      ),
                      //Title of the round
                      child: Container(
                        height: defaultEditScaleHeight(containerHeight, 30),
                        width: defaultEditScaleWidth(containerWidth, 150),
                        alignment: Alignment.topLeft,
                        // color: Colors.amberAccent[100],
                        child: TextFormField(
                          //textAlignVertical: TextAlignVertical.top,
                          controller: roundNameController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: 'Round Name',
                            hintStyle: GoogleFonts.getFont(fontFamily2,
                                fontSize:
                                    defaultEditScaleHeight(containerHeight, 20),
                                color: black1,
                                fontWeight: FontWeight.w400,
                                height: lineHeight(22.4, 20)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            counterText: "",
                          ),
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.getFont(fontFamily2,
                              fontSize:
                                  defaultEditScaleHeight(containerHeight, 20),
                              color: black1,
                              fontWeight: FontWeight.w400,
                              height: lineHeight(22.4, 20)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            hackathonDetailsProvider.updateRoundTitle(
                                index, value.toString());
                          },
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      if (hackathonDetailsProvider.roundsList.length != 1) {
                        hackathonDetailsProvider.deleteRound(index, context);
                      }
                    },
                    child: Container(
                      width: defaultEditScaleWidth(containerWidth, 130),
                      height: defaultEditScaleHeight(containerHeight, 30),
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultEditScaleWidth(containerWidth, 10),
                      ),
                      decoration: const BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_rounded,
                              color: Colors.white,
                              size:
                                  defaultEditScaleHeight(containerHeight, 18)),
                          SizedBox(
                              width: defaultEditScaleWidth(containerWidth, 5)),
                          Text("Remove Round",
                              style: GoogleFonts.getFont(fontFamily2,
                                  fontSize: defaultEditScaleHeight(
                                      containerHeight, 16),
                                  color: Colors.white,
                                  height: lineHeight(12.4, 12),
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              //Timeline i.e Start date and End date of the round
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: defaultEditScaleWidth(containerWidth, 25),
                          right: defaultEditScaleWidth(containerWidth, 15)
                          // bottom: defaultEditScaleHeight(containerHeight, 6)
                          ),
                      child:
                          // Text('$startDate - $enddate',
                          //     style: GoogleFonts.getFont(fontFamily2,
                          //         fontSize: defaultEditScaleHeight(containerHeight, 18),
                          //         color: black1,
                          //         height: lineHeight(2.4, 20),
                          //         fontWeight: FontWeight.w400)),
                          Container(
                        height: defaultEditScaleHeight(containerHeight, 30),
                        width: defaultEditScaleWidth(containerWidth, 110),
                        // color: Colors.deepPurple[100],
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: roundStartDateController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: 'DD/MMM/YYYY',
                            hintStyle: GoogleFonts.getFont(fontFamily2,
                                fontSize:
                                    defaultEditScaleHeight(containerHeight, 20),
                                color: black1,
                                fontWeight: FontWeight.w400,
                                height: lineHeight(22.4, 20)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            counterText: "",
                          ),
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.getFont(fontFamily2,
                              fontSize:
                                  defaultEditScaleHeight(containerHeight, 20),
                              color: black1,
                              fontWeight: FontWeight.w400,
                              height: lineHeight(22.4, 20)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            hackathonDetailsProvider.updateRoundStartDate(
                                index, value.toString());
                          },
                        ),
                      )),
                  // Container(
                  // height: defaultEditScaleHeight(containerHeight, 30),
                  // width: defaultEditScaleWidth(containerWidth, 10),
                  // alignment: Alignment.topLeft,
                  // // color: Colors.amberAccent[100],
                  // child: TextFormField(
                  //   enabled:false,
                  //   textAlign: TextAlign.center,
                  //   //textAlignVertical: TextAlignVertical.top,
                  //   // controller: roundNameController,
                  //   cursorColor: Colors.black,
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.all(0),
                  //     hintText: '-',
                  //     hintStyle: GoogleFonts.getFont(fontFamily2,
                  //         fontSize:
                  //             defaultEditScaleHeight(containerHeight, 20),
                  //         color: black1,
                  //         fontWeight: FontWeight.w400,
                  //         height: lineHeight(22.4, 20)),
                  //     enabledBorder: InputBorder.none,
                  //     focusedBorder: InputBorder.none,
                  //     errorBorder: InputBorder.none,
                  //     disabledBorder: InputBorder.none,
                  //     focusedErrorBorder: InputBorder.none,
                  //     counterText: "",
                  //   ),
                  //   maxLength: 1,
                  //   keyboardType: TextInputType.text,
                  //   style: GoogleFonts.getFont(fontFamily2,
                  //       fontSize: defaultEditScaleHeight(containerHeight, 20),
                  //       color: black1,
                  //       fontWeight: FontWeight.w400,
                  //       height: lineHeight(22.4, 20)),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return '';
                  //     }
                  //     return null;
                  //   },
                  //   // onSaved: (value) {
                  //   //   hackathonDetailsProvider.hackathonName = value.toString();
                  //   // },
                  // ),
                  // ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: defaultEditScaleWidth(containerWidth, 15),
                        // bottom: defaultEditScaleHeight(containerHeight, 6)
                      ),
                      child:
                          // Text('$startDate - $enddate',
                          //     style: GoogleFonts.getFont(fontFamily2,
                          //         fontSize: defaultEditScaleHeight(containerHeight, 18),
                          //         color: black1,
                          //         height: lineHeight(2.4, 20),
                          //         fontWeight: FontWeight.w400)),
                          Container(
                        height: defaultEditScaleHeight(containerHeight, 30),
                        width: defaultEditScaleWidth(containerWidth, 110),
                        // color: Colors.deepPurple[100],
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: roundEndDateController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: 'DD/MMM/YYYY',
                            hintStyle: GoogleFonts.getFont(fontFamily2,
                                fontSize:
                                    defaultEditScaleHeight(containerHeight, 20),
                                color: black1,
                                fontWeight: FontWeight.w400,
                                height: lineHeight(22.4, 20)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            counterText: "",
                          ),
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.getFont(fontFamily2,
                              fontSize:
                                  defaultEditScaleHeight(containerHeight, 20),
                              color: black1,
                              fontWeight: FontWeight.w400,
                              height: lineHeight(22.4, 20)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            hackathonDetailsProvider.updateRoundEndDate(
                                index, value.toString());
                          },
                        ),
                      )),
                ],
              )
            ],
          )),
    );
  }
}
