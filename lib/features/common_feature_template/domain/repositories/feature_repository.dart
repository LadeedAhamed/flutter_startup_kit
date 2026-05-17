import '../../../../core/errors/failures.dart';
import '../../../../core/base/either.dart';
import '../entities/feature_entity.dart';

abstract class FeatureRepository {
  Future<Either<Failure, List<FeatureEntity>>> getItems();
}
