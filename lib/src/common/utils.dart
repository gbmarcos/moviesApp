import 'package:fpdart/fpdart.dart';

/// Used for unwrapping an Either Left as an Exception. Useful when catching the exception is preferred to delaing
/// with Sum types.
R getOrThrow<L extends Exception, R>(Either<L, R> either) => either.getOrElse((l) => throw l);

