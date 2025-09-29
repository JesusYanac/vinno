import 'package:flutter/material.dart';

class AtomInputEmailFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;

  const AtomInputEmailFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AtomInputEmailFormField> createState() => _AtomInputEmailFormFieldState();
}

class _AtomInputEmailFormFieldState extends State<AtomInputEmailFormField> {
  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formFieldKey,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
      ),
      validator: widget.validator,
      onChanged: (value) {
        _formFieldKey.currentState?.didChange(value);
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}
