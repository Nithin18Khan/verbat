import 'package:verbat/services/providers/otp_providers.dart';

import '../../model/extension/config.dart';

class OTPInputField extends ConsumerStatefulWidget {
  const OTPInputField({super.key});

  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends ConsumerState<OTPInputField> {
  // Controller to manage focus
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    // Dispose of all controllers and focus nodes
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final otpState = ref.watch(otpProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 50,
              height: 50,
              child: Center(
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.all(0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      // Update OTP state in Riverpod
                      final otp = controllers
                          .map((controller) => controller.text)
                          .join();
                      ref.read(otpProvider.notifier).updateOTP(otp);

                      // Move to next input when one digit is typed
                      if (index < 3) {
                        FocusScope.of(context)
                            .requestFocus(focusNodes[index + 1]);
                      } else {
                        // Dismiss keyboard once last digit is typed
                        FocusScope.of(context).unfocus();
                      }
                    }
                  },
                  onTap: () {
                    FocusScope.of(context).requestFocus(focusNodes[index]);
                  },
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
