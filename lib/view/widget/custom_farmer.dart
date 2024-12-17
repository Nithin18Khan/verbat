import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:verbat/model/extension/assets.dart';

class CustomFarmer extends StatelessWidget {
  const CustomFarmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.4, // 40% of screen height
      child: SvgPicture.asset(
        Svgpath.loginArt,
        fit: BoxFit
            .contain, // Ensures the SVG scales while maintaining aspect ratio
      ),
    );
  }
}

// Add a bottom component below the AppBar
class BottomComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Set your desired height
      child: Center(
        child: SvgPicture.asset(Svgpath.logIn), // Display the login SVG
      ),
    );
  }
}
