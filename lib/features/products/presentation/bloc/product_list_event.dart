part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
}

final class ProductListStarted extends ProductListEvent {
  const ProductListStarted();
}

final class ProductListRefreshed extends ProductListEvent {
  const ProductListRefreshed();
}

final class ProductListLoadMore extends ProductListEvent {
  const ProductListLoadMore();
}
