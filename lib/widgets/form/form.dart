import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CakeForm extends StatefulWidget {
  const CakeForm({super.key, required this.formAction});

  final void Function(
    int oCake,
    int cCake,
    int mCake,
    int sCake,
    BuildContext ctx,
  ) formAction;

  @override
  State<CakeForm> createState() => _CakeFormState();
}

class _CakeFormState extends State<CakeForm> {
  final TextEditingController ogController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  final TextEditingController mcController = TextEditingController();
  final TextEditingController scController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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

    return Form(
        key: _formkey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(inputLabels[index], style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                SizedBox(
                  width: 235,
                  height: 37,
                  child: TextFormField(
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
