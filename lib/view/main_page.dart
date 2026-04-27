import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_ai/view/home_page.dart';
import 'package:todo_ai/view/profile_page.dart';
import 'package:todo_ai/view/login_page.dart';
import 'package:todo_ai/provider/auth_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final isLoggedIn = currentUserAsync.maybeWhen(
      data: (user) => user != null,
      orElse: () => false,
    );

    return currentUserAsync.when(
      data: (user) {
        List<Widget> pages;
        if (isLoggedIn) {
          pages = <Widget>[const HomePage(), const ProfilePage()];
        } else {
          pages = <Widget>[const HomePage(), const LoginPage()];
        }

        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: _selectedIndex == 0
              ? AppBar(
                  title: const Text('Todo App'),
                  centerTitle: true,
                  elevation: 0,
                )
              : null,
          body: IndexedStack(index: _selectedIndex, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: isLoggedIn ? 'Profile' : 'Login',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          floatingActionButton: _selectedIndex == 0 && isLoggedIn
              ? FloatingActionButton(
                  onPressed: () => context.push('/add'),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Colors.blue[400]),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(body: Center(child: Text('Error: $error')));
      },
    );
  }
}
