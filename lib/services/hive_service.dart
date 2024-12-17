import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:verbat/model/extension/config.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> saveDataToHive(
      BuildContext context, File? selectedFarmerPhoto) async {
    try {
      final farmerBox = Hive.box('farmer_data');
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Failed to save registration. Please try again.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );
      print(error); // Log the error for debugging
    }
  }
}
