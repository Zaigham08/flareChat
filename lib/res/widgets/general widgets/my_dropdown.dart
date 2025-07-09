import 'package:flutter/material.dart';

import '../../constants.dart';
import 'my_text.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items;
  final String value, title;
  final Color? borderColor;
  final double? width, titleFontSize, borderRadius;
  final ValueChanged<String?> onChanged;
  final bool isEnabled;

  const MyDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    this.isEnabled = true,
    this.width,
    this.titleFontSize,
    this.borderRadius,
    this.borderColor,
  });

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " ${widget.title}",
          style: TextStyle(
            fontSize: widget.titleFontSize ?? 14,
            color: txtColor, // Adjust the text color
          ),
        ),
        Container(
          height: 50,
          width: widget.width ?? double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 11),
          padding: const EdgeInsets.only(left: 14, right: 16),
          decoration: BoxDecoration(
            color: textFieldColor,
            border: Border.all(color: widget.borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isDense: true,
              value: selectedValue,
              onChanged: widget.isEnabled
                  ? (val) {
                      widget.onChanged(val);
                      setState(() {
                        selectedValue = val!;
                      });
                    }
                  : null,
              iconDisabledColor: Colors.transparent,
              iconEnabledColor: dimColor,
              dropdownColor: textFieldColor,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              items: widget.items.map((name) {
                return DropdownMenuItem<String>(
                  value: name,
                  child: MyText(
                    name,
                    maxLines: 1,
                    color: dimColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
