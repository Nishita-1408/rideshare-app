import 'package:flutter/material.dart';

/// Screen types matching the React app navigation
enum AppScreen {
  welcome,
  signup,
  signin,
  home,
  postride,
  requests,
  cabservices,
  profile,
  ridedetails,
}

class AppProvider extends ChangeNotifier {
  AppScreen _currentScreen = AppScreen.welcome;
  bool _darkMode = false;
  String? _selectedRideId;
  bool _isAuthenticated = false;

  // Getters
  String get currentScreen => _currentScreen.name;
  bool get darkMode => _darkMode;
  String? get selectedRideId => _selectedRideId;
  bool get isAuthenticated => _isAuthenticated;

  // Navigation
  void navigateTo(String screen, {String? rideId}) {
    if (rideId != null) {
      _selectedRideId = rideId;
    }
    _currentScreen = AppScreen.values.firstWhere(
      (s) => s.name == screen,
      orElse: () => AppScreen.welcome,
    );
    notifyListeners();
  }

  // Dark mode toggle
  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  // Authentication
  void signUp() {
    _isAuthenticated = true;
    _currentScreen = AppScreen.home;
    notifyListeners();
  }

  void signIn() {
    _isAuthenticated = true;
    _currentScreen = AppScreen.home;
    notifyListeners();
  }

  void signOut() {
    _isAuthenticated = false;
    _currentScreen = AppScreen.welcome;
    notifyListeners();
  }

  // Get bottom navigation index
  int get bottomNavIndex {
    switch (_currentScreen) {
      case AppScreen.home:
        return 0;
      case AppScreen.postride:
        return 1;
      case AppScreen.requests:
        return 2;
      case AppScreen.cabservices:
        return 3;
      case AppScreen.profile:
        return 4;
      default:
        return 0;
    }
  }

  // Set screen from bottom nav index
  void setBottomNavIndex(int index) {
    switch (index) {
      case 0:
        _currentScreen = AppScreen.home;
        break;
      case 1:
        _currentScreen = AppScreen.postride;
        break;
      case 2:
        _currentScreen = AppScreen.requests;
        break;
      case 3:
        _currentScreen = AppScreen.cabservices;
        break;
      case 4:
        _currentScreen = AppScreen.profile;
        break;
    }
    notifyListeners();
  }
}
