import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/cards.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Map<String, dynamic> _user = {
    'name': 'Sarah Mitchell',
    'email': 'sarah.mitchell@university.edu',
    'phone': '+1 (555) 123-4567',
    'rating': 4.8,
    'totalTrips': 24,
    'completedTrips': 22,
    'cancelledTrips': 2,
  };

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
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your account',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.gray400 : AppColors.gray500,
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
                  // User Info Card
                  AppCard(
                    isDark: isDark,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Avatar and Name
                        Row(
                          children: [
                            const UserAvatar(size: 80),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _user['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
                                        size: 16,
                                        color: AppColors.yellow500,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${_user['rating']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? AppColors.gray300
                                              : AppColors.gray600,
                                        ),
                                      ),
                                      Text(
                                        ' • ${_user['totalTrips']} trips',
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
                        const SizedBox(height: 16),
                        Divider(
                          color:
                              isDark ? AppColors.gray600 : AppColors.gray200,
                        ),
                        const SizedBox(height: 16),

                        // Contact Info
                        _ContactInfo(
                          icon: Icons.email_outlined,
                          text: _user['email'],
                          isDark: isDark,
                        ),
                        const SizedBox(height: 8),
                        _ContactInfo(
                          icon: Icons.phone_outlined,
                          text: _user['phone'],
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Stats Grid
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          value: _user['completedTrips'].toString(),
                          label: 'Completed',
                          isDark: isDark,
                          valueColor:
                              isDark ? AppColors.green400 : AppColors.green600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          value: _user['cancelledTrips'].toString(),
                          label: 'Cancelled',
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Settings Section
                  AppCard(
                    isDark: isDark,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        // Settings Header
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isDark ? AppColors.gray600 : AppColors.gray50,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'SETTINGS',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  color: isDark
                                      ? AppColors.white
                                      : AppColors.gray900,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Dark Mode Toggle
                        _SettingsItem(
                          icon: Icons.dark_mode_outlined,
                          title: 'Dark Mode',
                          isDark: isDark,
                          trailing: Switch(
                            value: isDark,
                            onChanged: (_) => appProvider.toggleDarkMode(),
                            activeColor: AppColors.green600,
                          ),
                        ),

                        // Preferences
                        _SettingsItem(
                          icon: Icons.settings_outlined,
                          title: 'Preferences',
                          isDark: isDark,
                          onTap: () {},
                        ),

                        // Privacy & Security
                        _SettingsItem(
                          icon: Icons.lock_outlined,
                          title: 'Privacy & Security',
                          isDark: isDark,
                          onTap: () {},
                        ),

                        // Help & Support
                        _SettingsItem(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          isDark: isDark,
                          onTap: () {},
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign Out Button
                  DangerButton(
                    text: 'Sign Out',
                    onPressed: () => appProvider.signOut(),
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

class _ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const _ContactInfo({
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
            color: isDark ? AppColors.gray300 : AppColors.gray700,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;
  final Color? valueColor;

  const _StatCard({
    required this.value,
    required this.label,
    required this.isDark,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      isDark: isDark,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: valueColor ??
                  (isDark ? AppColors.gray300 : AppColors.gray900),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.gray400 : AppColors.gray600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.isDark,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.gray600 : AppColors.gray200,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDark ? AppColors.gray400 : AppColors.gray500,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.white : AppColors.gray900,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                Icons.chevron_right,
                size: 20,
                color: isDark ? AppColors.gray400 : AppColors.gray500,
              ),
          ],
        ),
      ),
    );
  }
}
