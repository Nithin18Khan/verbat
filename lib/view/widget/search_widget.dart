import 'package:flutter/material.dart';
import 'package:verbat/view/widget/search_table.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color for the input box
                    border: Border.all(
                        color: Colors.black, width: 1), // Black border
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8), // Padding inside the border
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'National ID',
                      labelStyle:
                          TextStyle(color: Colors.black), // Label text color
                      border: InputBorder.none, // Remove default underline
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Farm ID',
                      labelStyle:
                          TextStyle(color: Colors.black), // Label text color
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Farmer Name',
                      labelStyle:
                          TextStyle(color: Colors.black), // Label text color
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Add search logic here
                },
                child: const Text(
                  'Search',
                  selectionColor: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SearchResultsTable(), // Placeholder for results table
        ],
      ),
    );
  }
}
