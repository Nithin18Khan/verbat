import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class SearchResultsTable extends StatefulWidget {
  const SearchResultsTable({super.key});

  @override
  State<SearchResultsTable> createState() => _SearchResultsTableState();
}

class _SearchResultsTableState extends State<SearchResultsTable> {
  List<Map<dynamic, dynamic>> farmerData = [];

  @override
  void initState() {
    super.initState();
    _loadFarmerData();
  }

  // Load saved data from Hive
  Future<void> _loadFarmerData() async {
    final farmerBox = await Hive.openBox('farmer_data');

    // Retrieve the data from Hive
    final savedData = farmerBox.get('farmers', defaultValue: <dynamic>[]);

    // Print the data type and content for debugging
    print('Saved Data: $savedData');
    print('Data Type: ${savedData.runtimeType}');

    // Handle different data types based on the runtime type
    setState(() {
      if (savedData is List) {
        // If it's a list, attempt to cast it properly to List<Map<String, dynamic>>
        farmerData = savedData.map((e) {
          // Convert each dynamic map to a Map<String, dynamic>
          if (e is Map) {
            return Map<String, dynamic>.from(e);
          } else {
            return {}; // Fallback empty map if it's not a map
          }
        }).toList();
      } else {
        // Default case if the data is neither a list nor a map
        farmerData = [];
      }
    });
  }

  // Function to delete the farmer data from Hive and update the UI
  Future<void> _deleteFarmer(int index) async {
    final farmerBox = await Hive.openBox('farmer_data');

    // Remove the item from the local list
    setState(() {
      farmerData.removeAt(index);
    });

    // Update Hive by removing the corresponding farmer
    final savedData = farmerBox.get('farmers', defaultValue: <dynamic>[]);
    if (savedData is List) {
      savedData.removeAt(index); // Remove the farmer at the same index in Hive
      await farmerBox.put(
          'farmers', savedData); // Save the updated data back to Hive
    }
  }

  // Function to edit the farmer data
  Future<void> _editFarmer(int index) async {
    final farmer = farmerData[index];
    final TextEditingController fatherNameController =
        TextEditingController(text: farmer['fatherName']);
    final TextEditingController coopIdController =
        TextEditingController(text: farmer['farmId']);
    final TextEditingController nationalController =
        TextEditingController(text: farmer['nationalId']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Farmer Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fatherNameController,
                decoration: const InputDecoration(
                  labelText: 'Father Name',
                  labelStyle: TextStyle(
                      color: Colors.brown, fontSize: 22), // Green label color
                ),
              ),
              TextField(
                controller: coopIdController,
                decoration: const InputDecoration(
                  labelText: 'Coop ID',
                  labelStyle: TextStyle(
                      color: Colors.brown, fontSize: 22), // Green label color
                ),
              ),
              TextField(
                controller: nationalController,
                decoration: const InputDecoration(
                  labelText: 'National Id',
                  labelStyle: TextStyle(
                      color: Colors.brown, fontSize: 22), // Green label color
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.green), // Green text color for Cancel
              ),
            ),
            TextButton(
              onPressed: () async {
                final updatedFarmer = {
                  'fatherName': fatherNameController.text,
                  'coopId': coopIdController.text,
                  'nationalId': nationalController.text,
                };

                // Update the data in the list
                setState(() {
                  farmerData[index] = updatedFarmer;
                });

                // Update the data in Hive
                final farmerBox = await Hive.openBox('farmer_data');
                final savedData =
                    farmerBox.get('farmers', defaultValue: <dynamic>[]);
                if (savedData is List) {
                  savedData[index] = updatedFarmer;
                  await farmerBox.put('farmers', savedData);
                }

                // Close the dialog after updating
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style:
                    TextStyle(color: Colors.green), // Green text color for Save
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('#')),
        DataColumn(label: Text('National ID')),
        DataColumn(label: Text('Farm ID')),
        DataColumn(label: Text('Farmer Name')),
        DataColumn(label: Text('Action')),
      ],
      rows: List<DataRow>.generate(
        farmerData.length,
        (index) {
          final farmer = farmerData[index];
          final fatherName = farmer['fatherName'] ?? 'N/A';
          final coopId = farmer['coopId'] ?? 'N/A';

          print('Father\'s Name: $fatherName');
          print('Coop ID: $coopId');

          return DataRow(
            cells: [
              DataCell(Text((index + 1).toString())), // Row number
              DataCell(Text(farmer['nationalId'] ?? 'N/A')), // National ID
              DataCell(Text(farmer['farmId'] ?? 'N/A')), // Farm ID
              DataCell(Text(farmer['fatherName'] ?? 'N/A')), // Farmer Name
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _editFarmer(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.visibility, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      _deleteFarmer(index);
                    },
                  ),
                ],
              )),
            ],
          );
        },
      ),
    );
  }
}
