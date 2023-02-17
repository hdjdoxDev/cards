import 'package:mypack/locator.dart';

import 'src/wist/game_vm.dart';
import 'src/wist/option_vm.dart';

void setupLocator() {
  // locator.registerLazySingletonAsync<LogSqflApi>(() => LogSqflApi.init());

  locator.registerFactory<WistOptionModel>(() => WistOptionModel());
  locator.registerFactory<WistGameModel>(() => WistGameModel());
}
