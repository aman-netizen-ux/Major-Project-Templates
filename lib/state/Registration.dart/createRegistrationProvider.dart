import 'package:flutter/material.dart';
import 'package:major_project__widget_testing/api/Registartion/fetchRegistration.dart';
import 'package:major_project__widget_testing/constants/enums.dart';
import 'package:major_project__widget_testing/models/Registration/registration_form_model.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/checkbox_ans.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/dropdown_ans.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/linearScale_field.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/long_ans.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/multipleChoice_field.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/phone_filed.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/rangeSlider_field.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/short_ans.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/slider_field.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/stepper_field.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/tag_field.dart';
import 'package:major_project__widget_testing/views/Screens/CreateRegistrationForm/Desktop/RegField/RegFieldsCollection/toggle_yn_field.dart';

class CreateRegistrationProvider with ChangeNotifier {
  // int _currentIndex = 0;

  // int get currentIndex => _currentIndex;

  // set currentIndex(int index) {
  //   _currentIndex = index;
  //   notifyListeners();
  // }

  // new
  final List<bool> _edit = [];
  List<bool> get edit => _edit;

  void setEdit(bool input) {
    edit.add(input);
    notifyListeners();
  }

  // String tabName
  int _currentIndex = -1;
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  String _currentKey = "";
  String get currentKey => _currentKey;

  set currentKey(String key) {
    _currentKey = key;
    notifyListeners();
  }

  final List<TextEditingController> _tab = [];
  List<TextEditingController> get tab => _tab;
  void setTab(TextEditingController input) {
    tab.add(input);
    notifyListeners();
  }

  final Map<String, List<dynamic>> _tabFields = {
    "General": [
      ShortAnswerFieldModel(
          errorText: "Invalid name",
          hint: "Enter your name registerd using photo id",
          label: "full name",
          required: true,
          serialNumber: 1,
          validation: "String",
          type: FieldTypes.shortAnswer),
      ShortAnswerFieldModel(
          errorText: "Invalid email id",
          hint: "Enter your valid email id",
          label: "Email id ",
          required: true,
          serialNumber: 2,
          validation: "Email",
          type: FieldTypes.shortAnswer),
      ShortAnswerFieldModel(
          errorText: "Invalid college",
          hint: "Enter your valid College",
          label: "College name",
          required: true,
          serialNumber: 3,
          validation: "String",
          type: FieldTypes.shortAnswer),
      DropDownModel(
        serialNumber: 4,
        label: "Gender",
        errorText: "errorText",
        required: true,
        type: FieldTypes.dropdown,
        options: [
          RegistrationOption(text: "Male ", serialNumber: 1),
          RegistrationOption(text: "Female ", serialNumber: 2)
        ],
      ),
      PhoneNumberModel(
          serialNumber: 5,
          label: "Phone Number",
          errorText: "errorText",
          required: true,
          type: FieldTypes.phoneNumber,
          validation: "PhoneNumber",
          hint: "Enter Your 10-digit number")
    ],
    "Team Details": [
      ShortAnswerFieldModel(
          serialNumber: 1,
          label: "Team Name ",
          errorText: "errorText",
          required: true,
          type: FieldTypes.shortAnswer,
          validation: "String",
          hint: "Enter your team name"),
      StepperModel(
          serialNumber: 1,
          label: "Team Member",
          errorText: "errorText",
          required: true,
          type: FieldTypes.stepper,
          max_value: 5,
          min_value: 0)
    ],
  };

  Map<String, List<dynamic>> get tabField => _tabFields;

  void setTabField(String input) {
    _tabFields[input] ??= [];

    notifyListeners();
  }

  final TickerProvider _vsync;
  TabController formcontroller;

  CreateRegistrationProvider(this._vsync)
      : formcontroller = TabController(length: 0, vsync: _vsync) {
    initialize();
  }
  Future<void> initialize() async {
//  isInitialized = true;
    _createTabController();
    notifyListeners();
  }

  // This function is used to create a new tabcontroller
  void _createTabController() {
    formcontroller = TabController(length: _tabFields.length, vsync: _vsync);
    formcontroller.addListener(() {
      if (!formcontroller.indexIsChanging) {
        notifyListeners();
      }
    });
  }

  // Refresh tabs function
  Future<void> refreshTabs() async {
    formcontroller.dispose();
    _createTabController();
    notifyListeners();
  }

  // Add a function to reset editing state for all tabs except the specified index
  void resetEditingState(int currentIndex) {
    List<String> keys = _tabFields.keys.toList();
    for (int i = 0; i < _tabFields.length; i++) {
      _edit[i] = currentIndex != 0 ? false : _edit[i];
    }
    notifyListeners();
  }

  RegistrationFormModel _singleForm = RegistrationFormModel(
      form: FormModel(hackthon: "", numberOfFields: 0),
      fields: [],
      sections: []);

  RegistrationFormModel get singleForm => _singleForm;
  Future<void> getSingleHackathonsList(String id) async {
    final response = await GetRegistratioForm().getRegistratioForm(id);
    if (response != null && response is RegistrationFormModel) {
      _singleForm = response;
      print("if $_singleForm");
    } else {
      _singleForm = RegistrationFormModel(
          form: FormModel(hackthon: "", numberOfFields: 0),
          fields: [],
          sections: []);

      print("else $_singleForm");
    }

    notifyListeners();
  }

  dynamic getField(FieldTypes type, dynamic field) {
    switch (type) {
      case FieldTypes.date:
        return 0;
      case FieldTypes.file:
        return 0;
      case FieldTypes.longAnswer:
        return LongAnsField(
          create: true,
          hint: field.hint,
          error: field.errorText,
          limit: field.wordLimit,
          question: field.label,
          required: field.required,
        );
      case FieldTypes.radio || FieldTypes.yesNo:
        List<RegistrationOption> options =
            field.options.cast<RegistrationOption>();

        List<String> textList = options.map((option) => option.text).toList();
        return MultipleChoiceField(
            question: field.label,
            create: true,
            error: field.errorText,
            options: textList,
            required: field.required);
      case FieldTypes.shortAnswer:
        return ShortAnsField(
            create: true,
            error: field.errorText,
            hint: field.hint,
            question: field.label,
            required: field.required);
      case FieldTypes.stepper:
        return StepperField(
          create: true,
          max: field.max_value,
          min: field.min_value,
          question: field.label,
          required: field.required,
        );
      case FieldTypes.range:
        return RangeSliderField(
          create: true,
          labels: field.labels.keys.toList(),
          required: field.required,
          min: 10,
          max: 20,
          question: field.label,
          error: field.errorText,
        );
      case FieldTypes.tag:
        return TagField(
            question: field.label,
            options: field.options,
            create: true,
            error: field.errorText,
            required: field.required);
      case FieldTypes.linear:
        return LinearScaleField(
            create: true,
            required: field.required,
            labels: field.labels.keys.toList(),
            division: field.labels.length,
            error: field.errorText,
            min: field.labels[field.labels.keys.first],
            max: field.labels[field.labels.keys.last],
            question: field.label);
      case FieldTypes.dropdown:
        List<RegistrationOption> options =
            field.options.cast<RegistrationOption>();

        List<String> textList = options.map((option) => option.text).toList();
        return DropDownField(
          error: field.errorText,
          create: true,
          question: field.label,
          required: field.required,
          options: textList,
        );
      case FieldTypes.checkbox:
        List<RegistrationOption> options =
            field.options.cast<RegistrationOption>();

        List<String> textList = options.map((option) => option.text).toList();
        return CheckBoxField(
            question: field.label,
            create: true,
            error: field.errorText,
            options: textList,
            required: field.required);
      case FieldTypes.toggle:
        return ToogleYNField(
          create: true,
          error: field.errorText,
          question: field.label,
          required: field.required,
        );
      case FieldTypes.phoneNumber:
        return PhoneField(
            question: field.label, create: true, required: field.required);
      case FieldTypes.slider:
        return SliderField(
          create: true,
          min: field.labels[field.labels.keys.first],
          max: field.labels[field.labels.keys.last],
          labels: field.labels.keys.toList(),
          required: field.required,
          question: field.label,
          error: field.errorText,
        );
      default:
        throw Exception('Invalid field type');
    }
  }

  void addField(dynamic type) {
    List<String> keys = _tabFields.keys.toList();
    _tabFields[keys[formcontroller.index]]!.add(type);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  dynamic getFieldModel(FieldTypes type) {
    switch (type) {
      case FieldTypes.shortAnswer:
        return ShortAnswerFieldModel(
            errorText: "Invalid Value",
            hint: "Hint",
            label: "Question",
            required: true,
            serialNumber: 1,
            type: FieldTypes.shortAnswer,
            validation: "String");
      case FieldTypes.longAnswer:
        return LongAnswerFieldModel(
            errorText: "Invalid Value",
            label: "Question",
            hint: "Hint",
            required: true,
            serialNumber: 2,
            type: FieldTypes.longAnswer,
            wordLimit: 500);
      case FieldTypes.radio:
        return RadioFieldModel(
            errorText: "Invalid Value",
            label: "Question",
            options: [
              RegistrationOption(text: "First Option", serialNumber: 1),
              RegistrationOption(text: "Second Options", serialNumber: 2)
            ],
            required: true,
            serialNumber: 1,
            type: FieldTypes.radio);

      case FieldTypes.checkbox:
        return CheckBoxModel(
            errorText: "Invalid Value",
            label: "Question",
            options: [
              RegistrationOption(text: "First Option", serialNumber: 1),
              RegistrationOption(text: "Second Options", serialNumber: 2)
            ],
            required: true,
            serialNumber: 3,
            type: FieldTypes.checkbox);
      case FieldTypes.yesNo:
        return RadioFieldModel(
            serialNumber: 4,
            errorText: "Invalid Value",
            label: "Question",
            options: [
              RegistrationOption(text: "Yes", serialNumber: 1),
              RegistrationOption(text: "No", serialNumber: 2)
            ],
            required: true,
            type: FieldTypes.yesNo);
      case FieldTypes.dropdown:
        return DropDownModel(
            errorText: "Invalid Value",
            label: "Question",
            required: true,
            serialNumber: 4,
            options: [
              RegistrationOption(text: "First Option", serialNumber: 1),
              RegistrationOption(text: "Second Options", serialNumber: 2)
            ],
            type: FieldTypes.dropdown);

      case FieldTypes.file:
        return FieldModel(
            serialNumber: 6,
            errorText: "Invalid Value",
            label: "Question",
            required: true,
            type: FieldTypes.file);
      case FieldTypes.linear:
        return LinearModel(
            errorText: "Invalid Value",
            label: "Question",
            required: true,
            labels: {"options": 4, "option": 5},
            serialNumber: 6,
            type: FieldTypes.linear);
      case FieldTypes.slider:
        return SliderModel(
            serialNumber: 1,
            errorText: "Invalid Value",
            label: "Question",
            required: true,
            type: FieldTypes.slider,
            labels: {"start": 4, "end": 10});

      case FieldTypes.range:
        return RangeModel(
            serialNumber: 4,
            errorText: "Invalid Value",
            label: "Question",
            required: false,
            type: FieldTypes.range,
            labels: {"options": 4, "jjjn": 5});
      case FieldTypes.stepper:
        return StepperModel(
            errorText: "Invalid Value",
            label: "Question",
            max_value: 45,
            min_value: 10,
            required: true,
            serialNumber: 1,
            type: FieldTypes.stepper);
      case FieldTypes.toggle:
        return ToggleModel(
            serialNumber: 3,
            errorText: "Invalid Value",
            label: "Question",
            required: true,
            type: FieldTypes.toggle);

      case FieldTypes.tag:
        return TagModel(
          serialNumber: 1,
          errorText: "Invalid Value",
          label: "Question",
          required: true,
          type: FieldTypes.tag,
          options: ["option1", " options2"],
        );

      case FieldTypes.date:
        return DateFieldModel(
            serialNumber: 2,
            errorText: "Invalid Value",
            label: "Question",
            required: true,
            type: FieldTypes.date,
            minDate: "",
            maxDate: "");

      default:
        throw Exception('Invalid field type');
    }
  }
}
