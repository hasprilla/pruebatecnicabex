import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingMenu extends StatelessWidget {
  const FloatingMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Theme.of(context).colorScheme.primary,
      animatedIconTheme: Theme.of(context).primaryIconTheme,
      spacing: 1,
      spaceBetweenChildren: 3,
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.people),
          label: 'Estudiantes',
          onTap: () => Navigator.of(context).pushNamed('/students'),
        ),
      ],
    );
  }
}
