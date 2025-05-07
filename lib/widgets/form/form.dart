import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CakeForm extends StatefulWidget {
  final void Function(
    int oCake,
    int cCake,
    int mCake,
    int sCake,
    int mads,
    Map<String, String>? specialCake,
    BuildContext ctx,
  ) formAction;

  const CakeForm({
    super.key,
    required this.formAction,
  });

  @override
  State<CakeForm> createState() => CakeFormState();
}

class CakeFormState extends State<CakeForm> {
  final _formKey = GlobalKey<FormState>();
  final _debounceDuration = const Duration(milliseconds: 500);
  Timer? _debounce;

  // Controllers
  final _ogController = TextEditingController();
  final _ccController = TextEditingController();
  final _mcController = TextEditingController();
  final _scController = TextEditingController();
  final _madsController = TextEditingController();

  // Dropdown state
  Map<String, String>? _selectedCake;

  static const _cakeOptions = [
    {'label': 'Original Cake', 'key': 'oCake'},
    {'label': 'Chocolate Cake', 'key': 'cCake'},
    {'label': 'Matcha Cake', 'key': 'mCake'},
  ];

  static const _specialCakes = [
    {'Hojicha': 'hjCake'},
    {'Very Berry': 'vbCake'},
    {'Honey': 'hyCake'},
    {'Yuzu': 'yzCake'},
  ];

  @override
  void dispose() {
    _ogController.dispose();
    _ccController.dispose();
    _mcController.dispose();
    _scController.dispose();
    _madsController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _handleSubmission() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    widget.formAction(
      _parseInput(_ogController.text),
      _parseInput(_ccController.text),
      _parseInput(_mcController.text),
      _parseInput(_scController.text),
      _parseInput(_madsController.text),
      _selectedCake,
      context,
    );
  }

  int _parseInput(String value) => int.tryParse(value.trim()) ?? 0;

  void resetFields() {
    setState(() {
      _ogController.clear();
      _ccController.clear();
      _mcController.clear();
      _scController.clear();
      _madsController.clear();
      _selectedCake = null;
    });
    _handleSubmission();
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4 - 46,
          height: 37,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _inputDecoration,
            onChanged: (value) => _debounceHandler(value, controller),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialCakeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<Map<String, String>>(
          value: _selectedCake,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          underline: _selectedCake == null
              ? Container(height: 2, color: Colors.deepPurpleAccent)
              : null,
          style: const TextStyle(color: Color(0xFF000000)),
          onChanged: (value) => setState(() {
            _selectedCake = value;
            _handleSubmission();
          }),
          items: _specialCakes
              .map<DropdownMenuItem<Map<String, String>>>(
                  (cake) => DropdownMenuItem(
                        value: cake,
                        child: Text(cake.keys.first),
                      ))
              .toList(),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4 - 46,
          height: 37,
          child: TextFormField(
            controller: _scController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _inputDecoration,
            onChanged: (value) => _debounceHandler(value, _scController),
          ),
        ),
      ],
    );
  }

  void _debounceHandler(String value, TextEditingController controller) {
    controller.text = value;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debounceDuration, _handleSubmission);
  }

  static final _inputDecoration = InputDecoration(
    hintText: "0",
    hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
    filled: true,
    fillColor: Colors.white,
    border: const OutlineInputBorder(),
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    enabledBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1),
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ..._cakeOptions.map((cake) => _buildInputField(
                    label: cake['label']!,
                    controller: _getController(cake['key']!),
                  )),
              _buildSpecialCakeDropdown()
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          _buildInputField(label: "Madeleine", controller: _madsController),
        ],
      ),
    );
  }

  TextEditingController _getController(String key) {
    switch (key) {
      case 'oCake':
        return _ogController;
      case 'cCake':
        return _ccController;
      case 'mCake':
        return _mcController;
      default:
        throw Exception('Invalid controller key');
    }
  }
}
