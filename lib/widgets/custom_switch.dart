import 'package:flutter/material.dart';
import 'package:hagglextest/utility/colors.dart';

class CustomSwitch extends StatefulWidget {
  final String? text;
  final bool? isSelected;
  const CustomSwitch({Key? key, this.text, this.isSelected}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Container(
            child: Center(
                child: Text(widget.text!,
                    style: widget.isSelected == true
                        ? TextStyle(fontWeight: FontWeight.w500, fontSize: 12)
                        : TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 10))),
            width: 55,
            height: 35,
            decoration: widget.isSelected == true
                ? BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(30))
                : BoxDecoration()),
        decoration: widget.isSelected == true
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 2))
                  ])
            : BoxDecoration());
  }
}
