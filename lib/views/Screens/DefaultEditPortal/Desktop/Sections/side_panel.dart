import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:major_project__widget_testing/api/post_default_hackathon.dart';
import 'package:major_project__widget_testing/constants/colors.dart';
import 'package:major_project__widget_testing/constants/radius.dart';
import 'package:major_project__widget_testing/state/hackathonDetailsProvider.dart';
import 'package:major_project__widget_testing/state/rulesAndRoundsProvider.dart';
import 'package:major_project__widget_testing/utils/scaling.dart';
import 'package:major_project__widget_testing/views/Screens/DefaultTemplate/default_template.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/createRegistrationform.dart';
import 'package:provider/provider.dart';

class SidePanel extends StatefulWidget {
  SidePanel({super.key, required this.formKey, this.textinput});

  final GlobalKey<FormState> formKey;
  String? textinput;

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  @override
  Widget build(BuildContext context) {
    final hackathonDetailsProvider =
        Provider.of<HackathonDetailsProvider>(context);

    final rulesProvider = Provider.of<RulesProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleHeight(context, 45)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (widget.formKey.currentState!.validate()) {
                  widget.formKey.currentState!.save();

                  rulesProvider.setSelectedIndex(-1);
                  rulesProvider.setDescriptionWidget(SvgPicture.asset(
                      'assets/images/defaultTemplate/clickme.svg'));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DefaultTemplate(
                              defaultTemplateModel:
                                  hackathonDetailsProvider.hackathonDetails,
                              isEdit: true,
                            )),
                  );

                  // hackathonDetailsProvider.hackathonName=widget.textinput.toString();
                  // Navigator.pushNamed(context, '/defaultTemplate');
                }
              },
              child: const Icon(
                Icons.menu,
                color: Colors.white,
              )),
          Column(
            children: List.generate(6, (index) {
              int selectedSection = 2;
              return SectionButton(
                selectedSection: selectedSection,
                index: index,
              );
            }),
          ),
          InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if (widget.formKey.currentState!.validate()) {
                  widget.formKey.currentState!.save();

                  List<Map<String, dynamic>> rounds =
                      hackathonDetailsProvider.roundsList.map((round) {
                    return {
                      "serial_number":
                          hackathonDetailsProvider.roundsList.indexOf(round) +
                              1,
                      "name": round.name,
                      "description": round.description,
                      "start_timeline": "${round.startTimeline}T00:00:00Z",
                      "end_timeline": "${round.endTimeline}T18:00:00Z"
                    };
                  }).toList();

                  final hackathonId =
                      await CreateHackathon().postSingleHackathon({
                    "hackathon": {
                      "name": hackathonDetailsProvider.hackathonName,
                      "organisation_name": "Gov of India",
                      "mode_of_conduct": hackathonDetailsProvider.modeOfConduct,
                      "deadline": "2024-10-10",
                      "team_size": hackathonDetailsProvider.teamSize,
                      "visible": "Public",
                      "start_date_time":
                          "${hackathonDetailsProvider.startDateTime}T00:00:00Z",
                      "about": hackathonDetailsProvider.about,
                      "brief": hackathonDetailsProvider.brief,
                      "website": "https://req",
                      "fee": hackathonDetailsProvider.fee,
                      "venue": hackathonDetailsProvider.venue,
                      "contact1_name": hackathonDetailsProvider.contact1Name,
                      "contact1_number": int.parse(hackathonDetailsProvider.contact1Number),
                      "contact2_name": hackathonDetailsProvider.contact2Name,
                      "contact2_number": int.parse(hackathonDetailsProvider.contact2Number)
                    },
                    "round": rounds,
                    "fields": [],
                    "containers": []
                  }, context);
                  if (hackathonId.isNotEmpty) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content:
                              const Text('Hackathon created successfully!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegistrationForm(
                                              hackathonId: hackathonId,
                                            )));
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: SvgPicture.asset(
                  'assets/icons/defaultEditPortal/settings.svg'))
        ],
      ),
    );
  }
}

class SectionButton extends StatelessWidget {
  const SectionButton({
    super.key,
    required this.selectedSection,
    required this.index,
  });

  final int selectedSection;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: scaleHeight(context, 15),
      ).copyWith(
        top: index == 0 ? 0 : null, // Remove top margin for the first item
        bottom: index == 5 ? 0 : null, // Remove bottom margin for the last item
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        hoverColor: sectionSelection.withOpacity(0.2),
        splashColor: sectionSelection,
        borderRadius: BorderRadius.circular(rad5_3),
        onTap: () {
          // Add your onTap functionality here
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context, 19),
            vertical: scaleHeight(context, 14),
          ),
          decoration: BoxDecoration(
            color: selectedSection == index ? sectionSelection : null,
            borderRadius: BorderRadius.circular(rad5_3),
          ),
          child: SvgPicture.asset(
              'assets/icons/defaultEditPortal/section_icon.svg'),
        ),
      ),
    );
  }
}
