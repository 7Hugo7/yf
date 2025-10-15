import { PrismaClient } from '@prisma/client';
import * as jwt from 'jsonwebtoken';

// Initialize a single instance of Prisma Client
const prisma = new PrismaClient();

/**
 * Defines the request context for your GraphQL server.
 * This object is passed to every resolver, giving them access to the database.
 */
export interface Context {
  prisma: PrismaClient;
  userId?: string | undefined;
}

/**
 * Extract userId from JWT token in the Authorization header
 */
export const getUserFromToken = async (token?: string): Promise<string | undefined> => {
  if (!token) return undefined;

  try {
    // Remove 'Bearer ' prefix if present
    const cleanToken = token.replace('Bearer ', '');

    // Verify token is valid and not expired
    const decoded = jwt.verify(cleanToken, process.env.JWT_SECRET || 'YOUR_APP_SECRET') as { userId: string };

    // Check if session exists and is not expired
    const session = await prisma.session.findUnique({
      where: { token: cleanToken },
    });

    if (!session || session.expiresAt < new Date()) {
      return undefined;
    }

    return decoded.userId;
  } catch (error) {
    return undefined;
  }
};

// The actual context object that will be used in the server.
export const context: Context = {
  prisma: prisma,
};