import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tetsu_prep_plan_maker/model/ingredient/Ingredients.dart';

class PrepTable extends StatefulWidget {
  final List<Map<String, List<int>>> planIngredient;
  final int mads;

  const PrepTable({
    super.key,
    required this.planIngredient,
    required this.mads,
  });

  @override
  State<PrepTable> createState() => _PrepTableState();
}

class _PrepTableState extends State<PrepTable> {
  // Controllers for cheese and butter inputs
  final List<TextEditingController> _cheeseControllers =
      List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> _butterControllers =
      List.generate(5, (_) => TextEditingController());

  // State for 15 checkboxes (3 checkboxes per row for 5 rows)
  final List<List<bool>> _checkboxStates =
      List.generate(5, (_) => List.generate(3, (_) => false));

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    for (var controller in _cheeseControllers) {
      controller.dispose();
    }
    for (var controller in _butterControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    // Map of cake types to their respective controllers
    final Map<String, List<TextEditingController>> controllers = {
      "og": [_cheeseControllers[0], _butterControllers[0]],
      "cc": [_cheeseControllers[1], _butterControllers[1]],
      "mc": [_cheeseControllers[2], _butterControllers[2]],
      "sc": [_cheeseControllers[3], _butterControllers[3]],
    };

    // Assign values from planIngredient to controllers
    for (var entry in widget.planIngredient) {
      final key = entry.keys.first;
      if (controllers.containsKey(key)) {
        controllers[key]![0].text = entry[key]![0].toString(); // Cheese
        controllers[key]![1].text = entry[key]![1].toString(); // Butter
      }
    }

    // Assign mads value to the last butter controller
    _butterControllers[4].text = widget.mads.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2), // Product column
        1: FlexColumnWidth(1), // Cheese
        2: FlexColumnWidth(1), // Butter
        3: FlexColumnWidth(2), // Spacer
        4: FlexColumnWidth(1), // Sugar
        5: FlexColumnWidth(1), // Flour
        6: FlexColumnWidth(1), // Spacer
        7: FlexColumnWidth(1), // Status
      },
      children: [
        _buildHeaderRow(),
        ..._buildTableRows(),
        _buildTotalRow(),
      ],
    );
  }

  // Helper method to build the header row
  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.brown[100]),
      children: [
        _buildHeaderCell("Product"),
        _buildHeaderCell("Cheese"),
        _buildHeaderCell("Butter"),
        const SizedBox(),
        _buildHeaderCell("Sugar"),
        _buildHeaderCell("Flour"),
        const SizedBox(),
        _buildHeaderCell("Status"),
      ],
    );
  }

  // Helper method to build table rows
  List<TableRow> _buildTableRows() {
    final List<String> productNames = [
      "Original Cake",
      "Choco Cake",
      "Match Cake",
      "Special Cake",
      "Madeleine",
    ];

    return List.generate(5, (rowIndex) {
      return TableRow(
        children: [
          _buildTableCell(Text(productNames[rowIndex])),
          if (rowIndex < 4)
            _buildTextField(_cheeseControllers[rowIndex])
          else
            const SizedBox(),
          _buildTextField(_butterControllers[rowIndex]),
          const SizedBox(),
          _buildCheckbox(rowIndex, 0), // Sugar checkbox
          _buildCheckbox(rowIndex, 1), // Flour checkbox
          const SizedBox(),
          _buildCheckbox(rowIndex, 2), // Status checkbox
        ],
      );
    });
  }

  // Helper method to build the total row
  TableRow _buildTotalRow() {
    int totalCheese = _calculateTotal(_cheeseControllers);
    int totalButter = _calculateTotal(_butterControllers);
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
      children: [
        _buildHeaderCell("Total"),
        _buildHeaderCell(totalCheese.toString()), // Total Cheese
        _buildHeaderCell(totalButter.toString()), // Total Butter
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
      ],
    );
  }

  // Helper method to build header cells
  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper method to build table cells
  Widget _buildTableCell(Widget child) {
    return SizedBox(
      height: 35,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 30,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: "0",
            hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.5), width: 1),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build checkboxes
  Widget _buildCheckbox(int rowIndex, int checkboxIndex) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: Checkbox(
            activeColor: Colors.green,
            value: _checkboxStates[rowIndex][checkboxIndex],
            onChanged: (value) {
              setState(() {
                _checkboxStates[rowIndex][checkboxIndex] = value ?? false;
              });
            },
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }

  int _calculateTotal(List<TextEditingController> controllers) {
    return controllers.fold(0, (sum, controller) {
      int value = int.tryParse(controller.text) ?? 0;
      return sum + value;
    });
  }
}
