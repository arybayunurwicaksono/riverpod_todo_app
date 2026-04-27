import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_ai/data/service/firebase_auth_service.dart';

// Provider untuk Firebase AuthService
final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

// Provider untuk mengecek user saat ini
final currentUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return FirebaseAuth.instance.authStateChanges();
});

// Provider untuk mengecek apakah user sudah login
final isUserLoggedInProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user.maybeWhen(data: (user) => user != null, orElse: () => false);
});

// StateNotifier untuk handle login, register, logout
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final FirebaseAuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _authService.register(
        email: email,
        password: password,
      );
      return result.user;
    });
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _authService.login(email: email, password: password);
      return result.user;
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authService.logout();
      return null;
    });
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
