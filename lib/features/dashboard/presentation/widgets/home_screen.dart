import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_management/features/dashboard/domain/models/employees_model.dart';
import 'package:employee_management/features/dashboard/presentation/commands/load_employee_command.dart';
import 'package:employee_management/features/dashboard/presentation/widgets/components/employee_list.dart';
import 'package:employee_management/features/dashboard/presentation/widgets/components/employee_list_header.dart';
import 'package:employee_management/features/employee_management/presentation/states/employees_state.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/features/employee_management/presentation/widgets/employee_edit_add_screen.dart';
import 'package:employee_management/route/app_routes.dart' as route;

/// The screen that shows the app dashboard.
class HomeScreen extends StatefulWidget {
  /// Creates an instance of [HomeScreen].
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EmployeesModel employeesModel = const EmployeesModel();

  /// The employees loading state.
  late bool isLoading;

  @override
  void initState() {
    loadEmployees();

    super.initState();
  }

  Future<void> loadEmployees() async {
    setState(() {
      isLoading = true;
    });
    //Wait till build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LoadEmployeesCommand().run().whenComplete(() {
        // Get the updated employees model
        employeesModel = context.read<EmployeesModelCubit>().state;

        setState(() {
          isLoading =
              false; // Set the loading state to false when employees are loaded
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    employeesModel = context.watch<EmployeesModelCubit>().state;

    final List<EmployeeModel> currentEmployees = employeesModel.employees
        .where(
          (EmployeeModel element) =>
              element.endDateTime == null ||
              element.endDateTime!.isAfter(DateTime.now()),
        )
        .toList();

    final List<EmployeeModel> previousEmployees = employeesModel.employees
        .where(
          (EmployeeModel element) =>
              element.endDateTime != null &&
              element.endDateTime!.isBefore(DateTime.now()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Employee List")),
      body: RefreshIndicator(
        onRefresh: loadEmployees,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : currentEmployees.isEmpty && previousEmployees.isEmpty
                ? Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Align(
                          child: Image.asset(
                            'assets/images/no_record_image.png',
                            width: 261,
                          ),
                        ),
                        Align(
                          child: Text(
                            'No employee records found',
                            style: theme.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      CustomScrollView(
                        slivers: <Widget>[
                          EmployeeListHeader(
                            title: 'Current employees',
                            employees: currentEmployees,
                          ),
                          EmployeeList(employees: currentEmployees),
                          EmployeeListHeader(
                            title: 'Previous employees',
                            employees: previousEmployees,
                          ),
                          EmployeeList(employees: previousEmployees),
                          const SliverToBoxAdapter(child: SizedBox(height: 75)),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 75,
                          color: theme.colorScheme.surfaceVariant,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Swipe left to delete',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: theme.colorScheme.outline,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            route.AppRoutes.addEditEmployeeScreen,
            arguments: const AddEditEmployeeScreenArguments(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
