import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class FarmerDataNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FarmerDataNotifier() : super([]) {
    _loadData();
  }

  // Load data from Hive box
  Future<void> _loadData() async {
    final farmerBox = await Hive.openBox('farmer_data');
    List<Map<String, dynamic>> savedData =
        farmerBox.get('farmers', defaultValue: <Map<String, dynamic>>[]);
    state = savedData;
  }

  // Add farmer data to the list and save to Hive
  Future<void> addFarmer(Map<String, dynamic> farmer) async {
    final farmerBox = await Hive.openBox('farmer_data');
    List<Map<String, dynamic>> updatedData = [...state, farmer];
    await farmerBox.put('farmers', updatedData);
    state = updatedData; // Update the state
  }
}

// Provider for FarmerDataNotifier
final farmerDataProvider =
    StateNotifierProvider<FarmerDataNotifier, List<Map<String, dynamic>>>(
  (ref) => FarmerDataNotifier(),
);
