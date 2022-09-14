import 'package:flutter/material.dart';

import 'async_data_bloc.dart';

/// Widget that will be displayed when a given view is Loading.
/// This will be generally be a [CircularProgressIndicator] for single elements
/// or a Skeleton UI or Shimmer for lists
mixin LoadingUI on Widget {
  Widget onLoading(BuildContext context, {double? progress}) =>
      const Center(child: CircularProgressIndicator.adaptive());
}

/// Widget that will be displayed when a given view shows an error.
mixin ErrorUI on Widget {
  /// The [refreshable] parameter is used to determine if the user can refresh the UI
  /// The [exception] is used to determine which widget to display with more granularity.
  Widget onError(BuildContext context, {bool refreshable = false, required Object exception}) =>
      const SizedBox.shrink();
}

/// Widget that will be displayed BEFORE a view loads.
mixin InitialUI on Widget {
  Widget onInitial(BuildContext context) => const SizedBox.shrink();
}

abstract class AsyncWidget<T> extends StatelessWidget with LoadingUI, ErrorUI, InitialUI {
  final T data;

  const AsyncWidget({Key? key, required this.data}) : super(key: key);
}

// Generic AsyncValueWidget to work with values of type T
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({Key? key, required this.value, required this.data}) : super(key: key);

  // input async value
  final AsyncData<T> value;

  // output builder function
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      initial: (_) => const Center(child: CircularProgressIndicator()),
      loading: (_) => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(
        child: Text(
          e.toString(),
          style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
