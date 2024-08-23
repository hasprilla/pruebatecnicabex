import 'package:flutter/material.dart';

import 'app/di/di.dart';
import 'core/core.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.getDatabase();
  await initDependencies();
  runApp(const MyApp());
}
