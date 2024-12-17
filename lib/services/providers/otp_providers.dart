import 'package:verbat/model/extension/config.dart';

class OTPState {
  final String otp;
  final bool isValid;
  OTPState({required this.otp, required this.isValid});
}

class OTPNotifier extends StateNotifier<OTPState> {
  OTPNotifier() : super(OTPState(otp: '', isValid: false));

  void updateOTP(String otp) {
    state = OTPState(otp: otp, isValid: _validateOTP(otp));
  }

  bool _validateOTP(String otp) {
    return otp == "1234";
  }
}

final otpProvider = StateNotifierProvider<OTPNotifier, OTPState>((ref) {
  return OTPNotifier();
});
