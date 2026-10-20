import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String category,
    @Default(0) double price,
    @Default(0) double discountPercentage,
    @Default(0) double rating,
    @Default(0) int stock,
    @Default('Unknown') String brand,
    @Default('') String thumbnail,
    @Default(<String>[]) List<String> images,
    @Default('Unknown') String availabilityStatus,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
