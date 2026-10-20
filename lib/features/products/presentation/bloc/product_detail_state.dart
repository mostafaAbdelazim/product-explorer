part of 'product_detail_bloc.dart';

enum ProductDetailStatus { initial, loading, success, failure }

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.product,
    this.errorMessage,
    this.productId,
  });

  final ProductDetailStatus status;
  final Product? product;
  final String? errorMessage;
  final int? productId;

  ProductDetailState copyWith({
    ProductDetailStatus? status,
    Product? product,
    String? errorMessage,
    int? productId,
    bool clearError = false,
    bool clearProduct = false,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      product: clearProduct ? null : product ?? this.product,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      productId: productId ?? this.productId,
    );
  }

  @override
  List<Object?> get props => [status, product, errorMessage, productId];
}
