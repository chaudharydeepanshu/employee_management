import 'package:freezed_annotation/freezed_annotation.dart';

// Note: These below imports are code generated so if missing run generator.
part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

/// The type of role assigned to an employee.
enum RoleType {
  /// The product designer role.
  productDesigner,

  /// The flutter developer role.
  flutterDeveloper,

  /// The QA tester role.
  qaTester,

  /// The product owner role.
  productOwner
}

/// Returns the label for a given [RoleType].
String getRoleTypeLabel(RoleType type) {
  switch (type) {
    case RoleType.productDesigner:
      return 'Product Designer';
    case RoleType.flutterDeveloper:
      return 'Flutter Developer';
    case RoleType.qaTester:
      return 'QA Tester';
    case RoleType.productOwner:
      return 'Product Owner';
  }
}

/// A class representing the employee model.
@freezed
class EmployeeModel with _$EmployeeModel {
  /// Private empty constructor required for getters and setters to work.
  const EmployeeModel._();

  /// Default constructor for the [EmployeeModel].
  const factory EmployeeModel({
    /// The employee unique identifier.
    required String uuid,

    /// The employee name.
    required String name,

    /// The employee join date time.
    required DateTime joinDateTime,

    /// The employee end date time.
    required DateTime? endDateTime,

    /// The role assigned to the employee.
    required RoleType role,
  }) = _EmployeeModel;

  /// Creates an [EmployeeModel] instance from a JSON [Map].
  factory EmployeeModel.fromJson(Map<String, Object?> json) =>
      _$EmployeeModelFromJson(json);
}
