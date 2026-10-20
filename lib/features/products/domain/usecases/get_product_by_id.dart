import 'package:injectable/injectable.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class GetProductById {
  GetProductById(this._repository);

  final ProductRepository _repository;

  Future<Product> call(int id) {
    return _repository.getProductById(id);
  }
}
