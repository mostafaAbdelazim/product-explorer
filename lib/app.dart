import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/products/presentation/pages/product_list_page.dart';

class ProductExplorerApp extends StatelessWidget {
  const ProductExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ProductListPage(),
    );
  }
}
