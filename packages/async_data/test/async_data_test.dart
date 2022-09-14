import 'package:flutter_test/flutter_test.dart';

import 'package:async_data/async_value_notifier.dart';

void main() {
  test('when recreating the future, AsyncLoading contains the previous data if any', () async {
    final dep = AsyncValueNotifier<int>(() => Future.value(42));

    expect(
      dep.value,
      const AsyncLoading<int>(previous: AsyncInitial<int>()),
    );

    expect(
      dep.value,
      const AsyncData<int>(42),
    );

    dep.retry();

    expect(
      dep.value,
      const AsyncLoading<int>(previous: AsyncData(42)),
    );
  });
}
