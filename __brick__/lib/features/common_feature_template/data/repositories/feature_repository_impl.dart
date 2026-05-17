import '../../../../core/base/either.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/feature_entity.dart';
import '../../domain/repositories/feature_repository.dart';

class FeatureRepositoryImpl implements FeatureRepository {
  @override
  Future<Either<Failure, List<FeatureEntity>>> getItems() async {
    return Either.right([]);
  }
}
