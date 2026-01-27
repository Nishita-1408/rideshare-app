import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDark;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isDark = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.gray300 : AppColors.gray700,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.white : AppColors.gray900,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? AppColors.gray400 : AppColors.gray400,
            ),
            filled: true,
            fillColor: isDark ? AppColors.gray700 : AppColors.white,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.gray600 : AppColors.gray300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.gray600 : AppColors.gray300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.green500,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.red500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppDropdown<T> extends StatelessWidget {
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final bool isDark;

  const AppDropdown({
    super.key,
    this.label,
    this.value,
    required this.items,
    this.onChanged,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.gray300 : AppColors.gray700,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.gray700 : AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? AppColors.gray600 : AppColors.gray300,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: isDark ? AppColors.gray400 : AppColors.gray500,
              ),
              dropdownColor: isDark ? AppColors.gray700 : AppColors.white,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppColors.white : AppColors.gray900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppDatePicker extends StatelessWidget {
  final String? label;
  final DateTime? value;
  final void Function(DateTime) onChanged;
  final bool isDark;

  const AppDatePicker({
    super.key,
    this.label,
    this.value,
    required this.onChanged,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.gray300 : AppColors.gray700,
            ),
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              onChanged(date);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.gray700 : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.gray600 : AppColors.gray300,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value != null
                        ? '${value!.day}/${value!.month}/${value!.year}'
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 16,
                      color: value != null
                          ? (isDark ? AppColors.white : AppColors.gray900)
                          : (isDark ? AppColors.gray400 : AppColors.gray400),
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: isDark ? AppColors.gray400 : AppColors.gray500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AppTimePicker extends StatelessWidget {
  final String? label;
  final TimeOfDay? value;
  final void Function(TimeOfDay) onChanged;
  final bool isDark;

  const AppTimePicker({
    super.key,
    this.label,
    this.value,
    required this.onChanged,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.gray300 : AppColors.gray700,
            ),
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: value ?? TimeOfDay.now(),
            );
            if (time != null) {
              onChanged(time);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.gray700 : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.gray600 : AppColors.gray300,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value != null ? value!.format(context) : 'Select time',
                    style: TextStyle(
                      fontSize: 16,
                      color: value != null
                          ? (isDark ? AppColors.white : AppColors.gray900)
                          : (isDark ? AppColors.gray400 : AppColors.gray400),
                    ),
                  ),
                ),
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: isDark ? AppColors.gray400 : AppColors.gray500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
