// frontend/lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String getPostsQuery = """
    query {
      allPosts {
        id
        title
        content
        author {
          name
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Posts'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getPostsQuery),
          pollInterval: const Duration(seconds: 10), // Optional: Refetch every 10 seconds
        ),
        builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List posts = result.data?['allPosts'];

          if (posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final authorName = post['author']?['name'] ?? 'Anonymous';
              return ListTile(
                title: Text(post['title']),
                subtitle: Text('by $authorName'),
                onTap: () {
                  // Handle post tap if you want to show details
                },
              );
            },
          );
        },
      ),
    );
  }
}