import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/utils/commands/commands.dart';
import 'package:mvvm_example/utils/result/result.dart';

void main() {
  group("Command test", () {
    test("Should test Command0 returns OK", () async {
      final command = Command0<String>(getOkResult);

      expect(command.completed, false);
      expect(command.isRunning, false);
      expect(command.error, false);
      expect(command.result, null);

      await command.execute();

      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, isNotNull);
      expect(command.result?.asOk().value, "Success");
    });
  });

  test("Should test Command0 returns Error", () async {
    final command = Command0<bool>(getErrorResult);

    expect(command.completed, false);
    expect(command.isRunning, false);
    expect(command.error, false);
    expect(command.result, null);

    await command.execute();

    expect(command.error, true);
    expect(command.isRunning, false);
    expect(command.result, isNotNull);
    expect(command.result!.asError().error, isA<Exception>());
  });
}

Future<Result<String>> getOkResult() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok("Success");
}

Future<Result<bool>> getErrorResult() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception("Error occurred"));
}
