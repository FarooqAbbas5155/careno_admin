import 'package:careno_admin/view/authentication/screen_login.dart';
import 'package:careno_admin/view/screens/screen_provider_details.dart';
import 'package:careno_admin/view/screens/screen_vehicle_details.dart';
import 'package:careno_admin/widgets/custom_error.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'constant/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Keep only one Firebase.initializeApp() call for all platforms
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD0nqeCeY8kwLDhnOLdmMw8ke6SPHq-fBA",
        authDomain: "careno-app.firebaseapp.com",
        projectId: "careno-app",
        storageBucket: "careno-app.appspot.com",
        messagingSenderId: "246128826023",
        appId: "1:246128826023:web:12d3be65b91b5b300ded82",
        measurementId: "G-CSNZYF8QKQ"

    ),
  );
  runApp(const MyApp());
}
void colorConfig() {
  MaterialColor appPrimaryColor = MaterialColor(
    0xFF4C0AE1,
    const <int, Color>{
      50: const Color(0xFF4C0AE1),
      100: const Color(0xFF4C0AE1),
      200: const Color(0xFF4C0AE1),
      300: const Color(0xFF4C0AE1),
      400: const Color(0xFF4C0AE1),
      500: const Color(0xFF4C0AE1),
      600: const Color(0xFF4C0AE1),
      700: const Color(0xFF4C0AE1),
      800: const Color(0xFF4C0AE1),
      900: const Color(0xFF4C0AE1),
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:  Size(1578, 1024),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
            // home: ScreenAthleteHomePage(),
            home: ScreenVehicleDetails(),
            locale: Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fade,
            title: "Careno",
            theme: ThemeData(

              fontFamily: 'Urbanist',
              primarySwatch: AppColors.appPrimaryColor,
              radioTheme: RadioThemeData(
                fillColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Color(0xFF505050); // Selected color
                  }
                  return const Color(0xFFD0D5DD); // Unselected color
                }),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashRadius: 4.0, // Adjust the splash radius if needed
                visualDensity: VisualDensity.standard,
              ),
              checkboxTheme: CheckboxThemeData(
                checkColor: MaterialStateProperty.all(Colors.white),
                fillColor: MaterialStateProperty.all(AppColors.appPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),

                side: BorderSide(color: Color(0xff585858), width: 1),
              ),
              appBarTheme: AppBarTheme(
                // color: Colors.white,
                backgroundColor: AppColors.backGroundColor,
                foregroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Urbanist"),
                centerTitle: false,
                systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                iconTheme: IconThemeData(color: Colors.black),
              ),

              dividerColor: Colors.transparent,
              scaffoldBackgroundColor: AppColors.backGroundColor,
              backgroundColor: Colors.white,
              useMaterial3: false,


            ),

            builder: (context, widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomError(errorDetails: errorDetails);
              };
              return ScrollConfiguration(
                  behavior: NoColorScrollBehavior(), child: widget!);
            },
          );
        });
  }
}
class NoColorScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}



