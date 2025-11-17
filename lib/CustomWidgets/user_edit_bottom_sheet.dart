import 'package:flutter/material.dart';

import 'label_widget.dart';

class UserEditBottomSheet extends StatefulWidget {
  const UserEditBottomSheet({super.key});

  @override
  State<UserEditBottomSheet> createState() => _UserEditBottomSheetState();
}

class _UserEditBottomSheetState extends State<UserEditBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Edit User Data Label
          Center(
            child: LabelWidget(
              label: 'Edit User Data',
              fontSize: 20,
              fontColor: Colors.orange,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 20.0),

          /// User Name Label
          LabelWidget(
            label: 'User Name',
            fontSize: 18,
            fontColor: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 8.0),

          SizedBox(height: 18.0),

          /// Email Address Label
          LabelWidget(
            label: 'Email Address',
            fontSize: 18,
            fontColor: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 8.0),

          SizedBox(height: 50.0),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            /// Button Section
            child: Row(
              children: [
                /// Save Button
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Save"),
                  ),
                ),
                Spacer(),

                /// Cancel Button
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
