import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc({required this.getProductById})
      : super(const ProductDetailState()) {
    on<ProductDetailRequested>(_onRequested);
    on<ProductDetailRetried>(_onRetried);
  }

  final GetProductById getProductById;

  Future<void> _onRequested(
    ProductDetailRequested event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProductDetailStatus.loading,
        productId: event.productId,
        clearError: true,
        clearProduct: true,
      ),
    );
    await _load(event.productId, emit);
  }

  Future<void> _onRetried(
    ProductDetailRetried event,
    Emitter<ProductDetailState> emit,
  ) async {
    final id = state.productId;
    if (id == null) return;

    emit(
      state.copyWith(
        status: ProductDetailStatus.loading,
        clearError: true,
      ),
    );
    await _load(id, emit);
  }

  Future<void> _load(int id, Emitter<ProductDetailState> emit) async {
    try {
      final product = await getProductById(id);
      emit(
        state.copyWith(
          status: ProductDetailStatus.success,
          product: product,
          clearError: true,
        ),
      );
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          status: ProductDetailStatus.failure,
          errorMessage: failure.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProductDetailStatus.failure,
          errorMessage: const ServerFailure().message,
        ),
      );
    }
  }
}
