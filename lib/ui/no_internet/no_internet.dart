import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_helper/cubit/connectivity/connectivity_cubit.dart';
import 'package:shop_helper/ui/home/home_screen.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback voidCallback;

  const NoInternetScreen({required this.voidCallback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state.connectivityResult != ConnectivityResult.none) {
            voidCallback.call();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false);
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(
                    Icons.signal_cellular_connected_no_internet_0_bar,size: 70),
              ),
              const SizedBox(
                height: 50,
              ),
              Text("Internet connection not found!!!",
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}
