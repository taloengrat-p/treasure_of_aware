import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treasure_of_aware/screens/ranking/ranking_screen.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.session.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (BuildContext context, SessionState state) {
        if (state is SessionInitialSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RankingScreen()),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Treasure of Aware",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(height: 16),
                BlocBuilder<SessionCubit, SessionState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state is SessionInitialLoading,
                      child: CircularProgressIndicator.adaptive(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
