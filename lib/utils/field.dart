import 'package:sos/export.dart';
import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final String hint;
  final Widget? suffixIcon;
  final String label;
  final bool isPassword;
  final int max;
  final bool enabled;
  final TextInputType keyboardType;
  final String? errorText;
  final TextEditingController controller;
  final void Function()? suffixFunction;
  final void Function(String)? onChanged;
  final int? maxLength;
  const CustomField(
      {Key? key,
      required this.hint,
      required this.label,
      this.errorText,
      this.keyboardType = TextInputType.text,
      required this.controller,
      this.isPassword = false,
      this.max = 1,
      this.suffixFunction,
      this.suffixIcon,
      this.onChanged,
      this.enabled = true,
      this.maxLength,
      validator})
      : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: vali,
      maxLength: widget.maxLength,
      mouseCursor: SystemMouseCursors.basic,
      cursorHeight: 26,
      keyboardType: widget.keyboardType,
      // enabled: widget.enabled,
      style: const TextStyle(color: Colors.black),
      maxLines: widget.max,
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      obscureText: widget.isPassword,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        isDense: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        errorText: widget.errorText,
        labelText: widget.label,
        hintText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: AppColors.fieldBG,
        suffixIcon: widget.suffixIcon != null
            ? InkWell(
                onTap: widget.suffixFunction,
                child: widget.suffixIcon,
              )
            : null,
        // suffix: InkWell(
        //   onTap: widget.suffixFunction,
        //   child: widget.suffixIcon,
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
