import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CakeForm extends StatefulWidget {
  const CakeForm({super.key, required this.formAction});

  final void Function(
    int oCake,
    int cCake,
    int mCake,
    int sCake,
    Map<String, String>? specialCake,
    BuildContext ctx,
  ) formAction;

  @override
  State<CakeForm> createState() => _CakeFormState();
}

List<Map<String, String>> cakeList = [
  {'Hojicha': 'hjCake'},
  {'Very Berry': 'vbCake'},
  {'Honey': 'hyCake'},
  {'Yuzu': 'yzCake'},
];

class _CakeFormState extends State<CakeForm> {
  final TextEditingController ogController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  final TextEditingController mcController = TextEditingController();
  final TextEditingController scController = TextEditingController();

  Timer? _debounce;
  final Duration _debounceDuration = Duration(milliseconds: 500);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Map<String, String>? dropdownValue;

  @override
  void dispose() {
    ogController.dispose();
    ccController.dispose();
    mcController.dispose();
    scController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> inputLabels = [
      'Original Cake',
      'Chocolate Cake',
      'Matcha Cake',
      'Special Cake'
    ];

    final List<TextEditingController> textController = [
      ogController,
      ccController,
      mcController,
      scController
    ];

    final double screenWidth = MediaQuery.of(context).size.width;
    final double inputWidth = screenWidth / 4 - 46;

    bool sbmtPress() {
      final isValid = _formkey.currentState!.validate();
      if (isValid) {
        _formkey.currentState!.save();
        widget.formAction(
          int.parse(ogController.text.trim().isEmpty
              ? '0'
              : ogController.text.trim()),
          int.parse(ccController.text.trim().isEmpty
              ? '0'
              : ccController.text.trim()),
          int.parse(mcController.text.trim().isEmpty
              ? '0'
              : mcController.text.trim()),
          int.parse(scController.text.trim().isEmpty
              ? '0'
              : scController.text.trim()),
          dropdownValue,
          context,
        );
      }
      return false;
    }

    return Form(
        key: _formkey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                index != 3
                    ? Text(inputLabels[index], style: TextStyle(fontSize: 16))
                    : DropdownButton<Map<String, String>>(
                        value: dropdownValue,
                        isDense: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        underline: dropdownValue == null
                            ? Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              )
                            : null,
                        style: const TextStyle(color: Color(0xFF000000)),
                        onChanged: (Map<String, String>? value) {
                          setState(() {
                            dropdownValue = value!;
                            sbmtPress();
                          });
                        },
                        items: cakeList
                            .map<DropdownMenuItem<Map<String, String>>>((map) {
                          return DropdownMenuItem<Map<String, String>>(
                            value: map,
                            child: Text(map.keys.first),
                          );
                        }).toList(),
                      ),
                SizedBox(height: 5),
                SizedBox(
                  width: inputWidth,
                  height: 37,
                  child: TextFormField(
                    onChanged: (val) {
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(_debounceDuration, () {
                        textController[index].text = val;
                        sbmtPress();
                      });
                    },
                    controller: textController[index],
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
