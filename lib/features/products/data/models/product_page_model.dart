import '../../domain/entities/product_page.dart';
import 'product_model.dart';

class ProductPageModel extends ProductPage {
  const ProductPageModel({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory ProductPageModel.fromJson(Map<String, dynamic> json) {
    final productsJson = json['products'] as List<dynamic>? ?? const [];

    return ProductPageModel(
      products: productsJson
          .whereType<Map<String, dynamic>>()
          .map(ProductModel.fromJson)
          .toList(),
      total: json['total'] as int? ?? 0,
      skip: json['skip'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
    );
  }

  ProductPage toEntity() => this;
}
