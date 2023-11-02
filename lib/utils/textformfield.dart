import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Widget? preIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator? validat;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;

  const TextFormInputField(
      {Key? key,
      required this.controller,
      this.isPass = false,
      this.preIcon,
      this.onChanged,
      this.error,
      this.onTap,
      this.autovalidateMode,
      this.inputFormatters,
      this.validat,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      validator: validat,
      onChanged: onChanged,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          errorText: error,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          hintStyle:
              const TextStyle(color: Color(0xffB3B3B3), fontFamily: "Mulish"),
          errorStyle: const TextStyle(
            color: Color.fromARGB(255, 195, 10, 10),
            backgroundColor: Color.fromARGB(255, 252, 221, 221),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xffC0C0C0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: colorWhite,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xffC0C0C0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: colorWhite,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: colorWhite,
            ),
          ),
          border: InputBorder.none),
      keyboardType: textInputType,
      controller: controller,
      obscureText: isPass,
    );
  }
}
