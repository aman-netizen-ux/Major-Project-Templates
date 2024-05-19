import 'dart:math' as math;
import 'dart:developer';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:major_project__widget_testing/state/custom_template_providers/child_factory.dart';
import 'package:major_project__widget_testing/utils/customTemplate_widget_keys.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_circle_image.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_column.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_container.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_divider.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_flippable_card.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_icon.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_image.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_pdf_viewer.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_row.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_spacer.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_svg_picture.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_tabbar.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_text.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_timeline.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_vertical_divider.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_video_player.dart';
import 'package:major_project__widget_testing/views/Screens/CustomEditPortal/Desktop/Widgets/custom_wrap.dart';
import 'package:timeline_tile/timeline_tile.dart';

//TODO: clean up the code

class CustomEditPortal extends ChangeNotifier {
  List<Widget> _dynamicWidgets = [const SizedBox()];
  List<Widget> get dynamicWidgets => _dynamicWidgets;

  set dynamicWidgets(List<Widget> widgets) {
    _dynamicWidgets = widgets;
    notifyListeners();
  }

  GlobalKey? _selectedWidgetKey;

  GlobalKey? get selectedWidgetKey => _selectedWidgetKey;

  set selectedWidgetKey(GlobalKey? value) {
    _selectedWidgetKey = value;
    notifyListeners();
  }

  Map<String, dynamic> _jsonObject = {
    "id": 78,
    "key": customColumnKey,
    "children": [],
  };
  Map<String, dynamic> get jsonObject => _jsonObject;

  bool addOrCheckChildByKey(
      String newglobalKey, int id, String globalKey, String type) {
    log('hi globalkey $globalKey');
    // Map<String, dynamic> containerChild = {
    //   newglobalKey.toString(): {
    //     "id": id,
    //     "type": type,
    //     "properties": {"height": 0, "color": '', "width": 0},
    //     "child": [] // Using a list for potential multiple children
    //   }
    // };

    Map<String, dynamic> textChild = {
      newglobalKey.toString(): {
        "id": id,
        "type": type,
        "properties": {},
        "child": [] // Using a list for potential multiple children
      }
    };
    Map<String, dynamic> newChild = {};
    Map<String, dynamic> defaultChild = {};

    Color generateRandomColor() {
      final math.Random random = math.Random();
      // Generate ARGB values
      int a = random.nextInt(256); // Alpha value
      int r = random.nextInt(256); // Red value
      int g = random.nextInt(256); // Green value
      int b = random.nextInt(256); // Blue value

      // Create a color from the ARGB values and return it
      return Color.fromARGB(a, r, g, b);
    }

    // Define an auxiliary function to handle recursion and potentially add a new child
    bool _searchAndAdd(
      dynamic node,
      String key,
      Map<String, dynamic>? childToAdd,
      int depth,
    ) {
      // Determine the height and width based on depth
      int margin = (depth * 10);
      // margin = margin < 0 ? 0 : margin; // Ensure size does not become negative
      log(" Im in search with depth $depth");

      if (globalKey == customColumnKey.toString()) {
        newChild = ChildFactory()
            .createChild(type, newglobalKey.toString(), id, false);

        _jsonObject["children"].add(newChild);
        return true;
      } else if (node is Map) {
        // If the node is a Map and contains the key directly
        log("Im in map");

        if (node.containsKey(key)) {
          // Check if 'child' related to this key is empty

          log("Hellllllllllllllllllo contaqins key : ${node[key]['type']}");
          String parentType = node[key]['type'];
          childToAdd = ChildFactory()
              .createChild(type, newglobalKey.toString(), id, true);

          log("type : $type");
          log(" demn ${node[key]['child']} ");
          log(" ohh $childToAdd   ");

          log(" mad  ${node[key]['child'].isEmpty}  ");

          if (node[key]['child'].isEmpty && childToAdd != null) {
            // The 'child' list is empty, and we have a new child to add
            log("IM here 1");
            node[key]['child'].add(childToAdd);

            return true; // Indicating that a child was added
          } else if ((parentType == "Row" ||
                  parentType == "Column" ||
                  parentType == "Wrap" ||
                  parentType == "Timeline") &&
              node[key]['child'].isNotEmpty &&
              childToAdd != null) {
            log("Plssssssssssssssss rescue me");
            node[key]['child'].add(childToAdd);
            log("Am i rescued");
          }
          log("im here 5");
          return node[key]['child']
              .isEmpty; // Return true if empty, even if no child was added
        } else {
          log(" doesn't contained key");
          // Recursively search each value if the key is not found at this level
          for (var value in node.values) {
            log(" value : $value");
            log("***********");
            if (_searchAndAdd(
              value,
              key,
              childToAdd,
              depth + 1,
            )) {
              log("IM here 2");
              return true; // Indicating that a child was added or found empty
            }
          }
        }
      } else if (node is List) {
        // If the node is a List, iterate and search each element
        log(" im list");
        for (var element in node) {
          log(" elemet: $element");
          if (_searchAndAdd(
            element,
            key,
            childToAdd,
            depth + 1,
          )) {
            log("IM here 3");
            return true; // Indicating that a child was added or found empty
          }
        }
      }
      // Key not found in the current path, or no action was taken
      log("IM here 4");
      return false;
    }

    // Start the search from the top level 'children', attempting to add the new child if conditions are met
    return _searchAndAdd(
      _jsonObject["children"],
      globalKey,
      null,
      0,
    );
  }

  Color stringToColor(String colorString) {
    try {
      // Checking if the string contains '(' and ')'
      if (colorString.contains('(') && colorString.contains(')')) {
        // Extracting the hex color code from the string
        String hexColor = colorString.split('(')[1].split(')')[0];
        // Converting to a Color object
        return Color(int.parse(hexColor));
      } else {
        throw FormatException("Invalid format");
      }
    } catch (e) {
      // Return a default color in case of an error
      return Colors.black; // Default color
    }

    // Extracting the hex color code from the string
  }

  List<Widget> buildWidgetsFromJson(dynamic node) {
    List<Widget> widgets = [];

    // Function to recursively build widgets
    Widget buildWidget(
      dynamic node,
    ) {
      if (!node.containsKey('type')) return SizedBox();

      Widget currentWidget;
      log(node['type']);

      switch (node['type']) {
        case 'Container':
          List<Widget> childWidgets = [];
          if (node.containsKey('child') && node['child'] is List) {
            node['child'].forEach((childNode) {
              for (var entry in childNode.entries) {
                childWidgets.add(buildWidget(
                  entry.value,
                ));
              }
            });
          }
          currentWidget = CustomContainer(
              node: node,
              onTap: () {
                int? index = node['id'];
                final currentKey = customWidgetsGlobalKeysMap[index];
                _selectedWidgetKey = currentKey;
                notifyListeners();
              },
              childWidgets: childWidgets);
          break;
        case 'Text':
          currentWidget = CustomText(
              node: node,
              onTap: () {}); // Example: Set a default text, customize as needed
          break;

        case 'Row':
          List<Widget> childWidgets = [];
          if (node.containsKey('child') && node['child'] is List) {
            node['child'].forEach((childNode) {
              for (var entry in childNode.entries) {
                childWidgets.add(buildWidget(entry.value));
              }
            });
          }
          currentWidget = CustomRow(
              node: node,
              onTap: () {
                int? index = node['id'];
                final currentKey = customWidgetsGlobalKeysMap[index];
                _selectedWidgetKey = currentKey;
                notifyListeners();
              },
              childWidgets: childWidgets);

          break;

        case 'Column':
          List<Widget> childWidgets = [];
          if (node.containsKey('child') && node['child'] is List) {
            node['child'].forEach((childNode) {
              for (var entry in childNode.entries) {
                childWidgets.add(buildWidget(entry.value));
              }
            });
          }
          currentWidget = CustomColumn(
              node: node,
              onTap: () {
                int? index = node['id'];

                final currentKey = customWidgetsGlobalKeysMap[index];
                _selectedWidgetKey = currentKey;
                notifyListeners();
              },
              childWidgets: childWidgets);
          // InkWell(
          //   onTap: () {
          //     int? index = node['id'];

          //     final currentKey = customWidgetsGlobalKeysMap[index];
          //     _selectedWidgetKey = currentKey;
          //     notifyListeners();
          //   },
          //   child: Container(
          //     height: 300,
          //     width: double.infinity,
          //     decoration:
          //         BoxDecoration(border: Border.all(color: Colors.black)),
          //     child: SingleChildScrollView(
          //       // TODO : Hide the scroll bar
          //       scrollDirection: Axis.vertical,
          //       physics: const NeverScrollableScrollPhysics(),
          //       clipBehavior: Clip.hardEdge,
          //       child: Column(
          //         mainAxisAlignment:
          //             MainAxisAlignment.start, // Customize as needed
          //         crossAxisAlignment:
          //             CrossAxisAlignment.start, // Customize as needed
          //         children: childWidgets,
          //       ),
          //     ),
          //   ),
          // );
          break;
//TODO: divider is not visible when it is the direct child of any row we add

        case "Divider":
          currentWidget = CustomDivider(node: node, onTap: () {});
          // InkWell(
          //     onTap: () {
          //       log("divideddddddddddd");
          //     },
          //     child: const Divider(
          //       color: Colors.grey,
          //       thickness: 1,
          //     )); // Example: Set a default text, customize as needed
          break;
//TODO: vertical divider is not visible when it is the direct child of default column
        case "VerticalDivider":
          currentWidget = CustomVerticalDivider(node: node, onTap: () {});
          // InkWell(
          //     onTap: () {
          //       log("verically divideddddddddddd");
          //     },
          //     child: const VerticalDivider(
          //       color: Colors.grey,
          //       thickness: 1,
          //     )); // Example: Set a default text, customize as needed
          break;

        case "Icon":
          currentWidget = CustomIcon(node: node, onTap: () {});
          // InkWell(
          //     onTap: () {
          //       log("Hey icon");
          //     },
          //     child: const Icon(Icons
          //         .forest_outlined)); // Example: Set a default text, customize as needed
          break;
//TODO: what to do with widgets jo wrap k bahaar aa hrhe
//TODO: row inside wrap case
// Vertical divider inside wrap case
        case "Wrap":
          List<Widget> childWidgets = [];
          if (node.containsKey('child') && node['child'] is List) {
            node['child'].forEach((childNode) {
              for (var entry in childNode.entries) {
                childWidgets.add(buildWidget(entry.value));
              }
            });
          }
          currentWidget = CustomWrap(
              node: node,
              onTap: () {
                int? index = node['id'];
                final currentKey = customWidgetsGlobalKeysMap[index];
                _selectedWidgetKey = currentKey;
                notifyListeners();
              },
              childWidgets: childWidgets);
          // InkWell(
          //   onTap: () {
          //     int? index = node['id'];
          //     final currentKey = customWidgetsGlobalKeysMap[index];
          //     _selectedWidgetKey = currentKey;
          //     notifyListeners();
          //   },
          //   child: Container(
          //     height: node['properties']['height'],
          //     width: double.infinity,
          //     decoration:
          //         BoxDecoration(border: Border.all(color: Colors.black)),
          //     child: Wrap(
          //       crossAxisAlignment: WrapCrossAlignment.center,
          //       children: childWidgets,
          //     ),
          //   ),
          // );
          break;
//TODO: spacer has problem(problem with row , column, wrap so completely)
        case "Spacer":
          currentWidget = CustomSpacer(
              node: node,
              onTap: () {}); // Example: Set a default text, customize as needed
          break;
        case "Image":
          currentWidget = CustomImage(node: node, onTap: () {});
          break;

        case "CircleImage":
          currentWidget = CustomCircleImage(node: node, onTap: () {});

          break;
        case "SvgPicture":
          currentWidget = CustomSvgPicture(node: node, onTap: () {});

          break;
        //TODO: overflow in case of timeline more than round in container,
        //TODO: try timeline in others
        case 'Timeline':
          List<Widget> childWidgets = [];
          if (node.containsKey('child') && node['child'] is List) {
            node['child'].forEach((childNode) {
              for (var entry in childNode.entries) {
                childWidgets.add(buildWidget(entry.value));
              }
            });
          }
          List<Widget> timelineChildren = [];
          if (node.containsKey('child') && node['child'] is List) {
            var children = node['child'];

            int childCount = children.length;
            for (int i = 0; i < childCount; i++) {
              timelineChildren.add(TimelineTile(
                  isFirst: i == 0,
                  isLast: i == childCount - 1,
                  beforeLineStyle: const LineStyle(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  indicatorStyle: const IndicatorStyle(
                    width: 30,
                    color: Colors.blue,
                    padding: EdgeInsets.all(8),
                  ),
                  endChild: buildWidget(children[i].values.first)
                  // Recursively build children widgets
                  ));
            }
          }
          currentWidget = CustomTimeline(
              node: node,
              onTap: () {
                int? index = node['id'];
                final currentKey = customWidgetsGlobalKeysMap[index];
                _selectedWidgetKey = currentKey;
                notifyListeners();
              },
              childWidgets: timelineChildren);
          // InkWell(
          //     onTap: ,
          //     child: Column(children: timelineChildren));
          break;
//TODO: flip conflict with container inkwell
        case 'FlippableCard':
          var frontChild, backChild;
          if (node.containsKey('child') && node['child'] is List) {
            // Since 'child' is a list with two elements for front and back
            var frontData = node['child'][0]
                .values
                .first; // Access the first element's value
            var backData = node['child'][1]
                .values
                .first; // Access the second element's value

            frontChild = buildWidget(frontData);
            backChild = buildWidget(backData);
          }
          currentWidget = CustomFlippableCard(
              node: node, onTap: () {}, front: frontChild, back: backChild);
          // InkWell(
          //   onTap: () {
          //     log("hi");
          //   },
          //   child: FlipCard(
          //       fill: Fill.fillBack,
          //       direction: FlipDirection.HORIZONTAL,
          //       speed: 400,
          //       front: frontChild,
          //       back: backChild
          //       // front: Container(
          //       //   width: 100,
          //       //   height: 100,
          //       //   decoration: BoxDecoration(
          //       //     color: Colors.purple.shade300,
          //       //     borderRadius:const  BorderRadius.only(
          //       //       bottomLeft: Radius.circular(12),
          //       //       bottomRight: Radius.circular(12),
          //       //       topLeft: Radius.circular(12),
          //       //       topRight: Radius.circular(12),
          //       //     ),
          //       //   ),
          //       //   child: const Align(
          //       //     alignment: AlignmentDirectional(0, 0),
          //       //     child: Text(
          //       //       'Front',
          //       //     ),
          //       //   ),
          //       // ),
          //       // back: Container(
          //       //   width: 100,
          //       //   height: 100,
          //       //   decoration: BoxDecoration(
          //       //     color: Colors.purple.shade300,
          //       //     borderRadius: BorderRadius.only(
          //       //       bottomLeft: Radius.circular(12),
          //       //       bottomRight: Radius.circular(12),
          //       //       topLeft: Radius.circular(12),
          //       //       topRight: Radius.circular(12),
          //       //     ),
          //       //   ),
          //       //   child: const Align(
          //       //     alignment: AlignmentDirectional(0, 0),
          //       //     child: Text(
          //       //       'Back',
          //       //     ),
          //       //   ),
          //       // ),
          //       ),
          //); // Example: Set a default text, customize as needed
          break;

        case 'VideoPlayer':
          currentWidget = CustomVideoPlayer(
              node: node,
              onTap: () {}); // Example: Set a default text, customize as needed
          break;

        case 'PDFViewer':
          currentWidget = CustomPDFViewer(
              node: node,
              onTap: () {}); // Example: Set a default text, customize as needed
          break;

        case 'Tabbar':
          currentWidget = CustomTabbar(
              node: node,
              onTap: () {}); // Example: Set a default text, customize as needed
          break;

        default:
          currentWidget = const SizedBox(); // Fallback for unrecognized types
      }

      return currentWidget;
    }

    // Start building widgets from the root 'children'
    if (node.containsKey('children') && node['children'] is List) {
      for (var child in node['children']) {
        for (var entry in child.entries) {
          widgets.add(buildWidget(
            entry.value,
          ));
        }
      }
    }

    return widgets;
  }

  bool addPropertyByKey(
      String globalKey, String propertyType, dynamic property) {
    bool _searchAndAdd(
      dynamic node,
      String key,
      int depth,
    ) {
      print('here starting');

      if (node is Map) {
        print('map is there');
        if (node.containsKey(key)) {
          print('key found');
          print('node ; $node');
          // print('prop. : ${node['key']['properties']}');
          // print('height : ${node['key']['properties']['height']}');
          if (node[key]['properties'] != null) {
            node[key]['properties'][propertyType] = property;
          }

          return true;
        } else {
          log(" doesn't contained key");
          // Recursively search each value if the key is not found at this level
          for (var value in node.values) {
            log(" value : $value");
            log("***********");
            if (_searchAndAdd(
              value,
              key,
              depth + 1,
            )) {
              log("IM here 2");
              return true; // Indicating that a child was added or found empty
            }
          }
        }
      } else if (node is List) {
        print('entered in here');
        for (var element in node) {
          print(" elemet: $element");
          if (_searchAndAdd(
            element,
            key,
            depth + 1,
          )) {
            log("IM here 3");
            return true; // Indicating that a child was added or found empty
          }
        }
      }
      return false;
    }

    return _searchAndAdd(
      _jsonObject["children"],
      globalKey,
      0,
    );
  }
}
