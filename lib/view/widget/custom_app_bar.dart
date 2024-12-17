import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:verbat/model/extension/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isOnline;
  final VoidCallback toggleOnlineStatus;

  CustomAppBar({required this.isOnline, required this.toggleOnlineStatus});

  @override
  Size get preferredSize {
    // Set the height for the PreferredSizeWidget
    return const Size.fromHeight(120);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final safeAreaPadding = mediaQuery.padding.top;
    final appBarHeight =
        safeAreaPadding + (mediaQuery.size.width < 600 ? 80 : 120);

    return Container(
      height: appBarHeight,
      width: double.infinity,
      child: Stack(
        children: [
          // SVG image filling the entire AppBar, including the SafeArea
          Positioned.fill(
            child: SvgPicture.asset(
              Svgpath.appBar, // Replace with your SVG asset
              fit: BoxFit.cover,
            ),
          ),
          // Menu button (left)
          Positioned(
            left: 16,
            top: safeAreaPadding,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
          // Right-side icons (online and map)
          Positioned(
            right: 16,
            top: safeAreaPadding + 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Online Icon with Text/Tooltip
                GestureDetector(
                  onTap: toggleOnlineStatus,
                  child: Row(
                    children: [
                      isOnline
                          ? SvgPicture.asset(
                              Svgpath.ellipse,
                              height: 40,
                              width: 40,
                            )
                          : SvgPicture.asset(
                              Svgpath.redellipse,
                              height: 40,
                              width: 40,
                            ),
                      const SizedBox(width: 8),
                      Text(
                        isOnline ? "Online" : "Offline",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Figtree',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 22),
                // Kericho Icon with Text/Tooltip
                GestureDetector(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Svgpath.map,
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 8),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
