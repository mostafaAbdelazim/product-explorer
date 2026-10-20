import '../core/network/api_client.dart';
import '../features/products/data/datasources/product_remote_data_source.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../features/products/domain/repositories/product_repository.dart';
import '../features/products/domain/usecases/get_product_by_id.dart';
import '../features/products/domain/usecases/get_products.dart';
import '../features/products/presentation/bloc/product_detail_bloc.dart';
import '../features/products/presentation/bloc/product_list_bloc.dart';

/// Lightweight manual dependency container for the app.
class Injection {
  Injection._();

  static late final ApiClient apiClient;
  static late final ProductRemoteDataSource productRemoteDataSource;
  static late final ProductRepository productRepository;
  static late final GetProducts getProducts;
  static late final GetProductById getProductById;

  static void init() {
    apiClient = ApiClient();
    productRemoteDataSource = ProductRemoteDataSourceImpl(apiClient);
    productRepository = ProductRepositoryImpl(productRemoteDataSource);
    getProducts = GetProducts(productRepository);
    getProductById = GetProductById(productRepository);
  }

  static ProductListBloc createProductListBloc() {
    return ProductListBloc(getProducts: getProducts);
  }

  static ProductDetailBloc createProductDetailBloc() {
    return ProductDetailBloc(getProductById: getProductById);
  }
}
