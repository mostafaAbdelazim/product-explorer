// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:product_explorer/core/network/api_client.dart' as _i553;
import 'package:product_explorer/features/products/data/datasources/product_remote_data_source.dart'
    as _i268;
import 'package:product_explorer/features/products/data/repositories/product_repository_impl.dart'
    as _i509;
import 'package:product_explorer/features/products/domain/repositories/product_repository.dart'
    as _i788;
import 'package:product_explorer/features/products/domain/usecases/get_product_by_id.dart'
    as _i577;
import 'package:product_explorer/features/products/domain/usecases/get_products.dart'
    as _i30;
import 'package:product_explorer/features/products/presentation/bloc/product_detail_bloc.dart'
    as _i567;
import 'package:product_explorer/features/products/presentation/bloc/product_list_bloc.dart'
    as _i848;
import 'package:product_explorer/injection/register_module.dart' as _i838;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i553.ApiClient>(() => _i553.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i268.ProductRemoteDataSource>(
      () => _i268.ProductRemoteDataSourceImpl(gh<_i553.ApiClient>()),
    );
    gh.lazySingleton<_i788.ProductRepository>(
      () => _i509.ProductRepositoryImpl(gh<_i268.ProductRemoteDataSource>()),
    );
    gh.factory<_i577.GetProductById>(
      () => _i577.GetProductById(gh<_i788.ProductRepository>()),
    );
    gh.factory<_i30.GetProducts>(
      () => _i30.GetProducts(gh<_i788.ProductRepository>()),
    );
    gh.factory<_i567.ProductDetailBloc>(
      () => _i567.ProductDetailBloc(gh<_i577.GetProductById>()),
    );
    gh.factory<_i848.ProductListBloc>(
      () => _i848.ProductListBloc(gh<_i30.GetProducts>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i838.RegisterModule {}
