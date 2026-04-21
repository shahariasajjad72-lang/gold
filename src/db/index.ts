import postgres from 'postgres';
import { drizzle } from 'drizzle-orm/postgres-js';
import * as schema from './schema';

if (!process.env.DATABASE_URL) {
  console.error("❌ ERROR: DATABASE_URL is not defined in .env.local");
}

// Supabase Connection String (Direct or Transaction Pooler)
const queryClient = postgres(process.env.DATABASE_URL || 'postgres://localhost:5432/postgres');
export const db = drizzle(queryClient, { schema });
