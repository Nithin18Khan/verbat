import 'package:flutter/material.dart';

class CustomTextInputWithDropdown extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const CustomTextInputWithDropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  _CustomTextInputWithDropdownState createState() =>
      _CustomTextInputWithDropdownState();
}

class _CustomTextInputWithDropdownState
    extends State<CustomTextInputWithDropdown> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: DropdownButton<String>(
          value: _selectedGender,
          hint: const Text(
            'Select',
            style: TextStyle(color: Colors.black),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          iconSize: 30,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: SizedBox(),
          items: ['Male', 'Female', 'Others']
              .map((gender) => DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
              widget.controller.text =
                  value ?? ''; // Update the controller text
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
