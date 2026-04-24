import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final String labelText;
  final double height;

  const DatePickerField({
    super.key,
    required this.labelText,
    required this.height,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(colorAmbar),
              surface: Color(0xFF141414),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        width: 350,
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? DateFormat('dd/MM/yyyy', 'pt_BR').format(selectedDate!)
                  : widget.labelText,
              style: TextStyle(
                color: selectedDate != null ? Colors.white : Colors.white54,
              ),
            ),
            Icon(Icons.calendar_today, color: Color(colorAmbar), size: 18),
          ],
        ),
      ),
    );
  }
}
