import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/cards.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

  static const Map<String, dynamic> _ride = {
    'id': '1',
    'source': 'Campus West Gate',
    'destination': 'Downtown Plaza',
    'time': '3:00 PM',
    'date': 'Today',
    'seats': 3,
    'price': 12.0,
    'driver': {
      'name': 'Sarah Mitchell',
      'rating': 4.8,
      'trips': 24,
    },
    'participants': [
      {'name': 'Alex Johnson', 'status': 'accepted'},
      {'name': 'Jamie Lee', 'status': 'pending'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isDark = appProvider.darkMode;
    final driver = _ride['driver'] as Map<String, dynamic>;
    final participants = _ride['participants'] as List<Map<String, dynamic>>;

    return Container(
      color: isDark ? AppColors.gray800 : AppColors.white,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            color: isDark ? AppColors.gray900 : AppColors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => appProvider.navigateTo('home'),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: isDark ? AppColors.white : AppColors.gray900,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Ride Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.gray900,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Route Card
                  AppCard(
                    isDark: isDark,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // From
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.green500
                                    : AppColors.green600,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'From',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? AppColors.gray400
                                          : AppColors.gray500,
                                    ),
                                  ),
                                  Text(
                                    _ride['source'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? AppColors.white
                                          : AppColors.gray900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Gradient Line
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: 2,
                          height: 32,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AppColors.green600, AppColors.red600],
                            ),
                          ),
                        ),

                        // To
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.red500
                                    : AppColors.red600,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'To',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? AppColors.gray400
                                          : AppColors.gray500,
                                    ),
                                  ),
                                  Text(
                                    _ride['destination'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? AppColors.white
                                          : AppColors.gray900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        Divider(
                          color:
                              isDark ? AppColors.gray600 : AppColors.gray200,
                        ),
                        const SizedBox(height: 20),

                        // Time, Date, Price
                        Row(
                          children: [
                            _InfoItem(
                              icon: Icons.access_time,
                              text: _ride['time'],
                              isDark: isDark,
                            ),
                            const SizedBox(width: 16),
                            _InfoItem(
                              icon: Icons.calendar_today,
                              text: _ride['date'],
                              isDark: isDark,
                            ),
                            const Spacer(),
                            Text(
                              '\$${_ride['price']}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.green400
                                    : AppColors.green600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Driver Info Card
                  AppCard(
                    isDark: isDark,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DRIVER',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: isDark
                                ? AppColors.gray400
                                : AppColors.gray500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const UserAvatar(size: 56),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driver['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? AppColors.white
                                          : AppColors.gray900,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: AppColors.yellow500,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${driver['rating']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDark
                                              ? AppColors.gray300
                                              : AppColors.gray600,
                                        ),
                                      ),
                                      Text(
                                        ' • ${driver['trips']} trips',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDark
                                              ? AppColors.gray400
                                              : AppColors.gray500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Participants Card
                  AppCard(
                    isDark: isDark,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PASSENGERS (${participants.length}/${_ride['seats']})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: isDark
                                ? AppColors.gray400
                                : AppColors.gray500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...participants.map((participant) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                UserAvatar(
                                  size: 40,
                                  backgroundColor: isDark
                                      ? AppColors.gray600
                                      : AppColors.gray100,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    participant['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? AppColors.white
                                          : AppColors.gray900,
                                    ),
                                  ),
                                ),
                                StatusBadge(
                                  status: participant['status'],
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Contact Driver Button
                  PrimaryButton(
                    text: 'Contact Driver',
                    isDark: isDark,
                    onPressed: () {
                      // Handle contact driver
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const _InfoItem({
    required this.icon,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark ? AppColors.gray400 : AppColors.gray500,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.gray300 : AppColors.gray600,
          ),
        ),
      ],
    );
  }
}
