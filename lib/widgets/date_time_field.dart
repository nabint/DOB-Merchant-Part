import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

class BasicDateTimeField extends StatefulWidget {
  final bool initialValue;
  BasicDateTimeField(this.initialValue);
  DateTime times=DateTime.now();
  DateTime get  getDateTime => times;
  @override
  _BasicDateTimeFieldState createState() => _BasicDateTimeFieldState();
}

class _BasicDateTimeFieldState extends State<BasicDateTimeField> {
  final format = DateFormat.yMMMMd("en_US").add_jm();
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: format,
      initialValue: widget.initialValue ? DateTime.now() : null,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          final time = await showTimePickerSpinnerDialog(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          setState(() {
            widget.times = DateTimeField.combine(date, time);
          });
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }

  Future<TimeOfDay> showTimePickerSpinnerDialog({
    @required BuildContext context,
    @required TimeOfDay initialTime,
    TransitionBuilder builder,
    bool useRootNavigator = true,
  }) async {
    assert(context != null);
    assert(initialTime != null);
    assert(useRootNavigator != null);
    assert(debugCheckHasMaterialLocalizations(context));
    TimeOfDay timeOfDay;

    final Widget dialog = AlertDialog(
      backgroundColor: Colors.white95,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TimePickerSpinner(
              is24HourMode: false,
              onTimeChange: (time) {
                setState(
                  () {
                    timeOfDay = TimeOfDay.fromDateTime(time);
                  },
                );
              },
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, timeOfDay);
              },
              child: Text("Ok"),
            )
          ],
        ),
      ),
    );

    return await showDialog<TimeOfDay>(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
    );
  }
}
