import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_todo_app/data/service/hive_service.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();

@module
abstract class RegisterModule {
  @preResolve
  Future<HiveService> get hiveService async {
    await HiveService.init();
    return HiveService();
  }
}
