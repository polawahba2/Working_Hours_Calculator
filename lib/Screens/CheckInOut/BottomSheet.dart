import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_time_calculator/Compounent/Constants.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/SharedPreferences/CashHelper.dart';

var jobDateController = TextEditingController();
// var startingT  imeController = TextEditingController();
TextEditingController startSelectedTime = TextEditingController();
TextEditingController endSelectedTime = TextEditingController();

var formKey = GlobalKey<FormState>();
Widget myBottomSheet(context) {
  var size = MediaQuery.of(context).size;
  var myCubit = AppCubit.getCubit(context);

  return Container(
    color: kBackGroundColor,
    child: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.date_range,
                  color: Colors.blue[900],
                ),
                labelText: 'Date',
              ),
              controller: jobDateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid date';
                }
                return null;
              },
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.parse("2023-08-07"),
                ).then((value) {
                  jobDateController.text =
                      DateFormat("dd/MM/yyyy").format(value!).toString();
                  print(value);
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.alarm,
                  color: Colors.blue[900],
                ),
                labelText: 'Start Time',
              ),
              controller: startSelectedTime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid time';
                }
                return null;
              },
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  startSelectedTime.text = value!.format(context).toString();
                  print(value.format(context).toString());
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.red[900],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          CashHelper.saveData(
                            key: 'startTime',
                            value: startSelectedTime.text,
                          );
                          CashHelper.saveData(
                            key: 'startDate',
                            value: jobDateController.text,
                          );
                          myCubit.changeIsPressed(true);
                          startSelectedTime.text = '';
                          jobDateController.text = '';
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.green[900],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
