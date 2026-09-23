import 'dart:convert';
import 'dart:io';

import 'package:quanttide_code/quanttide_code.dart';
import 'package:test/test.dart';

// dart test 的工作目录是包根（packages/dart），向量在工具箱根下
Map<String, dynamic> _vector() => jsonDecode(
      File('../../tests/contract/package.json').readAsStringSync(),
    ) as Map<String, dynamic>;

void main() {
  test('领域名与契约向量一致', () {
    expect(domain, _vector()['domain']);
  });

  test('版本与契约向量一致', () {
    expect(version, _vector()['version']);
  });
}
