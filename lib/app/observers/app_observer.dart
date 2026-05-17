import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_startup_kit/core/logger/logger_service.dart';

class AppObserver extends BlocObserver {
  AppObserver({required LoggerService logger}) : _logger = logger;
  final LoggerService _logger;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.debug('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.error('${bloc.runtimeType} error', error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.debug('${bloc.runtimeType} event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.debug('${bloc.runtimeType} transition: $transition');
  }
}
