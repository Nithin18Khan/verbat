// Import your other screen

import 'package:verbat/model/extension/assets.dart';
import 'package:verbat/model/responsive/context_ex.dart';
import 'package:verbat/model/responsive/layout.dart';
import 'package:verbat/services/providers/otp_providers.dart';
import 'package:verbat/view/screens/dashboard_screen.dart';
import 'package:verbat/view/widget/custom_farmer.dart';
import 'package:verbat/view/widget/otp_input_field.dart';

import '../../model/extension/config.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final otpState = ref.watch(otpProvider); // Watch OTP state

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Svgpath.iconMenu),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding:
                  context.symmetricPercentPadding(hPercent: 5, vPercent: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CustomFarmer image with responsive height
                  const CustomFarmer(),
                  const SizedBox(height: 30),

                  // OTP Input
                  const OTPInputField(),

                  const SizedBox(height: 30),

                  // Login Button~
                  SizedBox(
                    width: size.width * 0.8, // 80% of screen width
                    height: context.adaptive(
                        50, 60), // Use adaptive height for mobile/tablets
                    child: ElevatedButton(
                      onPressed: () {
                        if (otpState.isValid) {
                          // Navigate to the new screen after 1 second if OTP is valid
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const DashBoardScreen()),
                            );
                          });
                        } else {
                          // Show incorrect OTP message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Incorrect OTP',
                                style: TextStyle(
                                    color: Colors.white), // White text
                              ),
                              backgroundColor: Colors.green, // Green background
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0, // Adjust this value to move it vertically
            left: 5,
            width: 100,
            height: 50, // Adjust this value to move it horizontally
            child: BottomComponent(),
          ),
        ],
      ),
    );
  }
}
