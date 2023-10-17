import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_with_bloc/core/colors.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}


class _TicketPageState extends State<TicketPage> with TickerProviderStateMixin{


late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);


  
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
           flexibleSpace: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          
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
          ),
          automaticallyImplyLeading: false,
          title: TabBar(
            labelColor: Colors.green,
            labelPadding: const EdgeInsets.only(left: 10, right: 10),
            indicatorColor: Colors.green,
            indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
            indicatorWeight: 2,
            tabs: [
              ElevatedButton(onPressed: () {}, child: Text('Generated')),
              ElevatedButton(onPressed: () {}, child: Text('Printed')),
              ElevatedButton(onPressed: () {}, child: Text('Offline'))

            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 10),
          child: TabBarView(children: [
            ListView.builder(
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
                                  color: AppColors.primaryAppColor
                                      .withOpacity(0.3),
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
                        }),
                ListView.builder(
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
                                  color: AppColors.primaryAppColor
                                      .withOpacity(0.3),
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
                        }),
                        ListView.builder(
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
                                  color: AppColors.primaryAppColor
                                      .withOpacity(0.3),
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
                        })
          ]),
        ),
      ),
    );
  }
}
