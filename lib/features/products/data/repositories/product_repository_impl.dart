import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_page.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../mappers/product_mapper.dart';
import '../mappers/product_page_mapper.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<ProductPage> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final result = await _remoteDataSource.getProducts(
        limit: limit,
        skip: skip,
      );
      return ProductPageMapper.toEntity(result);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const ServerFailure();
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    try {
      final result = await _remoteDataSource.getProductById(id);
      return ProductMapper.toEntity(result);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const ServerFailure();
    }
  }
}
