import 'package:flutter/material.dart';

class ModeDrawer extends StatelessWidget {
  const ModeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'GAMES',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: const Text('Finger Gang'),
          onTap: () {
            // Handle drawer item tap
          },
        ),
        ListTile(
          title: const Text('Finger Gang - Basic'),
          onTap: () {
            // Handle drawer item tap
          },
        ),
      ],
    );
  }
}
