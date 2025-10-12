// frontend/lib/main.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:universal_io/io.dart';
import 'home_page.dart';

void main() async {
  // We're using HiveStore for caching, let's initialize it
  await initHiveForFlutter();

  final String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  final String graphqlEndpoint = 'http://$host:4000/';

  final HttpLink httpLink = HttpLink(
    graphqlEndpoint,
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter GraphQL Blog',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}