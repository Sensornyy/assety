// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:assety/core/data/managers/auth_manager.dart' as _i915;
import 'package:assety/core/data/managers/dio_manager.dart' as _i268;
import 'package:assety/core/data/managers/user_manager.dart' as _i247;
import 'package:assety/core/di/injection_modules.dart' as _i200;
import 'package:assety/features/auth/data/repository/auth_repository_impl.dart'
    as _i69;
import 'package:assety/features/auth/domain/repository/auth_repository.dart'
    as _i598;
import 'package:assety/features/investments/crypto/data/repository/crypto_repository_impl.dart'
    as _i534;
import 'package:assety/features/investments/crypto/domain/repository/crypto_repository.dart'
    as _i786;
import 'package:assety/features/user/data/repository/user_repository_impl.dart'
    as _i224;
import 'package:assety/features/user/domain/repository/user_repository.dart'
    as _i448;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.singleton<_i59.FirebaseAuth>(() => injectionModule.firebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => injectionModule.googleSignIn);
    gh.singleton<_i361.Dio>(() => injectionModule.dio);
    gh.singleton<_i993.Talker>(() => injectionModule.talker);
    gh.singleton<_i247.UserManager>(() => _i247.UserManager());
    gh.singleton<_i268.DioManager>(() => _i268.DioManager(
          gh<_i361.Dio>(),
          gh<_i993.Talker>(),
        ));
    gh.singleton<_i915.AuthManager>(() => _i915.AuthManager(
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
        ));
    gh.factory<_i448.UserRepository>(() => _i224.UserRepositoryImpl(
          gh<_i247.UserManager>(),
          gh<_i915.AuthManager>(),
        ));
    gh.factory<_i786.CryptoRepository>(
        () => _i534.CryptoRepositoryImpl(gh<_i268.DioManager>()));
    gh.factory<_i598.AuthRepository>(
        () => _i69.AuthRepositoryImpl(gh<_i915.AuthManager>()));
    return this;
  }
}

class _$InjectionModule extends _i200.InjectionModule {}
