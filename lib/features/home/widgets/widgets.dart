import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_with_bloc/core/colors.dart';
import 'package:ticket_with_bloc/routes.dart';

LinearGradient gradiant() {
  return LinearGradient(
    end: Alignment.topRight,
    begin: Alignment.bottomLeft,
    colors: [AppColors.primaryAppColor, AppColors.secondaryLightColor],
  );
}

TextStyle testStyle({
  required int fontsize,
}) =>
    TextStyle(color: Colors.white, fontSize: fontsize.sp);

Widget activeComponent({
  required String iconName,
  required String description,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 18.0),
    child: Container(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            iconName,
            scale: 1.6,
            color: Colors.orange,
          ),
          SizedBox(
            width: 60,
          ),
          Text(
            description,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          // ElevatedButton(
          //     onPressed: () {},
          //     child: Text('Change'),
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.orange.withOpacity(0.8),
          //         elevation: 15))
        ],
      ),
    ),
  );
}
Widget TicketAdd() {
  return Container(
    height: 200,
    child: Text('sdfdf'),
  );
}
