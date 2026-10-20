import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_model.dart';

part 'product_page_model.freezed.dart';
part 'product_page_model.g.dart';

@freezed
abstract class ProductPageModel with _$ProductPageModel {
  const factory ProductPageModel({
    @Default(<ProductModel>[]) List<ProductModel> products,
    @Default(0) int total,
    @Default(0) int skip,
    @Default(0) int limit,
  }) = _ProductPageModel;

  factory ProductPageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPageModelFromJson(json);
}
