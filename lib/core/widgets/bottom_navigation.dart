import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_colors.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isDark = appProvider.darkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.gray900 : AppColors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.gray700 : AppColors.gray200,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            index: 0,
            currentIndex: appProvider.bottomNavIndex,
            isDark: isDark,
            onTap: () => appProvider.setBottomNavIndex(0),
          ),
          _NavItem(
            icon: Icons.add_circle_outline,
            activeIcon: Icons.add_circle,
            label: 'Post Ride',
            index: 1,
            currentIndex: appProvider.bottomNavIndex,
            isDark: isDark,
            onTap: () => appProvider.setBottomNavIndex(1),
          ),
          _NavItem(
            icon: Icons.mail_outline,
            activeIcon: Icons.mail,
            label: 'Requests',
            index: 2,
            currentIndex: appProvider.bottomNavIndex,
            isDark: isDark,
            onTap: () => appProvider.setBottomNavIndex(2),
          ),
          _NavItem(
            icon: Icons.local_taxi_outlined,
            activeIcon: Icons.local_taxi,
            label: 'Cabs',
            index: 3,
            currentIndex: appProvider.bottomNavIndex,
            isDark: isDark,
            onTap: () => appProvider.setBottomNavIndex(3),
          ),
          _NavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            index: 4,
            currentIndex: appProvider.bottomNavIndex,
            isDark: isDark,
            onTap: () => appProvider.setBottomNavIndex(4),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final bool isDark;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    final activeColor = isDark ? AppColors.emerald300 : AppColors.emerald500;
    final inactiveColor = isDark ? AppColors.gray400 : AppColors.gray500;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? activeColor : inactiveColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
