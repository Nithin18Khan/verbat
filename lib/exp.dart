// import 'package:hive/hive.dart';
// import 'package:flutter/material.dart';

// class SearchResultsTable extends StatefulWidget {
//   const SearchResultsTable({super.key});

//   @override
//   State<SearchResultsTable> createState() => _SearchResultsTableState();
// }

// class _SearchResultsTableState extends State<SearchResultsTable> {
//   List<Map<dynamic, dynamic>> farmerData = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFarmerData();
//   }

//   // Load saved data from Hive
//   Future<void> _loadFarmerData() async {
//     final farmerBox = await Hive.openBox('farmer_data');

//     // Retrieve the data from Hive
//     final savedData = farmerBox.get('farmers', defaultValue: <dynamic>[]);

//     // Print the data type and content for debugging
//     print('Saved Data: $savedData');
//     print('Data Type: ${savedData.runtimeType}');

//     // Handle different data types based on the runtime type
//     setState(() {
//       if (savedData is List) {
//         // If it's a list, attempt to cast it properly to List<Map<String, dynamic>>
//         farmerData = savedData.map((e) {
//           // Convert each dynamic map to a Map<String, dynamic>
//           if (e is Map) {
//             return Map<String, dynamic>.from(e);
//           } else {
//             return {}; // Fallback empty map if it's not a map
//           }
//         }).toList();
//       } else {
//         // Default case if the data is neither a list nor a map
//         farmerData = [];
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       columns: const [
//         DataColumn(label: Text('#')),
//         DataColumn(label: Text('National ID')),
//         DataColumn(label: Text('Farm ID')),
//         DataColumn(label: Text('Farmer Name')),
//         DataColumn(label: Text('Action')),
//       ],
//       rows: List<DataRow>.generate(
//         farmerData.length, // Use farmerData length for dynamic rows
//         (index) {
//           final farmer = farmerData[index];
//           final fatherName =
//               farmer['fatherName'] ?? 'N/A'; // Default value if null
//           final coopId = farmer['coopId'] ?? 'N/A'; // Default value if null

//           // Print fatherName and coopId for debugging
//           print('Father\'s Name: $fatherName');
//           print('Coop ID: $coopId');

//           return DataRow(
//             cells: [
//               DataCell(Text((index + 1).toString())), // Row number
//               DataCell(Text(farmer['nationalId'] ?? 'N/A')), // National ID
//               DataCell(Text(farmer['farmId'] ?? 'N/A')), // Farm ID
//               DataCell(Text(farmer['fatherName'] ?? 'N/A')), // Farmer Name
//               DataCell(Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.edit,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {},
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.visibility, color: Colors.black),
//                     onPressed: () {},
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.black),
//                     onPressed: () {},
//                   ),
//                 ],
//               )),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
