import { pgTable, serial, text, integer, timestamp, numeric, index } from "drizzle-orm/pg-core";

export const months = pgTable("months", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  year: integer("year").notNull(),
  income: integer("income").default(0),
  costing: integer("costing").default(0),
  openingBalance: integer("opening_balance").default(0),
  createdAt: timestamp("created_at").defaultNow(),
}, (table) => [
  index("months_year_idx").on(table.year),
]);

export const transactions = pgTable("transactions", {
  id: serial("id").primaryKey(),
  monthId: integer("month_id").notNull().references(() => months.id, { onDelete: "cascade" }),
  type: text("type").notNull(), 
  category: text("category").notNull(), 
  date: timestamp("date").notNull().defaultNow(),
  description: text("description"),
  amount: integer("amount").notNull().default(0),
  weight: numeric("weight", { precision: 10, scale: 2 }).default("0"),
  createdAt: timestamp("created_at").defaultNow(),
}, (table) => [
  index("transactions_month_id_idx").on(table.monthId),
  index("transactions_date_idx").on(table.date),
  index("transactions_type_category_idx").on(table.type, table.category),
]);

export type Month = typeof months.$inferSelect;
export type NewMonth = typeof months.$inferInsert;
export type Transaction = typeof transactions.$inferSelect;
export type NewTransaction = typeof transactions.$inferInsert;
