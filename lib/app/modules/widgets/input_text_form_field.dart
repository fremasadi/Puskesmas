import 'package:flutter/material.dart';

class InputTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isSecureField;
  final bool autoCorrect;
  final String? hint;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validation;
  final double hintTextSize;
  final bool enable;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool isDateField;
  final String? Function(String?)? validator;

  const InputTextFormField({
    super.key,
    required this.controller,
    this.isSecureField = false,
    this.autoCorrect = false,
    this.enable = true,
    this.hint,
    this.validation,
    this.contentPadding,
    this.textInputAction,
    this.hintTextSize = 14,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.keyboardType,
    this.isDateField = false,
    this.validator,
  });

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  bool _passwordVisible = false;

  // Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      widget.controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isSecureField && !_passwordVisible,
      enableSuggestions: !widget.isSecureField,
      autocorrect: widget.autoCorrect,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enable,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      readOnly: widget.isDateField,
      onTap: widget.isDateField
          ? () {
              FocusScope.of(context).requestFocus(FocusNode());
              _selectDate(context);
            }
          : null,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Form ini wajib diisi';
            }
            return null;
          },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: widget.hintTextSize,
        ),
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(16.0),
        suffixIcon: widget.isSecureField
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black87,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : widget.isDateField
                ? const Icon(Icons.calendar_today, color: Colors.black87)
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
