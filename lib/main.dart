import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:employee_management/constants/other_constants.dart';
import 'package:employee_management/features/employee_management/presentation/states/employees_state.dart';
import 'package:employee_management/features/employee_management/application/services/employee_service.dart';
import 'package:employee_management/features/employee_management/data/repositories/sqlite_employee_impl.dart';
import 'package:employee_management/features/shared/presentation/commands/base_command.dart'
    as commands;
import 'package:employee_management/theme/custom_theme_data.dart';
import 'package:employee_management/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:employee_management/theme/color_schemes.dart';
import 'package:employee_management/theme/custom_color.dart';
import 'package:employee_management/route/app_routes.dart' as route;

/// Its true if the application is running in debug mode.
///
/// Use it in place of [kDebugMode] through out the app to check for debug mode.
/// Useful in faking production mode in debug mode by setting it to false.
bool isInDebugMode = kDebugMode;

/// The Dynamic Color theme status.
bool isDynamicColorThemeEnabled = false;

/// Key used when building the ScaffoldMessenger.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  runZonedGuarded(() async {
    // Ensure that widget binding is initialized.
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Initialize FFI
      sqfliteFfiInit();
    }
    // Change the default factory. On iOS/Android, if not using
    // `sqlite_flutter_lib` you can forget this step, it will use the sqlite
    // version available on the system.
    databaseFactory = databaseFactoryFfi;

    // Initialize logger.
    await setupLogger();

    runApp(const DynamicColorApp());
  }, (Object error, StackTrace stackTrace) {
    logger.e('Uncaught error: $error', error, stackTrace);
  });
}

/// The root widget of the app.
class DynamicColorApp extends StatelessWidget {
  /// Creates a [DynamicColorApp].
  const DynamicColorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (!isDynamicColorThemeEnabled) {
          lightDynamic = null;
          darkDynamic = null;
        }

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          // Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        return MultiRepositoryProvider(
          providers: <RepositoryProvider<dynamic>>[
            RepositoryProvider<EmployeeService>(
              create: (BuildContext context) =>
                  EmployeeService(SQLiteEmployeeImpl()),
            ),
          ],
          child: MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<EmployeesModelCubit>(
                create: (BuildContext context) => EmployeesModelCubit(),
              ),
            ],
            child: Builder(
              builder: (BuildContext context) {
                commands.init(context);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: appName,
                  theme: customThemeData(
                    colorScheme: lightScheme,
                    extensions: <CustomColors>[lightCustomColors],
                  ),
                  darkTheme: customThemeData(
                    colorScheme: darkScheme,
                    extensions: <CustomColors>[darkCustomColors],
                  ),
                  themeMode: ThemeMode.light,
                  scaffoldMessengerKey: rootScaffoldMessengerKey,
                  initialRoute: route.AppRoutes.homeScreen,
                  onGenerateRoute: route.AppRoutes.controller,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
