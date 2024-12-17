import 'package:hive/hive.dart';

@HiveType(typeId: 0) // Unique ID for Hive Type
class Farmer {
  @HiveField(0)
  final String nationalId;

  @HiveField(1)
  final String farmId;

  @HiveField(2)
  final String fatherName;

  @HiveField(3)
  final String coopId;

  @HiveField(4)
  final String coopName;

  @HiveField(5)
  final String dob;

  @HiveField(6)
  final String gender;

  @HiveField(7)
  final String? farmerPhoto;

  Farmer({
    required this.nationalId,
    required this.farmId,
    required this.fatherName,
    required this.coopId,
    required this.coopName,
    required this.dob,
    required this.gender,
    this.farmerPhoto,
  });
}
