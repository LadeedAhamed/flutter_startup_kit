import 'package:equatable/equatable.dart';

abstract class Either<L, R> extends Equatable {
  const Either();

  factory Either.left(L value) => _Left(value);
  factory Either.right(R value) => _Right(value);

  bool get isLeft => this is _Left<L, R>;
  bool get isRight => this is _Right<L, R>;

  L get left => (this as _Left<L, R>).value;
  R get right => (this as _Right<L, R>).value;

  T fold<T>(T Function(L) leftFn, T Function(R) rightFn) {
    if (isLeft) return leftFn(left);
    return rightFn(right);
  }
}

class _Left<L, R> extends Either<L, R> {
  const _Left(this.value);
  final L value;

  @override
  List<Object?> get props => [value];
}

class _Right<L, R> extends Either<L, R> {
  const _Right(this.value);
  final R value;

  @override
  List<Object?> get props => [value];
}
