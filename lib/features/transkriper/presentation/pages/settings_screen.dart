import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
              leading: Icon(Icons.price_change_rounded),
              title: Text('Our Plans'),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_back_ios_outlined)))
        ],
      ),
    );
  }
}
