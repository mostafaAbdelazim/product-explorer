import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_explorer/app.dart';
import 'package:product_explorer/injection/injection.dart';

class _FakeProductsAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final body = jsonEncode({
      'products': <Map<String, dynamic>>[],
      'total': 0,
      'skip': 0,
      'limit': 10,
    });

    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await configureDependencies();
    getIt<Dio>().httpClientAdapter = _FakeProductsAdapter();
  });

  testWidgets('Product Explorer app builds', (tester) async {
    await tester.pumpWidget(const ProductExplorerApp());
    expect(find.text('Product Explorer'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('No products found'), findsOneWidget);
  });
}
