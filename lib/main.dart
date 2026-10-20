import 'package:flutter/material.dart';

import 'app.dart';
import 'injection/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injection.init();
  runApp(const ProductExplorerApp());
}
