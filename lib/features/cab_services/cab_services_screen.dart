import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cards.dart';

class CabServicesScreen extends StatelessWidget {
  const CabServicesScreen({super.key});

  static const List<Map<String, dynamic>> _mockDrivers = [
    {
      'id': '1',
      'name': 'John Davis',
      'phone': '+1 (555) 234-5678',
      'route': 'Campus ↔ Downtown',
      'priceRange': '\$10 - \$15',
      'rating': 4.9,
      'reviews': 156,
    },
    {
      'id': '2',
      'name': 'Maria Garcia',
      'phone': '+1 (555) 345-6789',
      'route': 'Airport ↔ University',
      'priceRange': '\$20 - \$30',
      'rating': 4.8,
      'reviews': 203,
    },
    {
      'id': '3',
      'name': 'Ahmed Khan',
      'phone': '+1 (555) 456-7890',
      'route': 'City Center ↔ Mall',
      'priceRange': '\$8 - \$12',
      'rating': 4.7,
      'reviews': 98,
    },
  ];

  void _handleCall(BuildContext context, String phone) {
    // In a real app, you would use url_launcher to make a call
    // For now, show a snackbar with the phone number
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $phone...')),
    );
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
                  'Cab Services',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Reliable drivers in your area',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.gray400 : AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),

          // Drivers List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _mockDrivers.length,
              itemBuilder: (context, index) {
                final driver = _mockDrivers[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _DriverCard(
                    driver: driver,
                    isDark: isDark,
                    onCall: () => _handleCall(context, driver['phone']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverCard extends StatelessWidget {
  final Map<String, dynamic> driver;
  final bool isDark;
  final VoidCallback onCall;

  const _DriverCard({
    required this.driver,
    required this.isDark,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      isDark: isDark,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Driver Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.green600,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Name and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.white : AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.green600.withOpacity(0.3)
                                : AppColors.green50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.green600
                                  : AppColors.green200,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: isDark
                                    ? AppColors.emerald400
                                    : AppColors.emerald600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                driver['rating'].toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.green400
                                      : AppColors.green700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${driver['reviews']})',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.gray400 : AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Call Button
              GestureDetector(
                onTap: onCall,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.green600,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.green600.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Route & Price Details
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.gray600 : AppColors.gray50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: isDark ? AppColors.gray400 : AppColors.gray500,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      driver['route'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.gray200 : AppColors.gray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 18,
                      color: isDark ? AppColors.gray400 : AppColors.gray500,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      driver['priceRange'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.gray200 : AppColors.gray700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Phone Number
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.gray600 : AppColors.gray200,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONTACT',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: isDark ? AppColors.gray400 : AppColors.gray500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  driver['phone'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.gray300 : AppColors.gray700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
