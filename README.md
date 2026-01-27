# RideShare Flutter App

A Student Ride-Sharing App built with Flutter, converted from the original React/TypeScript application.

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── theme/
│   │   ├── app_colors.dart            # Color palette (emerald, gray, status colors)
│   │   ├── app_theme.dart             # Light & Dark theme configurations
│   │   └── app_text_styles.dart       # Typography styles
│   ├── providers/
│   │   └── app_provider.dart          # State management (navigation, auth, dark mode)
│   └── widgets/
│       ├── bottom_navigation.dart     # Bottom navigation bar
│       ├── buttons.dart               # Primary, Secondary, Danger, Choice buttons
│       ├── cards.dart                 # App cards, Ride cards, User avatars, Badges
│       └── input_fields.dart          # Text fields, Dropdowns, Date/Time pickers
├── features/
│   ├── welcome/
│   │   └── welcome_screen.dart        # Welcome/onboarding screen
│   ├── auth/
│   │   ├── sign_up_screen.dart        # User registration
│   │   └── sign_in_screen.dart        # User login
│   ├── home/
│   │   └── home_screen.dart           # Home with ride search & active trips
│   ├── post_ride/
│   │   └── post_ride_screen.dart      # Post a new ride
│   ├── requests/
│   │   └── requests_screen.dart       # Join requests, Swap requests, Browse swaps
│   ├── cab_services/
│   │   └── cab_services_screen.dart   # List of cab drivers
│   ├── profile/
│   │   └── profile_screen.dart        # User profile & settings
│   └── ride_details/
│       └── ride_details_screen.dart   # Ride detail view
```

## Color Palette

### Primary Colors (Emerald/Green)
- `emerald50`: #ECFDF5
- `emerald100`: #D1FAE5
- `emerald300`: #6EE7B7
- `emerald400`: #34D399
- `emerald500`: #10B981 (Primary)
- `emerald600`: #059669

### Gray Colors
- `gray50`: #F9FAFB
- `gray100`: #F3F4F6
- `gray200`: #E5E7EB
- `gray300`: #D1D5DB
- `gray400`: #9CA3AF
- `gray500`: #6B7280
- `gray600`: #4B5563
- `gray700`: #374151
- `gray800`: #1F2937
- `gray900`: #111827

### Status Colors
- Red: #EF4444 (Error/Danger)
- Yellow: #F59E0B (Warning/Rating)
- Blue: #3B82F6 (Info)

## Features

- ✅ Welcome Screen with feature highlights
- ✅ Sign Up with form validation
- ✅ Sign In with social login options
- ✅ Home Screen with ride search
- ✅ Active trips display
- ✅ Post Ride functionality
- ✅ Join Requests management
- ✅ Swap Requests management
- ✅ Browse Swap Tickets
- ✅ Cab Services directory
- ✅ User Profile with stats
- ✅ Dark Mode toggle
- ✅ Settings menu
- ✅ Ride Details view

## Getting Started

1. Make sure you have Flutter installed
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Dependencies

- `provider`: State management
- `google_fonts`: Custom fonts (optional)
- `flutter_svg`: SVG support (optional)
- `intl`: Date/time formatting
- `url_launcher`: Phone call functionality

## Screens Flow

```
Welcome → Sign Up / Sign In → Home
                                ↓
                    ┌───────────┼───────────┐
                    ↓           ↓           ↓
               Post Ride    Requests    Cab Services
                    ↓           ↓           ↓
                    └───────────┼───────────┘
                                ↓
                            Profile
```

## Dark Mode Support

The app fully supports dark mode with automatic theme switching. Toggle from Profile > Settings > Dark Mode.
