import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_helper/buy_bloc/buy_bloc.dart';
import 'package:shop_helper/cubit/connectivity/connectivity_cubit.dart';
import 'package:shop_helper/ui/home/home_screen.dart';
import 'package:shop_helper/ui/no_internet/no_internet.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => BuyBloc()),
      BlocProvider(create: (context) => ConnectivityCubit()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocListener<ConnectivityCubit, ConnectivityState>(
            listener: (context, state) {
              if (state.connectivityResult == ConnectivityResult.none) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoInternetScreen(voidCallback: () {}),
                    ),
                    (route) => false);
              }
            },
            child: const HomeScreen(),
          ),
        );
      },
    );
  }
}
