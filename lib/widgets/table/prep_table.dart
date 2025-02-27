import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrepTable extends StatefulWidget {
  const PrepTable({super.key});

  @override
  State<PrepTable> createState() => _PrepTableState();
}

class _PrepTableState extends State<PrepTable> {
  final TextEditingController ogCheese = TextEditingController();
  final TextEditingController ogButter = TextEditingController();
  final TextEditingController ccCheese = TextEditingController();
  final TextEditingController ccButter = TextEditingController();
  final TextEditingController mcCheese = TextEditingController();
  final TextEditingController mcButter = TextEditingController();
  final TextEditingController madsButter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> cheeseControllers = [
      ogCheese,
      ccCheese,
      mcCheese,
    ];

    List<TextEditingController> butterControllers = [
      ogButter,
      ccButter,
      mcButter,
      madsButter,
    ];

    return Table(
      columnWidths: {
        0: FlexColumnWidth(2), // Product column wider
        1: FlexColumnWidth(1), // Cheese
        2: FlexColumnWidth(1), // Butter
        3: FlexColumnWidth(2), // Spacer column
        4: FlexColumnWidth(1), // Sugar
        5: FlexColumnWidth(1), // Flour
        6: FlexColumnWidth(1), // Spacer column
        7: FlexColumnWidth(1), // Status
      },
      children: [
        // Header row
        TableRow(
          decoration: BoxDecoration(color: Colors.brown[100]),
          children: [
            headerCell("Product"),
            headerCell("Cheese"),
            headerCell("Butter"),
            SizedBox(),
            headerCell("Sugar"),
            headerCell("Flour"),
            SizedBox(),
            headerCell("Status"),
          ],
        ),

        for (var i = 0;
            i <
                ["Original Cake", "Choco Cake", "Match Cake", "Madeleine"]
                    .length;
            i++)
          TableRow(
            children: [
              tableCell(Text([
                "Original Cake",
                "Choco Cake",
                "Match Cake",
                "Madeleine"
              ][i])),

              i < 3
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 30, // Adjust height as needed
                        child: TextField(
                          onChanged: (val) {},
                          controller: cheeseControllers[i],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle:
                                TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
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
                    )
                  : SizedBox(),

              // Butter
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 30, // Set the desired height
                  child: TextField(
                    onChanged: (val) {},
                    controller:
                        i < 3 ? butterControllers[i] : butterControllers[3],
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
              ),

              SizedBox(),
              Align(alignment: Alignment.centerLeft, child: tableCheckbox()),
              tableCheckbox(),
              SizedBox(),
              tableCheckbox(),
            ],
          ),
        TableRow(
          decoration: BoxDecoration(color: const Color(0xFFFFFFFF)),
          children: [
            headerCell("Total"),
            headerCell("24"),
            headerCell("24"),
            SizedBox(), // Empty spacer column
            SizedBox(), // Leave Sugar column empty
            SizedBox(), // Leave Flour column empty
            SizedBox(), // Leave Status column empty
            SizedBox(),
          ],
        ),
      ],
    );
  }

  // Helper method for header cells
  Widget headerCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // Helper method for table checkboxes
  Widget tableCheckbox() {
    return Padding(
      padding: EdgeInsets.all(8), // Adds spacing inside the cell
      child: Align(
        alignment: Alignment.centerLeft, // Centers checkbox inside the cell
        child: Container(
          width: 20, // Explicit width to prevent stretching
          height: 20, // Explicit height to ensure a compact size
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(5), // Optional rounded corners
            border: Border.all(color: Colors.grey), // Optional border
          ),
          child: Checkbox(
            value: false,
            onChanged: (value) {},
            visualDensity: VisualDensity.compact, // Makes it smaller
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, // Avoids extra padding
          ),
        ),
      ),
    );
  }

  // Helper method for table text cells
  Widget tableCell(Widget child) {
    return SizedBox(
      height: 35,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
