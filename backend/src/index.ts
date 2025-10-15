// backend/src/index.ts
import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { typeDefs, resolvers } from './schema';
import { context, Context, getUserFromToken } from './context';

const server = new ApolloServer<Context>({
  typeDefs,
  resolvers,
});

const startServer = async () => {
  const { url } = await startStandaloneServer(server, {
    context: async ({ req }): Promise<Context> => {
      // Extract token from Authorization header
      const token = req.headers.authorization;
      const userId = await getUserFromToken(token);

      return {
        ...context,
        userId,
      };
    },
    listen: { port: 4000 },
  });
  console.log(`🚀 Server ready at: ${url}`);
};

startServer();