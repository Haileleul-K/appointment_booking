import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_with_bloc/core/colors.dart';
import 'package:ticket_with_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ticket_with_bloc/features/auth/data/user_model.dart';
import 'package:ticket_with_bloc/features/home/widgets/modal_bottom.dart';
import 'package:ticket_with_bloc/features/home/widgets/widgets.dart';
import 'package:ticket_with_bloc/features/tickets/tikets.dart';
import 'package:ticket_with_bloc/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'A.A to Ambo';
  AuthBloc? authBloc;
  User? userData;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    userData = (authBloc!.state as LoginSuccess).userData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    print("object");
                    Navigator.pushNamed(context, Paths.bluetooth);
                  },
                  icon: Icon(Icons.bluetooth)),
            ],
            leading: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10),
              child: Text(
                'Active',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(30),
                  //     bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                end: Alignment.topRight,
                begin: Alignment.bottomLeft,
                colors: [
                  AppColors.primaryAppColor,
                  AppColors.secondaryLightColor
                ],
              )),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => floatingActionmodal(context, isCarSelected: true),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryAppColor,
          splashColor: AppColors.secondaryAppColor,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: gradiant()),
                child: userData!.clientUserLink.role != 'admin'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 60),
                        child: Center(
                          child: Text(
                            'No active trip found please create it',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          activeComponent(
                              iconName: 'assets/icons/distance.png',
                              description: 'A.A to Ambo'),
                          SizedBox(
                            height: 5,
                          ),
                          activeComponent(
                              iconName: 'assets/icons/car.png',
                              description:
                                  'Type:Dolphin\nplate: or-232\nside-code: 654'),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/icons/car-seat.png',
                                scale: 1.8,
                                color: Colors.orange,
                              ),
                              Column(
                                children: [
                                  Text('9', style: testStyle(fontsize: 20)),
                                  Text('Left', style: testStyle(fontsize: 13))
                                ],
                              ),
                              Column(
                                children: [
                                  Text('5', style: testStyle(fontsize: 20)),
                                  Text('Printed',
                                      style: testStyle(fontsize: 13))
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 20.h,
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       // gradient: gradiant(),
              //       color: Colors.orange.withOpacity(0.7)),
              //   child:
              // ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => Dialog(
                    child: Container(
                        //height: size.width * 0.6,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                                leading: Text(
                                  'Create new ticket',
                                  style: TextStyle(
                                      color: AppColors.secondaryLightColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon:
                                        Icon(Icons.highlight_remove_rounded))),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  label: Text('Select Trip'),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius: BorderRadius.circular(10))),
                              value: dropdownValue,
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'A.A to Ambo',
                                'A.A to Adama'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text('Passenger Name'),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Text 3 is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Create'))
                              ],
                            )
                          ],
                        )),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      gradient: gradiant(),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    ' Add Tickets ',
                    style: testStyle(fontsize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Flexible(
                  child: ListView.builder(
                      itemCount: 115,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.primaryAppColor),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppColors.primaryAppColor.withOpacity(0.3),
                                // spreadRadius: 5,
                                blurRadius: 11,
                                offset: Offset(
                                    5, 5.h), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Here names come'),
                                    Text('detail')
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Here names come'),
                                    Text('detail')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }

  floatingActionmodal(context, {required bool isCarSelected}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Wrap(
              children: [
                tripCreateModalsheet(context,
                    iconPath: 'assets/icons/distance.png',
                    iconText: 'Add new trip'),
                vehicleAddModalsheet(context,
                    iconPath: 'assets/icons/car.png', iconText: 'Add vehicle'),
                // modalSheetComponents(context,
                //     iconPath: 'assets/icons/station.png',
                //     iconText: 'Add station'),
              ],
            ),
          );
        });
  }
}
