import '../entities/product_page.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  const GetProducts(this._repository);

  final ProductRepository _repository;

  Future<ProductPage> call({required int limit, required int skip}) {
    return _repository.getProducts(limit: limit, skip: skip);
  }
}
