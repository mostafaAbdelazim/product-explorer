import 'package:flutter_test/flutter_test.dart';
import 'package:product_explorer/app.dart';
import 'package:product_explorer/injection/injection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(Injection.init);

  testWidgets('Product Explorer app builds', (tester) async {
    await tester.pumpWidget(const ProductExplorerApp());
    expect(find.text('Product Explorer'), findsOneWidget);
  });
}
