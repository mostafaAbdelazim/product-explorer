part of 'product_list_bloc.dart';

enum ProductListStatus { initial, loading, success, failure }

class ProductListState extends Equatable {
  const ProductListState({
    this.status = ProductListStatus.initial,
    this.products = const [],
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  final ProductListStatus status;
  final List<Product> products;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? errorMessage;

  bool get isEmpty =>
      status == ProductListStatus.success && products.isEmpty;

  ProductListState copyWith({
    ProductListStatus? status,
    List<Product>? products,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProductListState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        hasReachedMax,
        isLoadingMore,
        errorMessage,
      ];
}
