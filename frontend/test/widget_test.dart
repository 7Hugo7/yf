import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  testWidgets('App builds and displays title', (WidgetTester tester) async {
    // ARRANGE: Set up a mock GraphQL client for the test.
    // This client won't actually connect to the server, it just satisfies the dependency.
    final HttpLink httpLink = HttpLink('http://fake-graphql-endpoint.com/');
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(), // Use an in-memory cache for tests
      ),
    );

    // ACT: Build our app and trigger a frame.
    // We pass the mock client to the MyApp widget here.
    await tester.pumpWidget(MyApp(client: client));

    // ASSERT: Verify that the app title is present.
    // This confirms that the widget tree has been built successfully.
    expect(find.text('YF App'), findsOneWidget);

    // The default "counter" test has been removed as it's no longer relevant.
  });
}