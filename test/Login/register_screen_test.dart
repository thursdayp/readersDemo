import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readers/Login/register_screen.dart';

void main() {
  testWidgets('register screen ...', (tester) async {
    // TODO: Implement test
    await tester.pumpWidget(const MaterialApp(
      home: RegisterScreen(),
    ));
    final registrationButton = find.byKey(const Key('ตกลง'));

    await tester.tap(registrationButton);
    await tester.pump();

    expect(find.text('กรุณาระบุ email'), findsOneWidget);
    expect(find.text('กรุณาระบุ age'), findsOneWidget);
    expect(find.text('กรุณาระบุ email'), findsOneWidget);
    expect(find.text('กรุณากรอกรหัสผ่าน'), findsOneWidget);
    expect(find.text('กรุณากรอกรหัสผ่านอีกครั้ง'), findsOneWidget);
  });
}
