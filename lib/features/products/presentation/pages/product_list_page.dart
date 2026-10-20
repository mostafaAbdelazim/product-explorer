import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection/injection.dart';
import '../bloc/product_list_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/state_views.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductListBloc>()..add(const ProductListStarted()),
      child: const _ProductListView(),
    );
  }
}

class _ProductListView extends StatefulWidget {
  const _ProductListView();

  @override
  State<_ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<_ProductListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isNearBottom) return;
    context.read<ProductListBloc>().add(const ProductListLoadMore());
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Explorer'),
      ),
      body: BlocConsumer<ProductListBloc, ProductListState>(
        listenWhen: (previous, current) =>
            current.errorMessage != null &&
            current.status == ProductListStatus.success &&
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          final message = state.errorMessage;
          if (message == null) return;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () => context
                      .read<ProductListBloc>()
                      .add(const ProductListLoadMore()),
                ),
              ),
            );
        },
        builder: (context, state) {
          switch (state.status) {
            case ProductListStatus.initial:
            case ProductListStatus.loading:
              return const LoadingView();
            case ProductListStatus.failure:
              return ErrorView(
                message: state.errorMessage ?? 'Unable to load products.',
                onRetry: () => context
                    .read<ProductListBloc>()
                    .add(const ProductListStarted()),
              );
            case ProductListStatus.success:
              if (state.isEmpty) {
                return EmptyView(
                  onRetry: () => context
                      .read<ProductListBloc>()
                      .add(const ProductListRefreshed()),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProductListBloc>()
                      .add(const ProductListRefreshed());
                  await context.read<ProductListBloc>().stream.firstWhere(
                        (s) =>
                            s.status == ProductListStatus.success ||
                            s.status == ProductListStatus.failure,
                      );
                },
                child: ListView.separated(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: state.products.length +
                      (state.hasReachedMax ? 0 : 1),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index >= state.products.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final product = state.products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ProductDetailPage(
                              productId: product.id,
                              initialTitle: product.title,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
