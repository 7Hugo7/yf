// backend/src/index.ts
import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { typeDefs, resolvers } from './schema';
import { context, Context } from './context';

const server = new ApolloServer<Context>({
  typeDefs,
  resolvers,
});

const startServer = async () => {
  const { url } = await startStandaloneServer(server, {
    context: async () => context,
    listen: { port: 4000 },
  });
  console.log(`🚀 Server ready at: ${url}`);
};

startServer();