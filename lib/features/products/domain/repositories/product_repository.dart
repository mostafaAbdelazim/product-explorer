import '../entities/product.dart';
import '../entities/product_page.dart';

abstract class ProductRepository {
  Future<ProductPage> getProducts({required int limit, required int skip});

  Future<Product> getProductById(int id);
}
