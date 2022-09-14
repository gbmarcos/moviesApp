import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'async_data_bloc.dart';

///Wraps a [BlocBuilder] and its only advantage with it is a less verbose use of
///generic parameters from :
/// ```
/// BlocBuilder<AsyncCubit<List<LatestMatch>>, AsyncValue<List<String>>>(
///  bloc: latestNames,
///  builder: (_, state) {...});
/// ```
/// To:
/// ```
/// AsyncCubitBuilder<List<String>>(
///  bloc: latestNames,
///  builder: (_, state) {...});
/// ```
class AsyncCubitBuilder<T> extends StatelessWidget {
  final AsyncCubit<T> bloc;
  final BlocWidgetBuilder<AsyncValue<T>> builder;
  final BlocBuilderCondition<AsyncValue<T>>? buildWhen;

  const AsyncCubitBuilder({Key? key, required this.bloc, required this.builder, this.buildWhen}) : super(key: key);

  @override
  Widget build(context) =>
      BlocBuilder<AsyncCubit<T>, AsyncValue<T>>(
        bloc: bloc,
        builder: builder,
        buildWhen: buildWhen ??
                (previous, current) {
              return previous != current;
            },
      );
}

class AsyncCubitListBuilder<T> extends StatelessWidget {
  final AsyncCubit<Iterable<T>> bloc;
  final Widget Function(AsyncInitial<Iterable<T>> initial)? initial;
  final ListItemBuilder<T> itemBuilder;
  final Widget Function(AsyncError<Iterable<T>> error)? error;
  final Widget Function(AsyncLoading<Iterable<T>> loading)? loading;
  final Widget Function()? orElse;
  final BlocBuilderCondition<AsyncValue<Iterable<T>>>? buildWhen;
  final List<Widget> Function(AsyncValue<Iterable<T>>)? prepend;
  final List<Widget> Function(AsyncValue<Iterable<T>>)? append;

  const AsyncCubitListBuilder({
    Key? key,
    required this.bloc,
    required this.itemBuilder,
    this.orElse,
    this.buildWhen,
    this.prepend,
    this.append,
    this.initial,
    this.error,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(context) {
    return BlocBuilder<AsyncCubit<Iterable<T>>, AsyncValue<Iterable<T>>>(
      bloc: bloc,
      buildWhen: buildWhen ??
              (previous, current) {
            return previous != current;
          },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
                  if (prepend != null )
                    ...prepend!(state),

                  state.maybeMap(error: error, loading: loading, orElse: orElse ?? () => const SizedBox.shrink()),
                  if (state.valueOrNull != null)
                    for (final item in state.valueOrNull!) itemBuilder(context, item),

                  if (append != null )
                    ...append!(state),
                ])),
          ],
        );
      },
    );
  }
}
typedef ListItemBuilder<T> = Widget Function(BuildContext context, T item);
typedef ItemBuilder = Widget Function();
