import 'package:employee_management/features/dashboard/presentation/commands/delete_employee_command.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:employee_management/features/employee_management/presentation/commands/add_employee_command.dart';
import 'package:employee_management/features/employee_management/presentation/commands/update_employee_command.dart';
import 'package:employee_management/features/employee_management/presentation/widgets/components/custom_date_picker_dialog.dart';
import 'package:employee_management/features/employee_management/presentation/widgets/components/date_selection_field.dart';
import 'package:employee_management/features/employee_management/presentation/widgets/components/role_selection_botton_sheet.dart';
import 'package:employee_management/utils/date_time_util.dart';
import 'package:employee_management/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/utils/uuid_generator.dart';

/// The screen that shows the employees edit / add screen.
class AddEditEmployeeScreen extends StatefulWidget {
  /// Creates an instance of [AddEditEmployeeScreen].
  const AddEditEmployeeScreen({Key? key, required this.arguments})
      : super(key: key);

  /// Arguments passed when screen pushed.
  final AddEditEmployeeScreenArguments arguments;

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  late RoleType? selectedType = widget.arguments.employee == null
      ? null
      : widget.arguments.employee!.role;

  late TextEditingController titleController = widget.arguments.employee == null
      ? TextEditingController()
      : TextEditingController(text: widget.arguments.employee!.name);

  late TextEditingController roleController = TextEditingController(
    text:
        selectedType != null ? getRoleTypeLabel(selectedType!) : 'Select role',
  );

  late TextEditingController joinDateTimeController = TextEditingController(
    text: joinDateTime != null
        ? getDateInddMMMyyyyFormat(joinDateTime!)
        : 'No Date',
  );

  late TextEditingController endDateTimeController = TextEditingController(
    text: endDateTime != null
        ? getDateInddMMMyyyyFormat(endDateTime!)
        : 'No Date',
  );

  late DateTime? joinDateTime = widget.arguments.employee == null
      ? null
      : widget.arguments.employee!.joinDateTime;

  late DateTime? endDateTime = widget.arguments.employee == null
      ? null
      : widget.arguments.employee!.endDateTime;

  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Add form key

  Future<void> updateEmployee() async {
    // Validate the form
    if (formKey.currentState?.validate() == true) {
      EmployeeModel employeeModel = EmployeeModel(
        uuid: widget.arguments.employee!.uuid,
        name: titleController.text,
        role: selectedType!,
        joinDateTime: joinDateTime!,
        endDateTime: endDateTime,
      );

      try {
        if (context.mounted) {
          setState(() {
            _isProcessing = true;
          });
        }

        await UpdateEmployeeCommand().run(employeeModel);

        // Reset the form after successful update
        formKey.currentState?.reset();
        // Navigate back to the previous screen
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        logger.e(e);
      } finally {
        if (context.mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
      }
    }
  }

  Future<void> addEmployee() async {
    // Validate the form
    if (formKey.currentState?.validate() == true) {
      EmployeeModel employeeModel = EmployeeModel(
        uuid: generateUUID(),
        name: titleController.text,
        role: selectedType!,
        joinDateTime: joinDateTime!,
        endDateTime: endDateTime,
      );

      try {
        if (context.mounted) {
          setState(() {
            _isProcessing = true;
          });
        }

        await AddEmployeeCommand().run(
          employeeModel,
        );

        // Reset the form after successful update
        formKey.currentState?.reset();
        // Navigate back to the previous screen
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        logger.e(e);
      } finally {
        if (context.mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
      }
    }
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.arguments.employee == null
                ? 'Add Employee Details'
                : 'Edit Employee Details',
          ),
          actions: <Widget>[
            widget.arguments.employee != null
                ? IconButton(
                    onPressed: () async {
                      await DeleteEmployeeCommand().run(
                        widget.arguments.employee!.uuid,
                      );
                      // Reset the form after successful update
                      formKey.currentState?.reset();
                      // Navigate back to the previous screen
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    tooltip: 'Delete Employee Details',
                    icon: const Icon(Icons.delete_outlined),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Employee Name',
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          titleController.clear();
                        },
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter employee name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onTap: () async {
                      selectedType = await showRoleSelectionBottomSheet(
                        context,
                        selectedType,
                      );

                      roleController.text = selectedType != null
                          ? getRoleTypeLabel(selectedType!)
                          : 'Select role';

                      setState(() {});
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work_outline_outlined),
                    ),
                    controller: roleController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (selectedType == null) {
                        return 'Please select a role';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: DateSelectionField(
                          controller: joinDateTimeController,
                          onTap: () async {
                            joinDateTime = await selectDateTime(
                              context: context,
                              maxDate: endDateTime,
                              selectedDate: joinDateTime,
                              showNoDateBtn: false,
                              showTodayBtn: true,
                              showNextMondayBtn: true,
                              showNextTuesdayBtn: true,
                              showNextWeekBtn: true,
                            );

                            joinDateTimeController.text = joinDateTime != null
                                ? getDateInddMMMyyyyFormat(joinDateTime!)
                                : 'No Date';

                            setState(() {});
                          },
                          labelText: 'Join Date',
                          prefixIcon: Icons.today_outlined,
                          validator: (String? value) {
                            if (joinDateTime == null) {
                              return 'Please select a join date';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: theme.iconTheme.color,
                          size: 20,
                        ),
                      ),
                      Flexible(
                        child: DateSelectionField(
                          controller: endDateTimeController,
                          onTap: () async {
                            endDateTime = await selectDateTime(
                              context: context,
                              minDate: joinDateTime,
                              selectedDate: endDateTime,
                              showNoDateBtn: true,
                              showTodayBtn: true,
                              showNextMondayBtn: false,
                              showNextTuesdayBtn: false,
                              showNextWeekBtn: false,
                            );

                            endDateTimeController.text = endDateTime != null
                                ? getDateInddMMMyyyyFormat(endDateTime!)
                                : 'No Date';
                            setState(() {});
                          },
                          labelText: 'End Date',
                          prefixIcon: Icons.event_outlined,
                          validator: (String? value) {
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Divider(height: 0.0),
                Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      runSpacing: 16,
                      children: <Widget>[
                        FilledButton.tonal(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 16.0),
                        _isProcessing
                            ? const Center(child: CircularProgressIndicator())
                            : FilledButton(
                                onPressed: widget.arguments.employee == null
                                    ? addEmployee
                                    : updateEmployee,
                                child: const Text('Save'),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Takes [AddEditEmployeeScreen] arguments passed when screen pushed.
class AddEditEmployeeScreenArguments {
  /// Defining [AddEditEmployeeScreenArguments] constructor.
  const AddEditEmployeeScreenArguments({
    this.employee,
  });

  /// Takes [EmployeeModel] as an argument.
  final EmployeeModel? employee;
}
