import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/bloc.dart';
import 'package:transkriptor/features/transkriper/presentation/pages/home_screen.dart';
import 'package:transkriptor/features/transkriper/presentation/pages/records_screen.dart';
import 'package:transkriptor/features/transkriper/presentation/pages/settings_screen.dart';
import 'package:transkriptor/features/transkriper/presentation/widgets/custom_bottom_bar.dart';

import '../../../../core/theme/colors.dart';
import 'transkripts_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  _changeScreen(int index,BuildContext context)async {
    _index = index;
    if(index==2){
      await BlocProvider.of<TranskripBloc>(context).getTranskripts();
    }
    setState(() {});
  }

  List<Widget> sceens = const [
    HomeScreen(),
    Records(),
    Transkripts(),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(child: sceens[_index]),
      bottomNavigationBar: BottomBar(
        index: _index,
        onSelect:(index)async=>await _changeScreen(index,context),
      ),
    );
  }
}
