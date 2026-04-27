# 📝 TodoAI

A modern todo application built with **Flutter** and **Riverpod** to demonstrate good state management practices, local database persistence, and clean architecture.

## 🎯 Application Purpose

This application is designed to:

- ✨ Manage task/todo lists easily and efficiently
- 💾 Persistently store todo data on device using Hive database
- 🏗️ Demonstrate the usage of **Riverpod** as a modern state management solution
- 🏛️ Implement **clean architecture** with proper layer separation (model, provider, service, view)
- 📊 Display todo filtering features (all, active, completed)
- 📈 Track todo statistics (total, completed, active)

## ✨ Key Features

- 🔐 **Firebase Authentication** - Secure login and registration with email/password
- ✅ **Add Todo** - Add new todos easily
- ✏️ **Toggle Status** - Mark todos as completed/incomplete
- 🗑️ **Delete Todo** - Remove todos with instant list update
- 🔍 **Filter Todos** - Filter by status (All, Active, Completed)
- 📊 **Statistics** - Display total, active, and completed todo counts
- 💾 **Cloud Sync** - Todos stored in Firestore for cross-device access
- 🤖 **AI-Powered Suggestions** - Get personalized motivation for incomplete todos
- 🎨 **Modern UI** - Clean design with Material Design principles

## 🛠️ Tech Stack & Dependencies

### Production Dependencies

| Package                  | Version | Purpose                                     |
| ------------------------ | ------- | ------------------------------------------- |
| **flutter_riverpod**     | ^2.5.0  | Powerful & reactive state management        |
| **firebase_core**        | ^3.0.0  | Firebase core functionality                 |
| **firebase_auth**        | ^5.0.0  | Firebase authentication (login/register)    |
| **cloud_firestore**      | ^5.0.0  | Cloud database for remote data storage      |
| **hive**                 | ^2.2.3  | NoSQL local database for persistent storage |
| **hive_flutter**         | ^1.1.0  | Hive integration with Flutter               |
| **get_it**               | ^7.6.0  | Service locator for dependency injection    |
| **injectable**           | ^2.2.0  | Practical dependency injection library      |
| **go_router**            | ^17.2.2 | Modern declarative routing for Flutter      |
| **google_generative_ai** | ^0.4.6  | Google's Gemini AI integration              |
| **flutter_dotenv**       | ^5.1.0  | Environment variable management             |
| **shared_preferences**   | ^2.2.3  | Lightweight key-value storage               |
| **cupertino_icons**      | ^1.0.8  | iOS-style icons for Material Design         |

### Development Dependencies

| Package                    | Version | Purpose                                   |
| -------------------------- | ------- | ----------------------------------------- |
| **hive_generator**         | ^2.0.1  | Code generator for Hive type adapters     |
| **injectable_generator**   | ^2.2.0  | Code generator for GetIt dependency setup |
| **build_runner**           | ^2.4.6  | Build system for code generation          |
| **flutter_launcher_icons** | ^0.13.1 | Generate app launcher icons               |
| **flutter_lints**          | ^6.0.0  | Lint rules for best practices             |

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web (experimental)
- ✅ Windows, macOS, Linux (with build support)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.11.4)
- Dart SDK (included with Flutter)

### Setup & Running

```bash
# Clone or open project
cd todo_ai

# Install dependencies
flutter pub get

# Generate code (Hive adapters & GetIt DI)
dart run build_runner build

# Run the app
flutter run
```

## 📂 Project Structure

```
lib/
├── main.dart                 # Entry point & app initialization
├── router.dart              # GoRouter configuration & routes
├── injection.dart           # GetIt service locator setup
├── injection.config.dart    # Auto-generated DI configuration
├── model/
│   ├── todo.dart            # Todo data model with Hive annotations
│   └── todo_filter.dart     # Filter enum (All, Active, Completed)
├── provider/
│   ├── auth_provider.dart   # Riverpod providers for Firebase Auth
│   ├── todo_provider.dart   # Riverpod providers setup
│   └── todo_notifier.dart   # TodoNotifier state management
├── data/
│   ├── repository/          # Repository pattern for data access
│   └── service/             # Service layer for database & authentication
│       ├── firebase_auth_service.dart   # Firebase authentication operations
│       ├── hive_service.dart            # Hive database operations
│       └── gemini_service.dart          # Gemini AI integration
├── utils/
│   └── todo_extension.dart  # Extension methods for todo operations
└── view/
    ├── login_page.dart      # Login page with Firebase Auth
    ├── register_page.dart   # Registration page with Firebase Auth
    ├── home_page.dart       # Main screen with todo list
    ├── add_todo_page.dart   # Page to create new todo
    ├── todo_detail_page.dart # Page to view/edit todo details
    ├── profile_page.dart    # User profile page
    └── widget/
        ├── gemini_suggestion_card.dart  # AI-powered todo suggestion card
        └── [other reusable widgets]
```

## 🏗️ Architecture Pattern

The application uses **Clean Architecture** with proper layer separation and **Dependency Injection**:

```
Presentation Layer (View - Pages & Widgets)
        ↓
Navigation Layer (GoRouter)
        ↓
Provider Layer (State Management with Riverpod)
        ↓
Service Layer (Hive Database Operations)
        ↓
Dependency Injection (GetIt + Injectable)
        ↓
Data Layer (Hive Box Storage)
```

### Data Flow

```
User Interaction (UI)
        ↓
Riverpod Provider
        ↓
TodoNotifier (State Update)
        ↓
HiveService (Persist to DB)
        ↓
UI Rebuild (via Riverpod notifications)
```

## 🔄 State Management with Riverpod

The application uses Riverpod for reactive and efficient state management:

- `todoProvider` - StateNotifierProvider for managing todo list
- `filterProvider` - StateProvider for selected filter
- `filteredTodoProvider` - Provider for computed filtered todos
- `totalTodoProvider` - Provider for total todo count
- `completedTodoProvider` - Provider for completed todo count

### Benefits

✅ **Reactive** - UI automatically updates when state changes  
✅ **Type-safe** - Full type safety for state management  
✅ **Testable** - Easy to test with dependency injection  
✅ **Performance** - Efficient re-renders only where needed

## �️ Navigation with GoRouter

The application uses GoRouter for declarative, type-safe routing with route protection:

- `/login` - **Login Page** - User authentication with Firebase
- `/register` - **Register Page** - New user registration with Firebase
- `/` - **Home Page** - Display todo list with filters (protected route)
- `/add` - **Add Todo Page** - Create new todo (protected route)
- `/todo/:id` - **Todo Detail Page** - View and edit todo details (protected route)
- `/profile` - **Profile Page** - User profile and settings (protected route)

### Routes Configuration

Routes are defined in `router.dart` with GoRouter's powerful navigation API and route protection for authenticated users:

```dart
final goRouter = GoRouter(
  redirect: (context, state) {
    // Redirect to login if not authenticated
    final isLoggedIn = ref.watch(isUserLoggedInProvider);
    if (!isLoggedIn &&
        !state.matchedLocation.startsWith('/login') &&
        !state.matchedLocation.startsWith('/register')) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddTodoPage(),
    ),
    GoRoute(
      path: '/todo/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']!;
        return TodoDetailPage(todoId: todoId);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);
```

## 💉 Dependency Injection with GetIt & Injectable

The app uses **GetIt** as a service locator combined with **Injectable** for automatic code generation:

- **Automatic Registration** - Services registered via `@injectable` annotation
- **Type-safe** - Compile-time safety for dependency resolution
- **Flexible** - Supports singletons, factories, and lazy singletons
- **Generated Code** - Auto-generated configuration in `injection.config.dart`

### Usage

```dart
// Configure dependencies at app startup
await configureDependencies();

// Access services from service locator
final todoService = getIt<TodoService>();
```

Benefits:

✅ **Decoupling** - Services are decoupled from implementation details  
✅ **Testability** - Easy to mock dependencies in tests  
✅ **Maintainability** - Centralized dependency configuration  
✅ **Scalability** - Easy to add new services

## 🔐 Firebase Authentication

The application uses Firebase Authentication for secure user management with email/password authentication:

### Authentication Features

- **User Registration** - Create new account with email and password validation
- **User Login** - Secure login with Firebase Authentication
- **Session Management** - Automatic session persistence and restoration
- **Logout** - Secure logout with session clearing
- **Password Security** - Passwords are securely hashed and managed by Firebase
- **Error Handling** - User-friendly error messages for failed authentication

### Auth Providers (Riverpod)

```dart
// Watch current authenticated user
final currentUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// Check if user is logged in
final isUserLoggedInProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user.maybeWhen(data: (user) => user != null, orElse: () => false);
});

// Handle login, register, and logout
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
```

### Login Flow

1. User navigates to Login page
2. Enters email and password
3. App calls Firebase Authentication
4. If successful, user is authenticated and redirected to Home
5. Session is automatically maintained
6. If failed, error message is displayed

### Registration Flow

1. User navigates to Register page
2. Enters email and password with confirmation
3. App validates input
4. Calls Firebase to create new account
5. On success, user is logged in automatically
6. Redirected to Home page
7. Fallback to Login page if creation fails

### Firebase Setup

To use Firebase authentication:

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable Email/Password authentication method
3. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Place files in appropriate directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`
5. Add Firebase configuration to your `main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

## 🤖 Gemini AI Integration

The app integrates Google's Gemini AI to provide personalized suggestions and motivation for incomplete todos:

- **Smart Suggestions** - AI generates contextual motivation based on todo content
- **Interactive Card** - Beautiful gradient card on home page highlighting random incomplete todo
- **One-Click Navigation** - Tap the card to navigate directly to todo detail page
- **Fallback Support** - Graceful degradation when API is unavailable

### Setup Gemini API

To enable AI features, add your Gemini API key:

```dart
// In gemini_service.dart, replace the placeholder
const apiKey = 'YOUR_ACTUAL_GEMINI_API_KEY_HERE';
```

Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey).

### AI-Powered Features

- **Todo Motivation** - Get personalized encouragement for each incomplete task
- **Smart Prompts** - AI understands todo context and provides relevant suggestions
- **Indonesian Language** - All AI responses are generated in Indonesian

## 💾 Data Storage & Synchronization

The application uses both local and cloud storage for optimal performance and data persistence:

### Hive (Local Database)

Hive is used for local device storage:

✨ **Fast** - Very fast NoSQL local database  
✨ **Type-safe** - Automatic serialization with code generation  
✨ **Lightweight** - Small file size for mobile applications  
✨ **Simple** - Easy API for CRUD operations  
✨ **Offline Support** - Works without internet connection

### Cloud Firestore (Remote Database)

Cloud Firestore is used for cloud synchronization and cross-device access:

☁️ **Real-time Sync** - Changes sync instantly across all devices  
☁️ **Cloud Backup** - Todos backed up in the cloud  
☁️ **Cross-Device** - Access todos from any device  
☁️ **Scalable** - Handles growing data efficiently  
☁️ **Security** - Built-in security rules and authentication

### Storage Architecture

```
┌─────────────────────────────────────┐
│      User (Authenticated)            │
└────────────┬────────────────────────┘
             │
      ┌──────┴──────┐
      │             │
   Online      Offline
      │             │
      ▼             ▼
┌──────────┐   ┌──────────┐
│Firestore │   │   Hive   │
│  (Cloud) │   │  (Local) │
└──────────┘   └──────────┘
      │             │
      └──────┬──────┘
             │
        ▼    ▼
    All Todos
    (Synced)
```

## 📝 Development Notes

- When adding new fields to the Todo model, regenerate Hive adapters with: `dart run build_runner build`
- After changing authentication code, regenerate with: `dart run build_runner build`
- Data is stored in a Hive box named 'todos'
- Cloud data is stored in Firestore collection named 'todos'
- All database operations are async for non-blocking performance
- User todos are organized by user ID in Firestore for security

## 🔧 Troubleshooting

### Firebase Authentication Issues

**Problem**: "Unable to sign up" or "Firebase not initialized"

- **Solution**: Ensure `Firebase.initializeApp()` is called in `main.dart` before running the app
- **Solution**: Verify `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly placed
- **Solution**: Run `flutter clean` and `flutter pub get` to refresh dependencies

**Problem**: "Email already exists"

- **Solution**: This is expected behavior. Use a different email or delete the account from Firebase Console

**Problem**: "Password too weak"

- **Solution**: Firebase requires passwords to be at least 6 characters

### Build Issues

**Problem**: Build fails with "Cannot find plugin"

- **Solution**: Run `flutter pub get`
- **Solution**: Run `dart run build_runner build` to generate code
- **Solution**: Run `flutter clean` and rebuild

**Problem**: iOS build fails

- **Solution**: Run `cd ios && pod install && cd ..`
- **Solution**: Ensure iOS deployment target is 11.0 or higher

### Data Synchronization Issues

**Problem**: Todos not appearing in Firestore

- **Solution**: Verify user is authenticated (check Firebase Auth in Console)
- **Solution**: Check Firestore security rules allow writes
- **Solution**: Verify internet connection is available

**Problem**: Changes not syncing across devices

- **Solution**: Refresh the app after logging in on other device
- **Solution**: Check Firestore read/write permissions in security rules

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Flutter Setup](https://firebase.flutter.dev)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Firebase Console](https://console.firebase.google.com)

## 🎓 Learning Resources

This project is great for learning:

- Firebase Authentication with Flutter
- Cloud Firestore integration
- State Management with Riverpod
- Local Database with Hive
- Clean Architecture in Flutter
- Provider Pattern
- Route Protection and Navigation
- Async/Await handling
- Dependency Injection patterns
