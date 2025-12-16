import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/utils/commands/commands.dart';
import 'package:mvvm_example/utils/result/result.dart';

void main() {
  group("Command1 tests", () {
    test("Should test Command1 returns OK", () async {
      final command = Command1<String, int>(getOkResultWithInput);

      expect(command.completed, false);
      expect(command.isRunning, false);
      expect(command.error, false);
      expect(command.result, null);

      await command.execute(42);

      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, isNotNull);
      expect(command.result!.asOk().value, "Success with input 42");
    });

    test("Should test Command1 returns Error", () async {
      final command = Command1<bool, int>(getErrorResultWithInput);

      expect(command.completed, false);
      expect(command.isRunning, false);
      expect(command.error, false);
      expect(command.result, null);

      await command.execute(42);

      expect(command.error, true);
      expect(command.isRunning, false);
      expect(command.result, isNotNull);
      expect(command.result!.asError().error, isA<Exception>());
    });
  });
}

Future<Result<String>> getOkResultWithInput(int input) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok("Success with input $input");
}

Future<Result<bool>> getErrorResultWithInput(int input) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception("Error occurred with input $input"));
}