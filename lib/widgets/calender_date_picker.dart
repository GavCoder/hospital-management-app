import 'package:flutter/material.dart';

class CalendarDatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const CalendarDatePickerField({super.key, required this.controller, required this.labelText});

  @override
  _CalendarDatePickerFieldState createState() => _CalendarDatePickerFieldState();
}

class _CalendarDatePickerFieldState extends State<CalendarDatePickerField> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 100),
              lastDate: DateTime(DateTime.now().year + 1),
            );
            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
                widget.controller.text = pickedDate.toString();
              });
            }
          },
        ),
      ),
    );
  }
}
