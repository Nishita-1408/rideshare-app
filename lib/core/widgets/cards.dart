import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.isDark = false,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.gray700 : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.gray600 : AppColors.gray200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class RideCard extends StatelessWidget {
  final String source;
  final String destination;
  final String date;
  final String time;
  final int seats;
  final double price;
  final String status;
  final bool isDark;
  final VoidCallback? onTap;

  const RideCard({
    super.key,
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.seats,
    required this.price,
    this.status = 'upcoming',
    this.isDark = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      isDark: isDark,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status indicator
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: status == 'ongoing'
                      ? AppColors.green500
                      : AppColors.blue500,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                status.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.gray400 : AppColors.gray500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Source
          Text(
            source,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.white : AppColors.gray900,
            ),
          ),

          // Arrow
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Icon(
              Icons.arrow_downward,
              size: 16,
              color: isDark ? AppColors.gray400 : AppColors.gray500,
            ),
          ),

          // Destination
          Text(
            destination,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.white : AppColors.gray900,
            ),
          ),

          const SizedBox(height: 12),
          Divider(color: isDark ? AppColors.gray600 : AppColors.gray100),
          const SizedBox(height: 12),

          // Details row
          Row(
            children: [
              // Time
              _DetailItem(
                icon: Icons.access_time,
                text: time,
                isDark: isDark,
              ),
              const SizedBox(width: 16),

              // Date
              _DetailItem(
                icon: Icons.calendar_today,
                text: date,
                isDark: isDark,
              ),
              const SizedBox(width: 16),

              // Seats
              _DetailItem(
                icon: Icons.people,
                text: '$seats',
                isDark: isDark,
              ),

              const Spacer(),

              // Price
              Text(
                '\$$price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.green400 : AppColors.green600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const _DetailItem({
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
          size: 16,
          color: isDark ? AppColors.gray400 : AppColors.gray500,
        ),
        const SizedBox(width: 4),
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

class UserAvatar extends StatelessWidget {
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final bool showIcon;

  const UserAvatar({
    super.key,
    this.initials,
    this.size = 48,
    this.backgroundColor,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.green600,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: initials != null
            ? Text(
                initials!,
                style: TextStyle(
                  fontSize: size * 0.35,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              )
            : Icon(
                Icons.person,
                size: size * 0.5,
                color: AppColors.white,
              ),
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;
  final bool isDark;

  const RatingBadge({
    super.key,
    required this.rating,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          size: 14,
          color: isDark ? AppColors.yellow400 : AppColors.yellow500,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.gray300 : AppColors.gray600,
          ),
        ),
      ],
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  final bool isDark;

  const StatusBadge({
    super.key,
    required this.status,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final isAccepted = status == 'accepted';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isAccepted
            ? (isDark
                ? AppColors.green600.withOpacity(0.3)
                : AppColors.green50)
            : (isDark
                ? AppColors.yellow500.withOpacity(0.3)
                : AppColors.yellow50),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAccepted
              ? (isDark ? AppColors.green600 : AppColors.green200)
              : (isDark ? AppColors.yellow500 : AppColors.yellow400),
        ),
      ),
      child: Text(
        isAccepted ? '✓ Accepted' : '○ Pending',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isAccepted
              ? (isDark ? AppColors.green400 : AppColors.green700)
              : (isDark ? AppColors.yellow400 : AppColors.yellow700),
        ),
      ),
    );
  }
}
