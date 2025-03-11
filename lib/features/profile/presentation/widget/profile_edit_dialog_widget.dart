import 'package:flutter/material.dart';

class ProfileEditDialogWidget extends StatelessWidget {
  const ProfileEditDialogWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller,
          ),
        ],
      ),
    );
  }
}

void showProfileEditForm(
  BuildContext context, {
  required String title,
  required TextEditingController controller,
  required dynamic provider,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: ProfileEditDialogWidget(
        controller: controller,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: Text('Update'),
        ),
      ],
    ),
  );
}
