YF App - Local Development Setup

brew install node

Part 1: Start the Backend

1. Open your terminal and navigate to the backend folder:

cd backend

2. Create your local environment file:

Create a new file named .env.

Add the following line to it.

DATABASE_URL="db connection example"

3. Start the database:

This command runs your PostgreSQL database in the background.

npx prisma dev

4. Install backend dependencies:

npm install

Note: The first time you run this, it will create and apply a migration for you. Just press Enter when prompted for a name.

✅ Success! Your database is running and in sync. The command will continue running. Leave this terminal open.

Part 2: Run the API Server & Frontend
1. Open a second, new terminal window.

2. Navigate to the backend folder again:

cd backend

3. Run the backend API server:

npm run dev

✅ The backend API is now running at http://localhost:4000. Leave this terminal open.

4. Open a third terminal window.

5. Navigate to the frontend folder:

cd frontend

6. Install frontend dependencies:

flutter pub get

7. Run the Flutter app:

flutter device

flutter run "device"
