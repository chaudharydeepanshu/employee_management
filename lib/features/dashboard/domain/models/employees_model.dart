import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Note: These below imports are code generated so if missing run generator.
part 'employees_model.freezed.dart';
part 'employees_model.g.dart';

/// A class representing the employees models.
@freezed
class EmployeesModel with _$EmployeesModel {
  /// Private empty constructor required for getters and setters to work.
  const EmployeesModel._();

  /// Default constructor for the [EmployeesModel].
  const factory EmployeesModel({
    /// The list of employees.
    @Default(<EmployeeModel>[]) List<EmployeeModel> employees,
  }) = _EmployeesModel;

  /// Creates an [EmployeesModel] instance from a JSON [Map].
  factory EmployeesModel.fromJson(Map<String, Object?> json) =>
      _$EmployeesModelFromJson(json);
}
