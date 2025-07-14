import 'package:flutter/material.dart';

import '/app/app.dart';

class GlassTextField extends StatefulWidget {
  final String label;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isPasswordField;

  const GlassTextField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.isPasswordField = false,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText || widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTexts.bodyLarge(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        obscuringCharacter: '*',
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        style: textStyle.copyWith(color: Colors.white),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: textStyle.copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
          suffixIcon: _buildSuffixIcon(),
          floatingLabelStyle: textStyle.copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 16,
            bottom: 12,
            left: 12,
            right: 12,
          ),
          filled: false,
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPasswordField) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.white.withValues(alpha: 0.7),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon != null
        ? Icon(widget.suffixIcon, color: Colors.white.withValues(alpha: 0.7))
        : null;
  }
}