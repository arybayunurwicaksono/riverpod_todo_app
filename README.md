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
| **cupertino_icons**  | ^1.0.8  | iOS-style icons for Material Design         |

### Development Dependencies

| Package                    | Version | Purpose                               |
| -------------------------- | ------- | ------------------------------------- |
| **hive_generator**         | ^2.0.1  | Code generator for Hive type adapters |
| **build_runner**           | ^2.4.6  | Build system for code generation      |
| **flutter_launcher_icons** | ^0.13.1 | Generate app launcher icons           |
| **flutter_lints**          | ^6.0.0  | Lint rules for best practices         |

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

# Generate Hive adapters
dart run build_runner build

# Run the app
flutter run
```

## 📂 Project Structure

```
lib/
├── main.dart                 # Entry point & Hive initialization
├── model/
│   ├── todo.dart            # Todo data model with Hive annotations
│   └── todo_filter.dart     # Filter enum (All, Active, Completed)
├── provider/
│   ├── todo_provider.dart   # Riverpod providers setup
│   └── todo_notifier.dart   # TodoNotifier state management
├── service/
│   └── hive_service.dart    # Service layer for Hive operations (CRUD)
└── view/
    ├── home_page.dart       # Main screen
    └── widget/
        ├── animated_todo_item.dart  # Todo item wrapper
        ├── todo_card.dart           # Todo item card UI
        └── shake_widget.dart        # Reusable shake animation widget
```

## 🏗️ Architecture Pattern

The application uses **Clean Architecture** with proper layer separation:

```
Presentation Layer (View)
        ↓
Provider Layer (State Management with Riverpod)
        ↓
Service Layer (Hive Database Operations)
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

## 💾 Database with Hive

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
