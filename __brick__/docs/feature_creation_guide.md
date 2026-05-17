# Feature Creation Guide

## Creating a New Feature

Use the template at `lib/features/common_feature_template/` as a starting point.

### Step 1: Create Feature Directory

```bash
mkdir -p lib/features/feature_name/{data/{datasources/remote,datasources/local,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages,widgets},di}
```

### Step 2: Define Entity

```dart
// lib/features/feature_name/domain/entities/feature_entity.dart
class FeatureEntity {
  final String id;
  final String name;
  const FeatureEntity({required this.id, required this.name});
}
```

### Step 3: Define Repository Interface

```dart
// lib/features/feature_name/domain/repositories/feature_repository.dart
abstract class FeatureRepository {
  Future<Either<Failure, List<FeatureEntity>>> getItems();
  Future<Either<Failure, FeatureEntity>> getItem(String id);
}
```

### Step 4: Create Use Cases

```dart
// lib/features/feature_name/domain/usecases/get_items.dart
class GetItems implements UseCase<List<FeatureEntity>, NoParams> {
  final FeatureRepository repository;
  GetItems(this.repository);
  
  @override
  Future<Either<Failure, List<FeatureEntity>>> call(NoParams params) {
    return repository.getItems();
  }
}
```

### Step 5: Create Data Sources

```dart
// lib/features/feature_name/data/datasources/remote/feature_remote_datasource.dart
class FeatureRemoteDataSource {
  final DioClient dioClient;
  FeatureRemoteDataSource({required this.dioClient});
  
  Future<List<FeatureModel>> getItems() async {
    final response = await dioClient.get('/items');
    return (response.data as List).map((json) => FeatureModel.fromJson(json)).toList();
  }
}
```

### Step 6: Create Models

```dart
// lib/features/feature_name/data/models/feature_model.dart
class FeatureModel {
  final String id;
  final String name;
  const FeatureModel({required this.id, required this.name});
  factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(id: json['id'], name: json['name']);
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
```

### Step 7: Implement Repository

```dart
// lib/features/feature_name/data/repositories/feature_repository_impl.dart
class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureRemoteDataSource remoteDataSource;
  FeatureRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, List<FeatureEntity>>> getItems() async {
    try {
      final models = await remoteDataSource.getItems();
      return Right(models.map((m) => FeatureEntity(id: m.id, name: m.name)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
```

### Step 8: Create Bloc

```dart
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final GetItems getItems;
  FeatureBloc({required this.getItems}) : super(FeatureInitial()) {
    on<GetItemsEvent>(_onGetItems);
  }
}
```

### Step 9: Register DI

```dart
// lib/features/feature_name/di/feature_injection.dart
void configureFeatureDependencies() {
  sl.registerFactory(() => FeatureRemoteDataSource(dioClient: sl()));
  sl.registerFactory<FeatureRepository>(() => FeatureRepositoryImpl(remoteDataSource: sl()));
  sl.registerFactory(() => GetItems(sl()));
  sl.registerFactory(() => FeatureBloc(getItems: sl()));
}
```

### Step 10: Add Routes

Add route to `lib/app/routes/app_router.dart`.
