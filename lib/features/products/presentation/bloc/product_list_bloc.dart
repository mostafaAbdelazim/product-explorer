import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc({required this.getProducts}) : super(const ProductListState()) {
    on<ProductListStarted>(_onStarted);
    on<ProductListRefreshed>(_onRefreshed);
    on<ProductListLoadMore>(_onLoadMore);
  }

  final GetProducts getProducts;

  Future<void> _onStarted(
    ProductListStarted event,
    Emitter<ProductListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProductListStatus.loading,
        clearError: true,
      ),
    );
    await _fetchFirstPage(emit);
  }

  Future<void> _onRefreshed(
    ProductListRefreshed event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(clearError: true));
    await _fetchFirstPage(emit);
  }

  Future<void> _onLoadMore(
    ProductListLoadMore event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true, clearError: true));

    try {
      final page = await getProducts(
        limit: ApiConstants.pageSize,
        skip: state.products.length,
      );

      emit(
        state.copyWith(
          status: ProductListStatus.success,
          products: [...state.products, ...page.products],
          hasReachedMax: !page.hasMore || page.products.isEmpty,
          isLoadingMore: false,
        ),
      );
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: const ServerFailure().message,
        ),
      );
    }
  }

  Future<void> _fetchFirstPage(Emitter<ProductListState> emit) async {
    try {
      final page = await getProducts(
        limit: ApiConstants.pageSize,
        skip: 0,
      );

      emit(
        state.copyWith(
          status: ProductListStatus.success,
          products: page.products,
          hasReachedMax: !page.hasMore || page.products.isEmpty,
          isLoadingMore: false,
          clearError: true,
        ),
      );
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          status: ProductListStatus.failure,
          isLoadingMore: false,
          errorMessage: failure.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProductListStatus.failure,
          isLoadingMore: false,
          errorMessage: const ServerFailure().message,
        ),
      );
    }
  }
}
