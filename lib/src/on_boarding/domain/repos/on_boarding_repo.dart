import 'package:education_app/core/utils/typedef.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  ResultVoid cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
