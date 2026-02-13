import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/input_fields.dart';
import '../../core/widgets/cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _sourceController = TextEditingController();
  final _destinationController = TextEditingController();

  final List<Map<String, dynamic>> _mockActiveTrips = [
    {
      'id': '1',
      'source': 'Campus West Gate',
      'destination': 'Downtown Plaza',
      'date': 'Today',
      'time': '3:00 PM',
      'seats': 3,
      'price': 12.0,
      'status': 'upcoming',
    },
  ];

  @override
  void dispose() {
    _sourceController.dispose();
    _destinationController.dispose();
    super.dispose();
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
                  'Find a Ride',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Where are you heading?',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.gray400 : AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),

          // Search Card
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.gray700 : AppColors.gray50,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Source Input
                  AppTextField(
                    hint: 'From where?',
                    controller: _sourceController,
                    isDark: isDark,
                    prefixIcon: Icon(
                      Icons.my_location,
                      size: 18,
                      color: isDark ? AppColors.gray400 : AppColors.gray500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Destination Input
                  AppTextField(
                    hint: 'Where to?',
                    controller: _destinationController,
                    isDark: isDark,
                    prefixIcon: Icon(
                      Icons.location_on,
                      size: 18,
                      color: isDark ? AppColors.gray400 : AppColors.gray500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search Button
                  PrimaryButton(
                    text: 'Search Rides',
                    isDark: isDark,
                    onPressed: () {
                      // Handle search
                    },
                  ),
                ],
              ),
            ),
          ),

          // Active Trips Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Trips',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.white : AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Trips List
                  Expanded(
                    child: _mockActiveTrips.isNotEmpty
                        ? ListView.builder(
                            itemCount: _mockActiveTrips.length,
                            itemBuilder: (context, index) {
                              final trip = _mockActiveTrips[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RideCard(
                                  source: trip['source'],
                                  destination: trip['destination'],
                                  date: trip['date'],
                                  time: trip['time'],
                                  seats: trip['seats'],
                                  price: trip['price'],
                                  status: trip['status'],
                                  isDark: isDark,
                                  onTap: () => appProvider.navigateTo(
                                    'ridedetails',
                                    rideId: trip['id'],
                                  ),
                                ),
                              );
                            },
                          )
                        : _EmptyState(isDark: isDark),
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

class _EmptyState extends StatelessWidget {
  final bool isDark;

  const _EmptyState({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: isDark ? AppColors.gray700 : AppColors.gray100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_shipping,
              size: 40,
              color: isDark ? AppColors.gray500 : AppColors.gray400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No Active Trips',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.gray300 : AppColors.gray700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Search for rides or post your own!',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.gray500 : AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }
}
