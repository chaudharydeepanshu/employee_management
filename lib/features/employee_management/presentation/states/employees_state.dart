import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_management/features/dashboard/domain/models/employees_model.dart';

/// A class representing the state of the [EmployeesModel] model.
class EmployeesModelCubit extends Cubit<EmployeesModel> {
  /// Creates an instance of [EmployeesModelCubit].
  EmployeesModelCubit() : super(const EmployeesModel());

  /// Method to update the state with a new [EmployeesModel].
  void updateModel(EmployeesModel newModel) {
    emit(newModel);
  }
}
