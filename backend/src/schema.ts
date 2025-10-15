import { gql } from 'graphql-tag';
import { Context } from './context';
// need these for authentication later
import * as bcrypt from 'bcryptjs';
import * as jwt from 'jsonwebtoken';

// This is your GraphQL schema definition
export const typeDefs = gql`
  # =============================================================================
  # GraphQL Schema für YF
  # Definiert API schnittstelle zw. Frontend und Backend
  # =============================================================================

  # alle lese operationen
  type Query {
    "momentan authetifiziertes nutzerprofil"
    me: User

    "nutzer anhand spezifischer id"
    user(id: ID!): User

    "alle kleidungsteile in nutzer wardrobe"
    wardrobe(userId: ID!): [Piece!]

    "spezifisches kleidungsteil"
    piece(id: ID!): Piece
  }

  # alle schreibe/update/lösch operationen
  type Mutation {
    "neuen nutzer registrieren und authentifizierungstoken geben"
    register(input: RegisterInput!): AuthPayload!

    "nutzer einloggen und authentifizierungstocken geben"
    login(login: String!, password: String!): AuthPayload!

    "profil informationen des momentan eingeloggten nutzers ändern"
    updateProfile(input: UpdateProfileInput!): User

    "körpermaße ändern/setzen des momentanen nutzers"
    updateMeasurements(input: UpdateMeasurementsInput!): Measurements

    "neues Kleidungsstück zur Garderobe hinzufügen"
    addPiece(input: AddPieceInput!): Piece!
  }

  # =============================================================================
  # CORE TYPEN
  # =============================================================================

  "Nutzer repräsentation"
  type User {
    id: ID!
    username: String!
    email: String
    phoneNumber: String
    profilePictureUrl: String
    wardrobe: [Piece!]
    measurements: Measurements
    createdAt: String!
  }

  "einzelnes Kleidungsstück"
  type Piece {
    id: ID!
    name: String
    category: PieceCategory!
    imageUrl: String!
    size: String
    owner: User!
    createdAt: String!
  }

  "alle maße des nutzers"
  type Measurements {
    id: ID!
    gender: Gender
    heightCm: Int
    weightKg: Int
    shoulderWidthCm: Int
    chestCm: Int
    underbustCm: Int
    waistCm: Int
    backLengthCm: Int
    upperbodyLength: Int
    hipsCm: Int
    armLengthCm: Int
    upperArmCm: Int
    inseamCm: Int
    thighCm: Int
    shoeSizeEU: Int
    footWidthCm: Int
  }

  "payload nach erfolgreiches authentifizierung"
  type AuthPayload {
    token: String!
    user: User!
  }


  # =============================================================================
  # INPUT TYPEN für Mutations
  # =============================================================================

  input RegisterInput {
    username: String!
    email: String
    phoneNumber: String
    password: String!
  }

  input UpdateProfileInput {
    username: String
    profilePictureUrl: String
  }

  input UpdateMeasurementsInput {
    gender: Gender
    heightCm: Int
    weightKg: Int
    shoulderWidthCm: Int
    chestCm: Int
    underbustCm: Int
    waistCm: Int
    backLengthCm: Int
    hipsCm: Int
    armLengthCm: Int
    upperArmCm: Int
    inseamCm: Int
    thighCm: Int
    shoeSizeEU: Int
    footWidthCm: Int
  }

  input AddPieceInput {
    name: String
    category: PieceCategory!
    imageUrl: String!
    size: String
  }

  # =============================================================================
  # ENUMS
  # =============================================================================

  enum Gender {
    MALE
    FEMALE
    DIVERSE
    PREFER_NOT_TO_SAY
  }

  enum PieceCategory {
    T_SHIRT
    SHIRT
    SWEATER
    HOODIE
    JACKET
    PANTS
    SHORTS
    SHOES
    ACCESSORY
    OTHER
  }
`;

// These are your resolver functions. They are the "implementation" of your schema.
export const resolvers = {
  Query: {
    // Example: Get a user by their ID
    user: (parent: any, args: { id: string }, context: Context) => {
      return context.prisma.user.findUnique({
        where: { id: args.id },
      });
    },
    // Get current authenticated user
    me: (_parent: any, _args: any, context: Context) => {
      if (!context.userId) {
        throw new Error('Not authenticated');
      }
      return context.prisma.user.findUnique({
        where: { id: context.userId },
      });
    },
    // TODO: Implement the 'wardrobe' query
    wardrobe: (parent: any, args: { userId: string }, context: Context) => {
      return context.prisma.piece.findMany({
        where: { ownerId: args.userId },
      });
    },
    // TODO: Implement the 'piece' query
    piece: (parent: any, args: { id: string }, context: Context) => {
        return context.prisma.piece.findUnique({
            where: { id: args.id },
        });
    },
  },
  Mutation: {
    // TODO: Implement the 'register' mutation
    register: async (parent: any, args: { input: any }, context: Context) => {
      // NOTE: This is a placeholder. You need to add proper password hashing
      // and JWT signing for a real application.
      const hashedPassword = await bcrypt.hash(args.input.password, 10);
      const user = await context.prisma.user.create({
        data: {
          username: args.input.username,
          email: args.input.email,
          phoneNumber: args.input.phoneNumber,
          passwordHash: hashedPassword,
        },
      });

      // Create session token
      const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET || 'YOUR_APP_SECRET', {
        expiresIn: '30d',
      });

      // Store session in database
      const expiresAt = new Date();
      expiresAt.setDate(expiresAt.getDate() + 30); // 30 days from now

      await context.prisma.session.create({
        data: {
          userId: user.id,
          token,
          expiresAt,
        },
      });

      return { token, user };
    },
    // Login mutation
    login: async (parent: any, args: { login: string; password: string }, context: Context) => {
      // Find user by username, email, or phone
      const user = await context.prisma.user.findFirst({
        where: {
          OR: [
            { username: args.login },
            { email: args.login },
            { phoneNumber: args.login },
          ],
        },
      });

      if (!user) {
        throw new Error('Invalid credentials');
      }

      // Verify password
      const valid = await bcrypt.compare(args.password, user.passwordHash);
      if (!valid) {
        throw new Error('Invalid credentials');
      }

      // Create session token
      const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET || 'YOUR_APP_SECRET', {
        expiresIn: '30d',
      });

      // Store session in database
      const expiresAt = new Date();
      expiresAt.setDate(expiresAt.getDate() + 30); // 30 days from now

      await context.prisma.session.create({
        data: {
          userId: user.id,
          token,
          expiresAt,
        },
      });

      return { token, user };
    },
  },
  // Define relations to tell GraphQL how to fetch nested data
  User: {
    wardrobe: (parent: any, args: any, context: Context) => {
      return context.prisma.user.findUnique({ where: { id: parent.id } }).wardrobe();
    },
    measurements: (parent: any, args: any, context: Context) => {
      return context.prisma.user.findUnique({ where: { id: parent.id } }).measurements();
    }
  },
  Piece: {
    owner: (parent: any, args: any, context: Context) => {
      return context.prisma.piece.findUnique({ where: { id: parent.id } }).owner();
    },
  },
  // Add other relation resolvers for Measurements, Post, etc. as needed.
};