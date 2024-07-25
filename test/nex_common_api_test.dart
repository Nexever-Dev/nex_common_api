import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nex_common_api/api_core/api_methods.dart';

void main() {
  test('adds one to input values', () async {
    var res =
        await ApiMethods().getMethod(url: 'https://dummyjson.com/products/1');
    debugPrint("RESPONSE CODE ==>> ${res.$1} DATA ===>>> ${res.$2}");
  });
}
