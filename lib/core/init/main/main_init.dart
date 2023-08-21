part of '../../../main.dart';

final getIt = GetIt.instance;

Future<void> initInitializes() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _firebaseInitialize();
  await HiveDatabaseManager().initialize();
  getIt.registerSingleton<AppRouter>(AppRouter());
  await LocaleManager.instance.init();
}

Future<void> _firebaseInitialize() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Firebase Auth
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),

    // ... other providers
  ]);
}
