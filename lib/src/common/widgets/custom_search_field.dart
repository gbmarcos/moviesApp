import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/common/extension.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    Key? key,
    this.onChanged,
    this.maxWidth = 192,
    this.alignment = Alignment.topLeft,
    this.hintText = 'Search',
    required this.controller,
    this.focusNode,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final double maxWidth;
  final AlignmentGeometry alignment;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50)
          ),
          fillColor: Colors.white,filled: true,
          iconColor: Colors.grey.shade600,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 8,
            ),
            child: Icon(
              Icons.search,
              size: 20,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle( fontSize: 14),
          constraints: BoxConstraints(
            maxHeight: 40,
            maxWidth: maxWidth,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 40,
          ),
          isDense: false,
          contentPadding: const EdgeInsets.only(bottom: 3),
        ),
      ),
    );
  }
}
