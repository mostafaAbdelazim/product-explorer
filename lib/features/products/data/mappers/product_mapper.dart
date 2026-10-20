import '../../domain/entities/product.dart';
import '../models/product_model.dart';

class ProductMapper {
  const ProductMapper._();

  static Product toEntity(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category,
      price: model.price,
      discountPercentage: model.discountPercentage,
      rating: model.rating,
      stock: model.stock,
      brand: model.brand,
      thumbnail: model.thumbnail,
      images: List<String>.unmodifiable(model.images),
      availabilityStatus: model.availabilityStatus,
    );
  }

  static ProductModel toModel(Product entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      price: entity.price,
      discountPercentage: entity.discountPercentage,
      rating: entity.rating,
      stock: entity.stock,
      brand: entity.brand,
      thumbnail: entity.thumbnail,
      images: List<String>.from(entity.images),
      availabilityStatus: entity.availabilityStatus,
    );
  }

  static List<Product> toEntityList(List<ProductModel> models) {
    return models.map(toEntity).toList(growable: false);
  }

  static List<ProductModel> toModelList(List<Product> entities) {
    return entities.map(toModel).toList(growable: false);
  }
}
