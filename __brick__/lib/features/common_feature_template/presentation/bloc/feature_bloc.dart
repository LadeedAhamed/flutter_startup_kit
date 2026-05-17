import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/feature_entity.dart';
import '../../domain/usecases/get_items_usecase.dart';
import '../../../../core/base/usecase.dart';

// Events
abstract class FeatureEvent extends Equatable {
  const FeatureEvent();

  @override
  List<Object?> get props => [];
}

class GetItemsEvent extends FeatureEvent {}

// States
abstract class FeatureState extends Equatable {
  const FeatureState();

  @override
  List<Object?> get props => [];
}

class FeatureInitial extends FeatureState {}

class FeatureLoading extends FeatureState {}

class FeatureLoaded extends FeatureState {
  final List<FeatureEntity> items;

  const FeatureLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class FeatureError extends FeatureState {
  final String message;

  const FeatureError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final GetItemsUseCase getItemsUseCase;

  FeatureBloc({required this.getItemsUseCase}) : super(FeatureInitial()) {
    on<GetItemsEvent>(_onGetItems);
  }

  Future<void> _onGetItems(GetItemsEvent event, Emitter<FeatureState> emit) async {
    emit(FeatureLoading());
    final result = await getItemsUseCase(NoParams());
    result.fold(
      (failure) => emit(FeatureError(message: failure.message)),
      (items) => emit(FeatureLoaded(items: items)),
    );
  }
}
