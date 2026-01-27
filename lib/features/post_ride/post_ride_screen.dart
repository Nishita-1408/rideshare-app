import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/input_fields.dart';

class PostRideScreen extends StatefulWidget {
  const PostRideScreen({super.key});

  @override
  State<PostRideScreen> createState() => _PostRideScreenState();
}

class _PostRideScreenState extends State<PostRideScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sourceController = TextEditingController();
  final _destinationController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedSeats = 1;
  String _genderPreference = 'any';

  @override
  void dispose() {
    _sourceController.dispose();
    _destinationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission
      context.read<AppProvider>().navigateTo('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isDark = appProvider.darkMode;

    return Container(
      color: isDark ? AppColors.gray800 : AppColors.white,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            color: isDark ? AppColors.gray900 : AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Post a Ride',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Share your journey with others',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.gray400 : AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Source
                    AppTextField(
                      label: 'From',
                      hint: 'Enter pickup location',
                      controller: _sourceController,
                      isDark: isDark,
                      prefixIcon: Icon(
                        Icons.my_location,
                        size: 18,
                        color: isDark ? AppColors.gray400 : AppColors.gray500,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter pickup location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Destination
                    AppTextField(
                      label: 'To',
                      hint: 'Enter destination',
                      controller: _destinationController,
                      isDark: isDark,
                      prefixIcon: Icon(
                        Icons.location_on,
                        size: 18,
                        color: isDark ? AppColors.gray400 : AppColors.gray500,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter destination';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Date and Time
                    Row(
                      children: [
                        Expanded(
                          child: AppDatePicker(
                            label: 'Date',
                            value: _selectedDate,
                            isDark: isDark,
                            onChanged: (date) =>
                                setState(() => _selectedDate = date),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTimePicker(
                            label: 'Time',
                            value: _selectedTime,
                            isDark: isDark,
                            onChanged: (time) =>
                                setState(() => _selectedTime = time),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Seats and Price
                    Row(
                      children: [
                        Expanded(
                          child: AppDropdown<int>(
                            label: 'Available Seats',
                            value: _selectedSeats,
                            isDark: isDark,
                            items: List.generate(
                              6,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text('${index + 1}'),
                              ),
                            ),
                            onChanged: (value) =>
                                setState(() => _selectedSeats = value ?? 1),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            label: 'Price per Seat (\$)',
                            hint: '0',
                            controller: _priceController,
                            isDark: isDark,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter price';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Gender Preference
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Passenger Preference',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.gray300 : AppColors.gray700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ChoiceButton(
                              text: 'Any',
                              isSelected: _genderPreference == 'any',
                              isDark: isDark,
                              onPressed: () =>
                                  setState(() => _genderPreference = 'any'),
                            ),
                            const SizedBox(width: 8),
                            ChoiceButton(
                              text: 'Male',
                              isSelected: _genderPreference == 'male',
                              isDark: isDark,
                              onPressed: () =>
                                  setState(() => _genderPreference = 'male'),
                            ),
                            const SizedBox(width: 8),
                            ChoiceButton(
                              text: 'Female',
                              isSelected: _genderPreference == 'female',
                              isDark: isDark,
                              onPressed: () =>
                                  setState(() => _genderPreference = 'female'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    PrimaryButton(
                      text: 'Post Ride',
                      isDark: isDark,
                      onPressed: _handleSubmit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
