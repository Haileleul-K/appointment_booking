import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skylightDemo/core/colors.dart';
import 'package:skylightDemo/core/utils/notification_service.dart';
import 'package:skylightDemo/features/home/bloc/add_service/add_service_bloc.dart';
import 'package:skylightDemo/features/home/bloc/delete_service/delete_service_bloc.dart';
import 'package:skylightDemo/features/home/bloc/get_service/service_bloc.dart';


class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage({super.key});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  ServiceBloc? serviceBloc;
  DeleteServiceBloc? deleteServiceBloc;
  AddServiceBloc? addServiceBloc;
  @override
  void initState() {
    super.initState();

    serviceBloc = BlocProvider.of<ServiceBloc>(context);
    deleteServiceBloc = BlocProvider.of<DeleteServiceBloc>(context);
    addServiceBloc = BlocProvider.of<AddServiceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceBloc, ServiceState>(
      listener: (context, state) {
        if (state is ServiceInitial) {
          EasyLoading.show(status: 'Loading...');
        } else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        if (state is ServiceLoaded) {
          return Flexible(
              child: state.serviceData.isEmpty
                  ? Center(
                      child: Text('There is no service data yet'),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: state.serviceData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.primaryAppColor),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondaryAppColor
                                    .withOpacity(0.3),
                                // spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    1.h, 3.h), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(5.h),
                              child: InkWell(
                                onTap: () => showDialog(
                                    barrierColor: Colors.white,
                                    context: context,
                                    builder: (context) {
                                      return BlocListener<DeleteServiceBloc,
                                          DeleteServiceState>(
                                        listener: (context, deleteState) {
                                          if (deleteState
                                              is DeleteServiceInitial)
                                            EasyLoading.show();
                                          else if (deleteState
                                              is DeleteServiceError) {
                                            EasyLoading.dismiss();
                                            EasyLoading.showError(
                                                deleteState.message,
                                                dismissOnTap: true,
                                                duration: Duration(seconds: 2));
                                          } else if (deleteState
                                              is DeleteServicLoaded) {
                                        setState(() {
                                          state.serviceData.remove(
                                                state.serviceData[index]);
                                            EasyLoading.dismiss();
                                        });    
                                            Navigator.pop(context);
                                            NotificationService().showNotification('Delete Notification', 'Service deleted successfully');
                                            EasyLoading.showSuccess(
                                                'Successfully deleted !',
                                                dismissOnTap: true,
                                                duration: Duration(seconds: 2));
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.h, horizontal: 10.w),
                                          child: SingleChildScrollView(
                                            child: Column(children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                ),
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.all(0.h),
                                                  leading: IconButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      icon: Icon(
                                                        Icons.arrow_back,
                                                        color: Colors.black,
                                                      )),
                                                  title: Center(
                                                      child: Text(
                                                    'Service details',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  trailing: IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                Dialog(
                                                                    child:
                                                                        Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          30),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20.r)),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 20.0.h),
                                                                        child:
                                                                            Text(
                                                                          'Are you sure you want to delete this service item ?',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14.sp,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          confirmButton(
                                                                              AppColors.primaryAppColor,
                                                                              'Cancel',
                                                                              () => Navigator.pop(context)),
                                                                          SizedBox(
                                                                            width:
                                                                                15.w,
                                                                          ),
                                                                          confirmButton(
                                                                              Colors.red,
                                                                              'Yes',
                                                                              () => {
                                                                                    Navigator.pop(context),
                                                                                    deleteServiceBloc!.add(DeleteServiceEvent(serviceItemId: state.serviceData[index].service!.id.toString()))
                                                                                  }),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                )));
                                                      },
                                                      icon: Icon(Icons
                                                          .delete_rounded)),
                                                ),
                                              ),
                                              serviceDetail(
                                                  title: 'Title',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .title ??
                                                      ''),
                                              serviceDetail(
                                                  title: 'Is active',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .active
                                                          .toString() ??
                                                      'false'),
                                              serviceDetail(
                                                  title: 'Description',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .description ??
                                                      'No description'),
                                              serviceDetail(
                                                  title: 'Price',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .price ??
                                                      'Price not set'),
                                              serviceDetail(
                                                  title: 'Booking capacity',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .bookingCapacity
                                                          .toString() ??
                                                      ' false'),
                                              serviceDetail(
                                                  title: 'Has day booking',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .hasDayBooking
                                                          .toString() ??
                                                      'flase'),
                                              serviceDetail(
                                                  title: 'Max Slots',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .maxSlots
                                                          .toString() ??
                                                      ''),
                                              serviceDetail(
                                                  title: 'Booking Type',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .bookingType ??
                                                      ''),
                                              serviceDetail(
                                                  title: 'Payment required',
                                                  value: state
                                                          .serviceData[index]
                                                          .service!
                                                          .paymentRequired
                                                          .toString() ??
                                                      ''),
                                            ]),
                                          ),
                                        ),
                                      );
                                    }),
                                child: ListTile(
                                  leading: Text(
                                      state.serviceData[index].service!.title ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Text(
                                      state.serviceData[index].service!.price ??
                                          'Price not set'),
                                ),
                              )),
                        );
                      }));
        } else if (state is ServiceLoadingError) {
          EasyLoading.showError(state.error);
        }
        return Container();
      },
    );
  }

  ElevatedButton confirmButton(Color color, String title, onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: 10.h), // Button padding
      ),
      child: Text(title),
    );
  }

  Container serviceDetail({required String title, required String value}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 8.w),
      decoration: BoxDecoration(
          border: Border.all(
              //strokeAlign: 1,
              width: 1.w,
              color: AppColors.primaryAppColor),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppColors.primaryAppColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.height / 6,
              ),
              child: Text(
                value,
                style: TextStyle(
                    color: AppColors.secondaryLightColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                maxLines: 4,
              ),
            ),
          ]),
    );
  }
}
