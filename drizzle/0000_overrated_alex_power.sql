CREATE TABLE "global_banks" (
	"id" serial PRIMARY KEY NOT NULL,
	"category" text NOT NULL,
	"initial_balance" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "global_banks_category_unique" UNIQUE("category")
);
--> statement-breakpoint
CREATE TABLE "months" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"year" integer NOT NULL,
	"income" integer DEFAULT 0,
	"costing" integer DEFAULT 0,
	"opening_balance" integer DEFAULT 0,
	"net_balance" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "transactions" (
	"id" serial PRIMARY KEY NOT NULL,
	"month_id" integer NOT NULL,
	"type" text NOT NULL,
	"category" text NOT NULL,
	"date" timestamp DEFAULT now() NOT NULL,
	"description" text,
	"amount" integer DEFAULT 0 NOT NULL,
	"weight" numeric(10, 2) DEFAULT '0',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_month_id_months_id_fk" FOREIGN KEY ("month_id") REFERENCES "public"."months"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "months_year_idx" ON "months" USING btree ("year");--> statement-breakpoint
CREATE INDEX "transactions_month_id_idx" ON "transactions" USING btree ("month_id");--> statement-breakpoint
CREATE INDEX "transactions_date_idx" ON "transactions" USING btree ("date");--> statement-breakpoint
CREATE INDEX "transactions_type_category_idx" ON "transactions" USING btree ("type","category");