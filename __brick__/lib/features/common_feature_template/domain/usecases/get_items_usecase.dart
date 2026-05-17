import '../../../../core/base/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/base/either.dart';
import '../entities/feature_entity.dart';
import '../repositories/feature_repository.dart';

class GetItemsUseCase implements UseCase<List<FeatureEntity>, NoParams> {
  final FeatureRepository repository;

  GetItemsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FeatureEntity>>> call(NoParams params) {
    return repository.getItems();
  }
}
