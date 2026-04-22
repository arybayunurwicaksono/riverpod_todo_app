# 📝 Riverpod Todo App

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

- ✅ **Add Todo** - Add new todos easily
- ✏️ **Toggle Status** - Mark todos as completed/incomplete
- 🗑️ **Delete Todo** - Remove todos with instant list update
- 🔍 **Filter Todos** - Filter by status (All, Active, Completed)
- 📊 **Statistics** - Display total, active, and completed todo counts
- 💾 **Persistent Storage** - Data persists on device, survives app closure
- 🎨 **Modern UI** - Clean design with Material Design principles

## 🛠️ Tech Stack & Dependencies

### Production Dependencies

| Package              | Version | Purpose                                     |
| -------------------- | ------- | ------------------------------------------- |
| **flutter_riverpod** | ^2.5.0  | Powerful & reactive state management        |
| **hive**             | ^2.2.3  | NoSQL local database for persistent storage |
| **hive_flutter**     | ^1.1.0  | Hive integration with Flutter               |
| **get_it**           | ^7.6.0  | Service locator for dependency injection    |
| **injectable**       | ^2.2.0  | Practical dependency injection library      |
| **go_router**        | ^17.2.2 | Modern declarative routing for Flutter      |
| **cupertino_icons**  | ^1.0.8  | iOS-style icons for Material Design         |

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
cd riverpod_todo_app

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
│   ├── todo_provider.dart   # Riverpod providers setup
│   └── todo_notifier.dart   # TodoNotifier state management
├── data/
│   ├── repository/          # Repository pattern for data access
│   └── service/             # Service layer for Hive operations (CRUD)
├── utils/
│   └── todo_extension.dart  # Extension methods for todo operations
└── view/
    ├── home_page.dart       # Main screen with todo list
    ├── add_todo_page.dart   # Page to create new todo
    ├── todo_detail_page.dart # Page to view/edit todo details
    └── widget/
        └── [reusable widgets]
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

The application uses GoRouter for declarative, type-safe routing:

- `/` - **Home Page** - Display todo list with filters
- `/add` - **Add Todo Page** - Create new todo
- `/todo/:id` - **Todo Detail Page** - View and edit todo details

### Routes Configuration

Routes are defined in `router.dart` and integrated with GoRouter's powerful navigation API:

```dart
final goRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/add', builder: (context, state) => const AddTodoPage()),
    GoRoute(
      path: '/todo/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']!;
        return TodoDetailPage(todoId: todoId);
      },
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

## �💾 Database with Hive

Hive was chosen because:

✨ **Fast** - Very fast NoSQL local database  
✨ **Type-safe** - Automatic serialization with code generation  
✨ **Lightweight** - Small file size for mobile applications  
✨ **Simple** - Easy API for CRUD operations

## 📝 Development Notes

- When adding new fields to the Todo model, regenerate Hive adapters with: `dart run build_runner build`
- Data is stored in a Hive box named 'todos'
- All database operations are async for non-blocking performance

## 🎓 Learning Resources

This project is great for learning:

- State Management with Riverpod
- Local Database with Hive
- Clean Architecture in Flutter
- Provider Pattern
- Async/Await handling
