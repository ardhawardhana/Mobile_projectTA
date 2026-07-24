import 'package:flutter_test/flutter_test.dart';
import 'package:ta_project/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TpqApp());
    expect(find.byType(TpqApp), findsOneWidget);
  });
}
