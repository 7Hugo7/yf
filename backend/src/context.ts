import { PrismaClient } from '@prisma/client';

// Initialize a single instance of Prisma Client
const prisma = new PrismaClient();

/**
 * Defines the request context for your GraphQL server.
 * This object is passed to every resolver, giving them access to the database.
 */
export interface Context {
  prisma: PrismaClient;
}

// The actual context object that will be used in the server.
export const context: Context = {
  prisma: prisma,
};