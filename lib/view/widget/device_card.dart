import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verbat/model/extension/assets.dart';

class DeviceCard extends StatefulWidget {
  final String deviceName;
  final VoidCallback onConnectPressed;

  const DeviceCard({
    Key? key,
    required this.deviceName,
    required this.onConnectPressed,
  }) : super(key: key);

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool _isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Replace Icon with SVG
          SvgPicture.asset(
            Svgpath.wifi, // Replace with your SVG asset path
            height: 24, // Adjust size as needed
            width: 24,
            color: Colors.grey, // Optional: Apply color to the SVG
          ),
          const SizedBox(width: 16),
          Text(widget.deviceName),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isConnected = !_isConnected;
              });
              widget.onConnectPressed(); // Call the callback function
            },
            child: Text(
              _isConnected ? 'Disconnect' : 'Connect',
              style: TextStyle(
                color: _isConnected ? Colors.white : Colors.green,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isConnected ? Colors.green : Colors.white,
              side: BorderSide(
                color: _isConnected ? Colors.green : Colors.grey,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
