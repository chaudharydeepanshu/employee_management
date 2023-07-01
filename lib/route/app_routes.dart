import 'package:employee_management/features/dashboard/presentation/widgets/home_screen.dart';
import 'package:employee_management/features/employee_management/presentation/widgets/employee_edit_add_screen.dart';
import 'package:flutter/material.dart';

/// App routes names.
///
/// Note: When using path "/" in routes names then the initial route will always
/// have to be "/" and will always run "/" no matter what initial route is.
class AppRoutes {
  /// [HomeScreen] screen route name.
  static const String homeScreen = 'homeScreen';

  /// [AddEditEmployeeScreen] screen route name.
  static const String addEditEmployeeScreen = 'addEditEmployeeScreen';

  /// Controls app page routes flow.
  static Route<Widget> controller(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const HomeScreen(),
          settings: RouteSettings(name: settings.name),
        );

      case addEditEmployeeScreen:
        return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => AddEditEmployeeScreen(
            arguments: settings.arguments as AddEditEmployeeScreenArguments,
          ),
          settings: RouteSettings(name: settings.name),
        );
      default:
        throw ('This route name does not exist');
    }
  }
}

/// Use MaterialPageRoute<Widget>() which uses a default animation and for
/// different animation, use PageRouteBuilder() or CupertinoPageRoute().
///
/// To pass an argument while routing between pages consider this example:
/// Ex: To pass an argument from loginPage to homePage, first add argument
/// request in HomePage stateless widget. Like so:
/// home.dart
/// ```
/// class HomePage extends StatelessWidget {
///   final Object argument;
///
///   HomePage({required this.argument});
///
///   @override
///   Widget build(BuildContext context) {
///   return SizedBox();
///   }
/// }
/// ```
/// Then, add settings.arguments option to
/// Route<dynamic> controller(RouteSettings settings) for HomePage. Like so:
/// ```
/// Route<Widget> controller(RouteSettings settings) {
///   switch (settings.name) {
///   ...
///   case homePage:
///     return MaterialPageRoute<Widget>(
///       builder: (context) => HomePage(arguments: settings.arguments));
///   ...
///   }
/// }
/// ```
/// Finally, pass any objects e.g text, data when you use
/// Navigator.pushNamed();. Like so:
/// AnyOtherPage.dart
/// ```
/// class AnyOtherPage extends StatelessWidget {
///   const AnyOtherPage({Key? key}) : super(key: key);
///
///   @override
///   Widget build(BuildContext context) {
///     return ElevatedButton(
///       onPressed: () => Navigator.pushNamed(context, AppRoutes.homePage,
///           arguments: 'My object As Text'),
///       child: const Text("Push HomePage"),
///     );
///   }
/// }
/// ```
///
/// Credits to https://web.archive.org/web/20221203142623/https://oflutter.com/organized-navigation-named-route-in-flutter/ for tutorial.
