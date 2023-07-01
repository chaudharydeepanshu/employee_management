import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:employee_management/utils/date_time_util.dart';

/// The function to select date and time.
Future<DateTime?> selectDateTime({
  required BuildContext context,
  DateTime? selectedDate,
  DateTime? minDate,
  DateTime? maxDate,
  required bool showNoDateBtn,
  required bool showTodayBtn,
  required bool showNextMondayBtn,
  required bool showNextTuesdayBtn,
  required bool showNextWeekBtn,
}) async {
  final DateTime currentDate = DateTime.now();

  await showDialog<Widget>(
    context: context,
    builder: (BuildContext context) {
      return CustomDatePickerDialog(
        currentDate: currentDate,
        selectedDate: selectedDate,
        minDate: minDate ?? currentDate,
        maxDate: maxDate,
        showNoDateBtn: showNoDateBtn,
        showTodayBtn: showTodayBtn,
        showNextMondayBtn: showNextMondayBtn,
        showNextTuesdayBtn: showNextTuesdayBtn,
        showNextWeekBtn: showNextWeekBtn,
        onSelectedDate: (DateTime? date) {
          selectedDate = date;
        },
      );
    },
  );

  return selectedDate;
}

/// A custom dialog that contains a [SfDateRangePicker] to select a date.
class CustomDatePickerDialog extends StatefulWidget {
  /// Creates a custom dialog.
  const CustomDatePickerDialog({
    super.key,
    required this.currentDate,
    required this.selectedDate,
    required this.minDate,
    required this.maxDate,
    required this.onSelectedDate,
    this.showNoDateBtn = false,
    this.showTodayBtn = false,
    this.showNextMondayBtn = false,
    this.showNextTuesdayBtn = false,
    this.showNextWeekBtn = false,
  });

  /// The current date.
  final DateTime currentDate;

  /// The selected date.
  final DateTime? selectedDate;

  /// The minimum date.
  final DateTime minDate;

  /// The maximum date.
  final DateTime? maxDate;

  /// The function to call when a date is selected.
  final ValueChanged<DateTime?> onSelectedDate;

  /// Whether to show the no date button.
  final bool showNoDateBtn;

  /// Whether to show the today button.
  final bool showTodayBtn;

  /// Whether to show the next monday button.
  final bool showNextMondayBtn;

  /// Whether to show the next tuesday button.
  final bool showNextTuesdayBtn;

  /// Whether to show the next week button.
  final bool showNextWeekBtn;

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  late DateTime? selectedDate = widget.selectedDate;
  late DateRangePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DateRangePickerController();
    _controller.selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dialog(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.showNoDateBtn
                  ? Expanded(
                      child: FilledButton(
                        onPressed: () {
                          _controller.selectedDate = null;
                          setState(() {
                            selectedDate = null;
                          });
                        },
                        child: const Text(
                          'No date',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(width: widget.showNoDateBtn ? 16 : 0),
              widget.showTodayBtn
                  ? Expanded(
                      child: FilledButton.tonal(
                        onPressed: widget.minDate.isBefore(DateTime.now())
                            ? () {
                                _controller.selectedDate = widget.currentDate;
                                setState(() {
                                  selectedDate = widget.currentDate;
                                });
                              }
                            : null,
                        child: const Text(
                          'Today',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(width: widget.showTodayBtn ? 16 : 0),
              widget.showNextMondayBtn
                  ? Expanded(
                      child: FilledButton(
                        onPressed: () {
                          _controller.selectedDate =
                              getNextMonday(widget.currentDate);
                        },
                        child: const Text(
                          'Next Monday',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.showNextTuesdayBtn
                  ? Expanded(
                      child: FilledButton.tonal(
                        onPressed: () {
                          DateTime nextMonday =
                              getNextMonday(widget.currentDate);

                          DateTime nextTuesday =
                              nextMonday.add(const Duration(days: 1));

                          _controller.selectedDate = nextTuesday;
                        },
                        child: const Text(
                          'Next Tuesday',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(width: widget.showNextTuesdayBtn ? 16 : 0),
              widget.showNextWeekBtn
                  ? Expanded(
                      child: FilledButton.tonal(
                        onPressed: () {
                          DateTime afterOneWeek =
                              widget.currentDate.add(const Duration(days: 7));

                          _controller.selectedDate = afterOneWeek;
                        },
                        child: const Text(
                          'After 1 week',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 16),
          SfDateRangePicker(
            toggleDaySelection: true,
            controller: _controller,
            showNavigationArrow: true,
            initialDisplayDate: widget.currentDate,
            headerStyle: const DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
            ),
            monthViewSettings: const DateRangePickerMonthViewSettings(
              dayFormat: 'EEE',
            ),
            minDate: widget.minDate,
            maxDate: widget.maxDate,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              setState(() {
                selectedDate = args.value as DateTime?;
              });
            },
          ),
          const Divider(height: 32),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 16,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                children: <Widget>[
                  Icon(
                    Icons.event_outlined,
                    color: theme.iconTheme.color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    selectedDate != null
                        ? getDateInddMMMyyyyFormat(selectedDate!)
                        : 'No date',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 16,
                children: <Widget>[
                  FilledButton.tonal(
                    onPressed: () {
                      selectedDate = widget.selectedDate;

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: () {
                      widget.onSelectedDate.call(selectedDate);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
