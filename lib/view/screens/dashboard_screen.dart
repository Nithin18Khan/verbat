import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:verbat/model/extension/assets.dart';
import 'package:verbat/model/responsive/layout.dart';
import 'package:verbat/route.dart';
import 'package:verbat/view/screens/registration_screen.dart';
import 'package:verbat/view/widget/app_drawer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool _isOnline = true;
  String _location = "Fetching location...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickLinks(context),
          _buildActionCard(
            context,
            title: 'Farmer Registration',
            iconPath: Svgpath.farmer,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const RegistrationScreen()));
              print('Farmer Registration Card Tapped');
            },
          ),
          _buildActionCard(
            context,
            title: 'Connect Device',
            iconPath: Svgpath.device,
            onTap: () => Navigator.pushNamed(context, Routes.news),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final safeAreaPadding = mediaQuery.padding.top;
    final appBarHeight = safeAreaPadding + (context.isMobile ? 80 : 120);

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: Container(
        height: appBarHeight,
        width: double.infinity,
        child: Stack(
          children: [
            // SVG image filling the entire AppBar, including the SafeArea
            Positioned.fill(
              child: SvgPicture.asset(
                Svgpath.appBar,
                fit: BoxFit.cover, // Ensures it fills the entire area
              ),
            ),
            // Menu button (left)
            // Modify the Positioned widget where you open the drawer
            Positioned(
              left: 16,
              top: safeAreaPadding, // Adjust for SafeArea
              child: Builder(
                // Wrap the GestureDetector inside a Builder
                builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context)
                        .openDrawer(); // Now the context is inside Scaffold
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),

            // Right-side icons (online and map)
            Positioned(
              right: 16,
              top: safeAreaPadding + 40, // Adjust position
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Show "Connect Device" only on non-mobile devices
                  if (!context.isMobile)
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(
                            8.0), // Space inside the rounded rectangle
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                          border: Border.all(
                            color: Colors.white, // White border
                            width: 2.0,
                          ),
                        ),
                        child: SvgPicture.asset(
                          Svgpath.connectDevice,
                          height: 24, // Adjust icon size
                          width: 24,
                        ),
                      ),
                    ),
                  if (!context.isMobile) const SizedBox(width: 22),

                  // Online Icon with Text/Tooltip
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isOnline =
                            !_isOnline; // Toggle between online and offline
                      });
                    },
                    child: Row(
                      children: [
                        // Use a conditional statement to decide the SVG
                        _isOnline
                            ? SvgPicture.asset(
                                Svgpath.ellipse, // Online ellipse SVG file
                                height: 40,
                                width: 40,
                              )
                            : SvgPicture.asset(
                                Svgpath.redellipse, // Offline ellipse SVG file
                                height: 40,
                                width: 40,
                              ),
                        const SizedBox(width: 8),
                        Text(
                          _isOnline ? "Online" : "Offline",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Figtree',
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!context.isMobile) const SizedBox(width: 22),

                  // Kericho Icon with Text/Tooltip
                  GestureDetector(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Svgpath.map,
                          height: 40,
                          width: 40,
                        ),
                        if (!context.isMobile) // Show text only for non-mobile
                          const SizedBox(width: 8),
                        if (!context.isMobile)
                          const Text(
                            "Kericho",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Figtree',
                            ),
                          ),
                      ],
                    ),
                    onTap: _fetchUserLocation,
                  ),

                  SizedBox(height: 20),
                  // Text(_location),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20), // Move up by 20 pixels
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 12.0 : 16.0,
          vertical: context.isMobile ? 10.0 : 16.0,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 4,
                width: 100,
                color: Colors.green,
              ),
            ),
            Row(
              children: [
                Text(
                  'Quick Links',
                  style: TextStyle(
                    fontFamily: 'Schyler',
                    fontSize: context.isMobile ? 18 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                SvgPicture.asset(
                  Svgpath.frontIcon,
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 12.0 : 16.0,
        vertical: context.isMobile ? 12.0 : 16.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      height: 70,
                      width: 70,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: context.isMobile ? 16 : 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: context.isMobile ? 16 : 24,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchUserLocation() async {
    // Request permissions
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permissions granted, fetch the location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _location = "Lat: ${position.latitude}, Long: ${position.longitude}";
      });
    } else if (status.isDenied) {
      // Handle permission denial
      setState(() {
        _location = "Location permission denied";
      });
    } else {
      // Handle other cases like permanent denial or error
      setState(() {
        _location = "Failed to get location";
      });
    }
  }
}
