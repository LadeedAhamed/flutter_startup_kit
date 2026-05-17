import '../../../../core/base/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/base/either.dart';
import '../entities/feature_entity.dart';
import '../repositories/feature_repository.dart';

class GetItemsUseCase implements UseCase<List<FeatureEntity>, NoParams> {

  GetItemsUseCase(this.repository);
  final FeatureRepository repository;

  @override
  Future<Either<Failure, List<FeatureEntity>>> call(NoParams params) {
    return repository.getItems();
  }
}
