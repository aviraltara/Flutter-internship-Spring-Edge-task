import 'package:flutter/material.dart';

void main() {
  runApp(FreightRatesApp());
}

class FreightRatesApp extends StatelessWidget {
  const FreightRatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freight Rates',
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      home: FreightRatesScreen(),
    );
  }
}

class FreightRatesScreen extends StatefulWidget {
  const FreightRatesScreen({super.key});

  @override
  _FreightRatesScreenState createState() => _FreightRatesScreenState();
}

class _FreightRatesScreenState extends State<FreightRatesScreen> {
  bool includeNearbyOrigin = false;
  bool includeNearbyDestination = false;
  bool isFCL = true;
  String selectedCommodity = 'Select Commodity';
  String selectedContainerSize = '40\' Standard';
  DateTime? cutOffDate;

  final originController = TextEditingController();
  final destinationController = TextEditingController();
  final noOfBoxesController = TextEditingController();
  final weightController = TextEditingController();

  List<String> commodities = [
    'Select Commodity',
    'Electronics',
    'Furniture',
    'Clothing',
  ];
  List<String> containerSizes = [
    '20\' Standard',
    '40\' Standard',
    '40\' High Cube',
  ];

  Future<void> _selectCutOffDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != cutOffDate) {
      setState(() => cutOffDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 5,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search the best Freight Rates',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    _styledButton(Icons.history, 'History', () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('History clicked')),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildLocationField(
                              'Origin',
                              originController,
                              includeNearbyOrigin,
                              (val) {
                                setState(() => includeNearbyOrigin = val!);
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildLocationField(
                              'Destination',
                              destinationController,
                              includeNearbyDestination,
                              (val) {
                                setState(() => includeNearbyDestination = val!);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCommodity,
                              onChanged: (value) {
                                setState(() => selectedCommodity = value!);
                              },
                              items:
                                  commodities.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Commodity',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectCutOffDate(context),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Cut Off Date',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.blue,
                                  ), // Calendar icon here
                                ),
                                child: Text(
                                  cutOffDate == null
                                      ? 'Select date'
                                      : '${cutOffDate!.day}/${cutOffDate!.month}/${cutOffDate!.year}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Shipment Type:'),
                          SizedBox(width: 16),
                          Checkbox(
                            value: isFCL,
                            onChanged: (value) => setState(() => isFCL = true),
                          ),
                          Text('FCL'),
                          SizedBox(width: 10),
                          Checkbox(
                            value: !isFCL,
                            onChanged: (value) => setState(() => isFCL = false),
                          ),
                          Text('LCL'),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedContainerSize,
                              onChanged: (value) {
                                setState(() => selectedContainerSize = value!);
                              },
                              items:
                                  containerSizes.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Container Size',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: noOfBoxesController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'No of Boxes',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Weight (Kg)',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Container Internal Dimensions:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Length: 39.46 ft'),
                          Text('Width: 7.70 ft'),
                          Text('Height: 7.84 ft'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: _styledButton(Icons.search, 'Search', () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Search clicked')),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _styledButton(IconData icon, String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.blue),
        label: Text(text, style: TextStyle(color: Colors.blue)),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildLocationField(
    String label,
    TextEditingController controller,
    bool checkValue,
    Function(bool?) onCheck,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on, color: Colors.blue),
            border: OutlineInputBorder(),
          ),
        ),
        Row(
          children: [
            Checkbox(value: checkValue, onChanged: onCheck),
            Expanded(child: Text('Include nearby $label ports')),
          ],
        ),
      ],
    );
  }
}
