import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/app_provider.dart';
import 'features/welcome/welcome_screen.dart';
import 'features/auth/sign_up_screen.dart';
import 'features/auth/sign_in_screen.dart';
import 'features/home/home_screen.dart';
import 'features/post_ride/post_ride_screen.dart';
import 'features/requests/requests_screen.dart';
import 'features/cab_services/cab_services_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/ride_details/ride_details_screen.dart';
import 'core/widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return MaterialApp(
            title: 'RideShare',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appProvider.darkMode ? ThemeMode.dark : ThemeMode.light,
            home: const MainNavigator(),
          );
        },
      ),
    );
  }
}

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        final currentScreen = appProvider.currentScreen;
        final isAuthenticated = appProvider.isAuthenticated;

        // Auth screens don't show bottom navigation
        final showAuthScreens = !isAuthenticated &&
            ['welcome', 'signup', 'signin'].contains(currentScreen);

        return Scaffold(
          body: SafeArea(
            child: _buildCurrentScreen(appProvider),
          ),
          bottomNavigationBar:
              isAuthenticated && currentScreen != 'ridedetails'
                  ? const AppBottomNavigation()
                  : null,
        );
      },
    );
  }

  Widget _buildCurrentScreen(AppProvider appProvider) {
    switch (appProvider.currentScreen) {
      case 'welcome':
        return const WelcomeScreen();
      case 'signup':
        return const SignUpScreen();
      case 'signin':
        return const SignInScreen();
      case 'home':
        return const HomeScreen();
      case 'postride':
        return const PostRideScreen();
      case 'requests':
        return const RequestsScreen();
      case 'cabservices':
        return const CabServicesScreen();
      case 'profile':
        return const ProfileScreen();
      case 'ridedetails':
        return const RideDetailsScreen();
      default:
        return const WelcomeScreen();
    }
  }
}
