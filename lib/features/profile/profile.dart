import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle
            ),
            child: Image.asset('assets/images/logo.png'),
          ),
          SizedBox(height: 30,),
          Text('Profile comes Here')
        ],
      ),
    );
  }
}