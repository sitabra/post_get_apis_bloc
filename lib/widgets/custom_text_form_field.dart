import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isDense;
  final String labelText;
  final double? contentPaddingVertical;
  final double? contentPaddingHorizontal;
  final FormFieldValidator<String> validator;
  final AutovalidateMode autoValidateMode;


  const   CustomTextFormField({Key? key,
    required this.controller,
    this.isDense,
    required this.labelText,
    this.contentPaddingVertical,
    this.contentPaddingHorizontal,
    required this.validator,
    required this.autoValidateMode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 30,left: 30,bottom: 2),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextFormField(
            autovalidateMode: autoValidateMode,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.symmetric(vertical: contentPaddingVertical!, horizontal: contentPaddingHorizontal!),
              isDense: isDense,
              labelText: labelText,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0.0),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
