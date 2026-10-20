import '../../domain/entities/product_page.dart';
import '../models/product_page_model.dart';
import 'product_mapper.dart';

class ProductPageMapper {
  const ProductPageMapper._();

  static ProductPage toEntity(ProductPageModel model) {
    return ProductPage(
      products: ProductMapper.toEntityList(model.products),
      total: model.total,
      skip: model.skip,
      limit: model.limit,
    );
  }

  static ProductPageModel toModel(ProductPage entity) {
    return ProductPageModel(
      products: ProductMapper.toModelList(entity.products),
      total: entity.total,
      skip: entity.skip,
      limit: entity.limit,
    );
  }
}
