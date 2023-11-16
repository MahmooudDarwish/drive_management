import 'package:driver_management/login/cubit/cubit.dart';
import 'package:driver_management/services/cache_helper.dart';
import 'package:driver_management/services/dio_helper.dart';
import 'package:driver_management/services/google_service.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///Dio helper
    sl.registerLazySingleton<DioHelper>(() => DioHelper());

    ///shared preferences
    sl.registerLazySingleton<CacheHelper>(() => CacheHelper());

    //Google Services
    sl.registerLazySingleton<GoogleService>(() => GoogleService());
    /// cubit
    sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  }
}
