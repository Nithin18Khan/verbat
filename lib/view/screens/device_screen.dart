import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verbat/model/extension/assets.dart';
import 'package:verbat/view/widget/custom_app_bar.dart';
import 'package:verbat/view/widget/device_card.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  // Online status (initially offline)
  bool isOnline = false;

  // Toggle online/offline status
  void toggleOnlineStatus() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting the screen width to adjust the UI based on screen size
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        isOnline: isOnline,
        toggleOnlineStatus: toggleOnlineStatus,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth < 600
            ? 16.0
            : 32.0), // Adjust padding for smaller and larger screens
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and device SVG icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Connect Device',
                  style: TextStyle(
                    fontFamily: 'Schyler',
                    fontSize: screenWidth < 600
                        ? 24
                        : 28, // Adjust font size based on screen width
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20), // Space between text and SVG
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SvgPicture.asset(
                    Svgpath.device,
                    height: screenWidth < 600
                        ? 60
                        : 75, // Adjust icon size for smaller screens
                    width: screenWidth < 600
                        ? 60
                        : 75, // Adjust icon size for smaller screens
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2), // Minimal space between text and line
            // Green line
            Container(
              height: 4, // Adjust height for the line
              width: 95, // Adjust width based on text length
              color: Colors.green, // Green color for the line
            ),
            SizedBox(
                height: screenWidth < 600
                    ? 20
                    : 40), // Adjust spacing for mobile/tablet

            // Device cards
            DeviceCard(
              deviceName: 'Device 1',
              onConnectPressed: () {
                print('Device 1 Connect Pressed');
              },
            ),
            SizedBox(
                height: screenWidth < 600
                    ? 16
                    : 20), // Adjust spacing for mobile/tablet

            DeviceCard(
              deviceName: 'Device 2',
              onConnectPressed: () {
                print('Device 2 Connect Pressed');
              },
            ),
            SizedBox(height: screenWidth < 600 ? 16 : 20),

            DeviceCard(
              deviceName: 'Device 3',
              onConnectPressed: () {
                print('Device 3 Connect Pressed');
              },
            ),
            SizedBox(height: screenWidth < 600 ? 16 : 20),

            DeviceCard(
              deviceName: 'Device 4',
              onConnectPressed: () {
                print('Device 4 Connect Pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
