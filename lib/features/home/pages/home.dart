import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skylightDemo/core/colors.dart';
import 'package:skylightDemo/core/utils/hive_service.dart';
import 'package:skylightDemo/core/utils/notification_service.dart';
import 'package:skylightDemo/features/auth/bloc/auth_bloc.dart';
import 'package:skylightDemo/features/auth/data/user_model.dart';
import 'package:skylightDemo/features/home/bloc/add_service/add_service_bloc.dart';
import 'package:skylightDemo/features/home/bloc/get_service/service_bloc.dart';
import 'package:skylightDemo/features/home/pages/service_details.dart';
import 'package:skylightDemo/features/home/widgets/widgets.dart';
import 'package:skylightDemo/routes.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  User? userData;
  AuthBloc? authBloc ;
  AddServiceBloc? addServiceBloc;
  ServiceBloc? serviceBloc;
  @override
  void initState() {
    super.initState();
  
  authBloc = BlocProvider.of<AuthBloc>(context);
  addServiceBloc = BlocProvider.of<AddServiceBloc>(context);
  serviceBloc =  BlocProvider.of<ServiceBloc>(context);
    userData = (authBloc!.state as LoginSuccess).userData;
  serviceBloc!.add(GetServices());
  }

  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: ()async{

                   await HiveService.deleteUser();

                    Navigator.pushReplacementNamed(context, Paths.login);
                  },
                  icon: Icon(Icons.power_settings_new_rounded)),
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
          onPressed: () => serviceAddDialog(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryAppColor,
          splashColor: AppColors.secondaryAppColor,
        ),
        body: WillPopScope(
           onWillPop: () async { 
           return true;
        },
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15.h),
            child: Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Container(
                      height: hight * 0.22,
                      width: width * 0.9,
                      padding:
                          EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: gradiant()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Hello Again !',
                            style: testStyle(fontsize: 16),
                          ),
                          if (state is LoginSuccess)
                            Text(
                              'You\'r logged in as ${state.userData.clientUserLink?.role}',
                              style: testStyle(fontsize: 16),
                            )
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocListener<AddServiceBloc, AddServiceState>(
                  listener: (context, state) {
                    if(state is AddServiceInitial)
                    EasyLoading.show();
                    else if(state is AddServiceLoaded){
                      EasyLoading.dismiss();
                      setState(() {
                        
                      });
                      NotificationService().showNotification('New notification', 'New service successfully created!');
                      EasyLoading.showSuccess('Successfully created!',dismissOnTap: true, duration: Duration(seconds: 2));
        
                    }
                    else if(state is AddServiceError){
                      EasyLoading.showError(state.message);
                    }
                  },
                  child: InkWell(
                    onTap: () => serviceAddDialog(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          gradient: gradiant(),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        ' Add Service ',
                        style: testStyle(fontsize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
           if   (userData!.clientUserLink!.role == 'admin')  ServiceDetailsPage()
              ],
            ),
          ),
        ));
  }

  Future<dynamic> serviceAddDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog(
        child: Container(
            //height: size.width * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: (userData!.clientUserLink!.role == 'staff')?  
            Center(child: Text('Only admin can do this'),):
             Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      leading: Text(
                        'Add new service',
                        style: TextStyle(
                            color: AppColors.primaryAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.highlight_remove_rounded,
                            size: 20.h,
                          ))),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: _titleEditingController,
                    decoration: InputDecoration(
                      label: Text('Title'),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      value?.trim();
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TextFormField(
                      controller: _priceEditingController,
                      decoration: InputDecoration(
                        label: Text('Price'),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        value?.trim();
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }

                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryAppColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              serviceBloc!.state is ServiceLoaded) {
                            addServiceBloc!.add(AddServiceEvent(
                                serviceData:
                                    (serviceBloc!.state as ServiceLoaded)
                                        .serviceData,
                                servicePrice: int.parse(
                                    _priceEditingController.text.trim()),
                                serviceTitle:
                                    _titleEditingController.text.trim()));
                            _titleEditingController.clear();
                            _priceEditingController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Create')),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
