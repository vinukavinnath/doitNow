import 'package:doitnow/core/custom_snackbar_class.dart';
import 'package:flutter/material.dart';
import 'package:doitnow/core/constants.dart';
import 'package:flutter/services.dart';

class AddTaskWidget extends StatefulWidget {
  AddTaskWidget({
    super.key,
    required this.categoryController,
    required this.taskController,
    required this.submitData,
  });

  final TextEditingController categoryController;
  final TextEditingController taskController;
  final void Function() submitData;

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final GlobalKey<FormState> _taskFormKey = GlobalKey<FormState>();

  final int characterLimit = 15;

  @override
  void initState() {
    widget.categoryController.addListener(updateCharacterCount);
    super.initState();
  }

  void dispose() {
    widget.categoryController.removeListener(updateCharacterCount);
    super.dispose();
  }

  void updateCharacterCount() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10.0,
      content: Form(
        key: _taskFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: widget.categoryController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Category';
                }
                return null; // Return null if the input is valid
              },
              decoration: InputDecoration(
                hintText: 'Category here...',
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(characterLimit),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${widget.categoryController.text.length.toString()}/${characterLimit.toString()}',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: widget.taskController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Task';
                }
                return null; // Return null if the input is valid
              },
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Task here...',
              ),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            if (_taskFormKey.currentState!.validate()) {
              widget.submitData();
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  backColor: kDoneGreenColor,
                  time: 3,
                  title: 'Successfully Added!',
                ),
              );
            }
          },
          style: FilledButton.styleFrom(
            elevation: 8.0,
          ),
          child: Text('Add'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            widget.categoryController.clear();
            widget.taskController.clear();
          },
          style: FilledButton.styleFrom(
            elevation: 8.0,
          ),
          child: Text('Cancel'),
        ),
      ],
      backgroundColor: kDarkGreyColor,
    );
  }
}
