import 'package:dartz/dartz.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late CacheFirstTimer usecase;
  late OnBoardingRepo repository;

  setUp(() {
    repository = MockOnBoardindRepo();
    usecase = CacheFirstTimer(repository);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer] '
    'and return the right data',
    () async {
      when(() => repository.cacheFirstTimer())
          .thenAnswer((_) async => const Right(null));

      final result = await usecase();

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repository.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
