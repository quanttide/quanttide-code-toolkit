import 'package:quanttide_code/quanttide_code.dart';
import 'package:test/test.dart';

void main() {
  test('领域英文名', () {
    expect(domain, 'software-engineering');
  });

  test('包版本与 pubspec 一致', () {
    expect(version, '0.1.0');
  });
}
