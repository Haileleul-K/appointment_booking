import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skylightDemo/core/colors.dart';
import 'package:skylightDemo/core/utils/notification_service.dart';
import 'package:skylightDemo/features/auth/bloc/auth_bloc.dart';
import 'package:skylightDemo/routes.dart';
import 'dependency_injection.dart' as di;
import 'dependency_injection.dart';
import 'features/home/bloc/add_service/add_service_bloc.dart';
import 'features/home/bloc/delete_service/delete_service_bloc.dart';
import 'features/home/bloc/get_service/service_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeServiceLocator();
   await NotificationService().init();
await Hive.initFlutter();
requestNotificationPermission();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>(),
          
        ),
        BlocProvider(
          create: (context) => di.sl<ServiceBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AddServiceBloc>(),
          
          
        ),
        BlocProvider(
          create: (context) => sl<DeleteServiceBloc>(),
          
          
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(320, 658),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: Paths.login,
              builder: EasyLoading.init(),
              onGenerateRoute: AppNavigator.onGenerateRoute,
              navigatorKey: AppNavigator.navigatorKey,
            ));
  }
}
void initializeServiceLocator() {
  di.init();
}
Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.primaryAppColor
    ..backgroundColor = AppColors.secondaryAppColor
    ..indicatorColor = AppColors.primaryAppColor
    ..textColor = AppColors.primaryAppColor
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
