import 'dart:async';

import 'package:newsreader/utils.dart';

class SelectControllerBloc {
  final StreamController<Object> categoryController =
      StreamController.broadcast();
  final StreamController<Object> countryController =
      StreamController.broadcast();
  String defaultCategory = categories[0];
  String defaultCountry = 'us';

  Stream<Object> get categoryStream => categoryController.stream;

  Stream<Object> get countryStream => countryController.stream;

  void selectCategory(String category) {
    categoryController.sink.add(category);
  }

  void selectCountry(String country) {
    countryController.sink.add(country);
  }

  dispose() {
    categoryController.close();
    countryController.close();
  }
}
