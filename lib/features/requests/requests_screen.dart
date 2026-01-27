import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/cards.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  String _activeTab = 'join';

  final List<Map<String, dynamic>> _joinRequests = [
    {
      'id': '1',
      'userName': 'Alex Johnson',
      'userRating': 4.8,
      'userTrips': 15,
      'ride': {
        'source': 'Campus West Gate',
        'destination': 'Downtown Plaza',
        'date': 'Today',
        'time': '3:00 PM',
      },
    },
    {
      'id': '2',
      'userName': 'Jamie Lee',
      'userRating': 4.9,
      'userTrips': 22,
      'ride': {
        'source': 'Library',
        'destination': 'Airport',
        'date': 'Tomorrow',
        'time': '6:30 PM',
      },
    },
  ];

  final List<Map<String, dynamic>> _swapRequests = [
    {
      'id': '1',
      'userName': 'Morgan Smith',
      'userRating': 4.7,
      'currentRide': {
        'source': 'Campus West Gate',
        'destination': 'Downtown Plaza',
        'date': 'Today',
        'time': '3:00 PM',
      },
      'proposedRide': {
        'source': 'Campus East Gate',
        'destination': 'Shopping Mall',
        'date': 'Today',
        'time': '4:00 PM',
      },
    },
  ];

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
                  'Requests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your ride requests',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.gray400 : AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.gray700 : AppColors.gray200,
                ),
              ),
            ),
            child: Row(
              children: [
                _TabButton(
                  text: 'Join (${_joinRequests.length})',
                  isActive: _activeTab == 'join',
                  isDark: isDark,
                  onTap: () => setState(() => _activeTab = 'join'),
                ),
                const SizedBox(width: 8),
                _TabButton(
                  text: 'Swaps (${_swapRequests.length})',
                  isActive: _activeTab == 'swap',
                  isDark: isDark,
                  onTap: () => setState(() => _activeTab = 'swap'),
                ),
                const SizedBox(width: 8),
                _TabButton(
                  text: 'Browse',
                  isActive: _activeTab == 'browse',
                  isDark: isDark,
                  onTap: () => setState(() => _activeTab = 'browse'),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _activeTab == 'join'
                  ? _buildJoinRequests(isDark)
                  : _activeTab == 'swap'
                      ? _buildSwapRequests(isDark)
                      : _buildBrowseContent(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinRequests(bool isDark) {
    if (_joinRequests.isEmpty) {
      return _EmptyState(
        title: 'No Join Requests',
        message: "You'll see requests here when people want to join your rides",
        isDark: isDark,
      );
    }

    return Column(
      children: _joinRequests.map((request) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _JoinRequestCard(
            request: request,
            isDark: isDark,
            onApprove: () {
              setState(() {
                _joinRequests.removeWhere((r) => r['id'] == request['id']);
              });
            },
            onReject: () {
              setState(() {
                _joinRequests.removeWhere((r) => r['id'] == request['id']);
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSwapRequests(bool isDark) {
    if (_swapRequests.isEmpty) {
      return _EmptyState(
        title: 'No Swap Requests',
        message: "You'll see swap requests here",
        isDark: isDark,
      );
    }

    return Column(
      children: _swapRequests.map((request) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _SwapRequestCard(
            request: request,
            isDark: isDark,
            onApprove: () {
              setState(() {
                _swapRequests.removeWhere((r) => r['id'] == request['id']);
              });
            },
            onReject: () {
              setState(() {
                _swapRequests.removeWhere((r) => r['id'] == request['id']);
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBrowseContent(bool isDark) {
    return const _SwapTicketsContent();
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.green600
                : (isDark ? AppColors.gray700 : AppColors.gray100),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isActive
                  ? AppColors.white
                  : (isDark ? AppColors.gray300 : AppColors.gray600),
            ),
          ),
        ),
      ),
    );
  }
}

class _JoinRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final bool isDark;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _JoinRequestCard({
    required this.request,
    required this.isDark,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final ride = request['ride'] as Map<String, dynamic>;

    return AppCard(
      isDark: isDark,
      child: Column(
        children: [
          // User Info
          Row(
            children: [
              UserAvatar(
                size: 48,
                backgroundColor: isDark ? AppColors.gray600 : AppColors.gray100,
                showIcon: true,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['userName'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.white : AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RatingBadge(
                          rating: request['userRating'],
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '• ${request['userTrips']} trips',
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
            ],
          ),
          const SizedBox(height: 16),

          // Ride Details
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.gray600 : AppColors.gray50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      size: 16,
                      color: isDark ? AppColors.emerald400 : AppColors.emerald600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ride['source'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.gray200 : AppColors.gray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: isDark ? AppColors.red500 : AppColors.red600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ride['destination'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.gray200 : AppColors.gray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(
                  color: isDark ? AppColors.gray500 : AppColors.gray200,
                ),
                const SizedBox(height: 8),
                Text(
                  '${ride['date']} • ${ride['time']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.gray400 : AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Approve',
                  isDark: isDark,
                  onPressed: onApprove,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SecondaryButton(
                  text: 'Reject',
                  isDark: isDark,
                  onPressed: onReject,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SwapRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final bool isDark;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _SwapRequestCard({
    required this.request,
    required this.isDark,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final currentRide = request['currentRide'] as Map<String, dynamic>;
    final proposedRide = request['proposedRide'] as Map<String, dynamic>;

    return AppCard(
      isDark: isDark,
      child: Column(
        children: [
          // User Info
          Row(
            children: [
              UserAvatar(
                size: 48,
                backgroundColor: isDark ? AppColors.gray600 : AppColors.gray100,
                showIcon: true,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['userName'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.white : AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RatingBadge(
                      rating: request['userRating'],
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Current Ride
          _RideInfoBox(
            label: 'Current Ride',
            source: currentRide['source'],
            destination: currentRide['destination'],
            date: currentRide['date'],
            time: currentRide['time'],
            isDark: isDark,
          ),

          // Swap Arrow
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Icon(
              Icons.swap_vert,
              color: isDark ? AppColors.emerald400 : AppColors.emerald600,
              size: 20,
            ),
          ),

          // Proposed Ride
          _RideInfoBox(
            label: 'Proposed Ride',
            source: proposedRide['source'],
            destination: proposedRide['destination'],
            date: proposedRide['date'],
            time: proposedRide['time'],
            isDark: isDark,
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Approve',
                  isDark: isDark,
                  onPressed: onApprove,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SecondaryButton(
                  text: 'Reject',
                  isDark: isDark,
                  onPressed: onReject,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RideInfoBox extends StatelessWidget {
  final String label;
  final String source;
  final String destination;
  final String date;
  final String time;
  final bool isDark;

  const _RideInfoBox({
    required this.label,
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: isDark ? AppColors.gray400 : AppColors.gray500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.gray600 : AppColors.gray50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$source → $destination',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.gray200 : AppColors.gray700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$date • $time',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.gray400 : AppColors.gray500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final bool isDark;

  const _EmptyState({
    required this.title,
    required this.message,
    required this.isDark,
  });

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
              Icons.description_outlined,
              size: 40,
              color: isDark ? AppColors.gray500 : AppColors.gray400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.gray300 : AppColors.gray700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
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

class _SwapTicketsContent extends StatelessWidget {
  const _SwapTicketsContent();

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final isDark = appProvider.darkMode;

    final swapOffers = [
      {
        'id': '1',
        'owner': {'name': 'Sarah Johnson', 'avatar': 'SJ', 'rating': 4.8},
        'currentTrip': {
          'from': 'San Francisco',
          'to': 'Los Angeles',
          'date': 'Jan 25, 2026',
          'time': '9:00 AM',
          'seats': 2,
        },
        'wantedTrip': {
          'from': 'San Francisco',
          'to': 'Los Angeles',
          'date': 'Jan 27, 2026',
          'time': '2:00 PM',
          'seats': 2,
        },
        'postedDate': '2 days ago',
      },
      {
        'id': '2',
        'owner': {'name': 'Michael Chen', 'avatar': 'MC', 'rating': 4.9},
        'currentTrip': {
          'from': 'Berkeley',
          'to': 'San Diego',
          'date': 'Jan 28, 2026',
          'time': '8:00 AM',
          'seats': 1,
        },
        'wantedTrip': {
          'from': 'Berkeley',
          'to': 'San Diego',
          'date': 'Jan 30, 2026',
          'time': '10:00 AM',
          'seats': 1,
        },
        'postedDate': '5 hours ago',
      },
    ];

    return Column(
      children: swapOffers.map((offer) {
        final owner = offer['owner'] as Map<String, dynamic>;
        final currentTrip = offer['currentTrip'] as Map<String, dynamic>;
        final wantedTrip = offer['wantedTrip'] as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AppCard(
            isDark: isDark,
            child: Column(
              children: [
                // Owner info
                Row(
                  children: [
                    UserAvatar(
                      initials: owner['avatar'],
                      size: 40,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            owner['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.white : AppColors.gray900,
                            ),
                          ),
                          RatingBadge(rating: owner['rating'], isDark: isDark),
                        ],
                      ),
                    ),
                    Text(
                      offer['postedDate'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.gray400 : AppColors.gray500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Current trip
                _SwapTripInfo(
                  label: 'HAS',
                  trip: currentTrip,
                  isDark: isDark,
                ),
                const SizedBox(height: 12),

                // Arrow
                Icon(
                  Icons.swap_vert,
                  color: isDark ? AppColors.emerald400 : AppColors.emerald600,
                ),
                const SizedBox(height: 12),

                // Wanted trip
                _SwapTripInfo(
                  label: 'WANTS',
                  trip: wantedTrip,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                // Request swap button
                PrimaryButton(
                  text: 'Request Swap',
                  isDark: isDark,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Swap request sent! You can track it in the Requests tab.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SwapTripInfo extends StatelessWidget {
  final String label;
  final Map<String, dynamic> trip;
  final bool isDark;

  const _SwapTripInfo({
    required this.label,
    required this.trip,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.gray600 : AppColors.gray50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: isDark ? AppColors.gray400 : AppColors.gray500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${trip['from']} → ${trip['to']}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.white : AppColors.gray900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${trip['date']} at ${trip['time']} • ${trip['seats']} seat(s)',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.gray400 : AppColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
