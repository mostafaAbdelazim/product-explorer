import 'package:injectable/injectable.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';
import '../models/product_page_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductPageModel> getProducts({required int limit, required int skip});

  Future<ProductModel> getProductById(int id);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<ProductPageModel> getProducts({
    required int limit,
    required int skip,
  }) async {
    final json = await _apiClient.get(
      ApiConstants.productsEndpoint,
      queryParameters: {
        'limit': limit,
        'skip': skip,
      },
    );
    return ProductPageModel.fromJson(json);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final json = await _apiClient.get('${ApiConstants.productsEndpoint}/$id');
    return ProductModel.fromJson(json);
  }
}
