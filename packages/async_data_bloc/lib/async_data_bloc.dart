library async_data_bloc;

import 'package:async_data/async_value.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
export 'package:async_data/async_value_notifier.dart';
export 'package:async_data/async_value.dart';
export 'async_cubit_builder.dart';
export 'async_widget.dart';

/// Policy that the [AsyncCubit] will use to update the state in case of [refresh]
enum RefreshPolicy {
  ///Cycles through the loading state again even if there was a previous value
  reset,

  /// Updates the state only if the result of calling [refresh] is an [AsyncData] (success)
  onData,

  /// Does not displays the [AsyncLoading] state again if there was a previous state
  /// but it does update the [AsyncCubit] with the new result either if it is an [AsyncData] or [AsyncError]
  noLoading,
}

/// A [Cubit]  for asynchronous operations.
/// The commodity is that the Future is guarded by an [AsyncValue].
/// So the different states of the Future can only be interacted as a sealed class.
/// And also is refresh-able
class AsyncCubit<T> extends Cubit<AsyncValue<T>> {
  Future<T> Function() _future;
  final RefreshPolicy _refreshPolicy;
  late bool _running = false;

  AsyncCubit(this._future, {AsyncValue<T>? initialValue, RefreshPolicy refreshPolicy = RefreshPolicy.reset})
      : _refreshPolicy = refreshPolicy,
        super(initialValue ?? AsyncValue<T>.initial()) {
    if (super.state is AsyncInitial<T>) _run();
  }

  ///Constructor meant to `stub` the AsyncCubit until it's later properly initialized:
  ///When can this happen, maybe you need to wait for an async computation in order to initialize an
  ///[AsyncCubit]. Eg:
  ///```
  /// //Stub the value in case its accessed from outside the object
  ///final director=AsyncCubit.stub();
  ///
  ///final movie=await repository.getMovie(478);
  /// // Change the Cubit's future once the desired value is available
  ///director.changeFuture=()=>repository.getDirector(movie.directorId);
  /// ```
  ///
  factory AsyncCubit.stub({AsyncValue<T>? initialValue = const AsyncLoading()}) =>
      AsyncCubit(() => Future.value(), initialValue: initialValue);

  ///Returns true if the computation ended in an [AsyncData] or [AsyncError].
  bool get canRetry => !_running;

  bool refresh() {
    if (canRetry) {
      _run();
      return true;
    }
    return false;
  }

  ///Changes the Future/Async function that the cubit emits values for.
  /// Useful when adding/removing parameters from a request rather than making the same request
  set changeFuture(Future<T> Function() newFuture) {
    this._future = newFuture;
    refresh();
  }

  void _run() async {
    final bool isInitial = state is AsyncInitial;
    _running = true;

    try {
      if (isInitial || !(_refreshPolicy == RefreshPolicy.onData || _refreshPolicy == RefreshPolicy.noLoading)) {
        emit(AsyncValue<T>.loading(previous: state));
      }
      _future().then(
        (event) {
          if (_running) emit(AsyncValue<T>.data(event));
          _running = false;
        },
        // ignore: avoid_types_on_closure_parameters
        onError: (Object err, StackTrace stack) {
          if (_running && _refreshPolicy != RefreshPolicy.onData) {
            emit(AsyncValue<T>.error(err, stack));
          }
          _running = false;
          if (kDebugMode) {
            print(err);
            print(stack);
          }

        },
      );
    } catch (e, stack) {
      if (_refreshPolicy != RefreshPolicy.onData) {
        emit(AsyncValue.error(e, stack));
      }
      _running = false;
    }
  }
}
