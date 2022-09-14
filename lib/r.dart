import 'package:flutter/material.dart';

class R {
  const R._();

  static _AppColors get colors => const _AppColors._();

  static _AppStyles get styles => const _AppStyles._();

  static _EnvironmentVariableKeys get envKeys => const _EnvironmentVariableKeys._();

  static _AppEndpoints get endpoints => const _AppEndpoints._();

}

class _AppColors {
  const _AppColors._();

//todo: add colors
}

class _AppStyles {
  const _AppStyles._();

//todo: add Styles
}

class _EnvironmentVariableKeys {
  const _EnvironmentVariableKeys._();

  String get apiKey => 'API_KEY';

  String get apiBaseUrl => 'BASE_URL';
}

class _AppEndpoints {
  const _AppEndpoints._();

  String get imagesBaseUrl => 'https://image.tmdb.org/t/p/w185_and_h278_bestv2';

}
