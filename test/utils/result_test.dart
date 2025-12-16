import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/utils/result/result.dart';

void main() {
  group("Result test group", () {
    test("Ok result test", () {
      final result = Result.ok("Ok");

      expect(result, isA<Ok<String>>());
      expect(result.asOk().value, equals("Ok"));
    });

    test("Error test", () {
      final exception = Exception("An error occurred");
      final result = Result.error(exception);

      expect(result, isA<Error<dynamic>>());
      expect(result.asError().error, equals(exception));
    });

    test("Ok result with extension test", () {
      final result = "Ok".ok();

      expect(result, isA<Ok<dynamic>>());
      expect(result.asOk().value, equals("Ok"));
    });

    test("Error result with extension test", () {
      final exception = Exception("An error occurred");
      final result = exception.error();

      expect(result, isA<Error<dynamic>>());
      expect(result.asError().error, equals(exception));
    });
  });
}
