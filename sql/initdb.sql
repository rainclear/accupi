CREATE TABLE "Owners" (
  "id" bigserial PRIMARY KEY,
  "ownername" varchar(256) UNIQUE NOT NULL,
  "emailaddress" varchar(256) UNIQUE NOT NULL,
  "birthdate" date
);

CREATE TABLE "Currencies" (
  "id" bigserial PRIMARY KEY,
  "currency" varchar(16) UNIQUE NOT NULL
);

CREATE TABLE "AccountTypes" (
  "id" bigserial PRIMARY KEY,
  "accounttype" varchar(256) UNIQUE NOT NULL
);

CREATE TABLE "AccountCategories" (
  "id" bigserial PRIMARY KEY,
  "AccountCategory" varchar(256) UNIQUE NOT NULL
);

CREATE TABLE "Accounts" (
  "id" bigserial PRIMARY KEY,
  "owner_id" bigserial NOT NULL,
  "currency_id" bigserial NOT NULL,
  "accounttype_id" bigserial NOT NULL,
  "accountname" varchar(512) UNIQUE NOT NULL,
  "openingbalance" decimal(32,2) NOT NULL DEFAULT 0,
  "openingdate" date NOT NULL,
  "balance" decimal(32,2) NOT NULL DEFAULT 0,
  "institution" varchar(256),
  "accountnumber" varchar(256),
  "accountcategory_id" bigserial,
  "notes" varchar(512)
);

CREATE TABLE "TransactionTypes" (
  "id" bigserial PRIMARY KEY,
  "transactiontype" varchar(256) UNIQUE NOT NULL
);

CREATE TABLE "TransactionCategories" (
  "id" bigserial PRIMARY KEY,
  "transactioncategory" varchar(256) UNIQUE NOT NULL
);

CREATE TABLE "Transactions" (
  "id" bigserial PRIMARY KEY,
  "fromaccount_id" bigserial NOT NULL,
  "toaccount_id" bigserial NOT NULL,
  "transactiontype_id" bigserial NOT NULL,
  "transdate" date NOT NULL,
  "amount" decimal(32,2) NOT NULL DEFAULT 0,
  "transactioncategory_id" bigserial,
  "notes" varchar(512)
);

ALTER TABLE "Accounts" ADD FOREIGN KEY ("owner_id") REFERENCES "Owners" ("id");

ALTER TABLE "Accounts" ADD FOREIGN KEY ("currency_id") REFERENCES "Currencies" ("id");

ALTER TABLE "Accounts" ADD FOREIGN KEY ("accounttype_id") REFERENCES "AccountTypes" ("id");

ALTER TABLE "Accounts" ADD FOREIGN KEY ("accountcategory_id") REFERENCES "AccountCategories" ("id");

ALTER TABLE "Transactions" ADD FOREIGN KEY ("fromaccount_id") REFERENCES "Accounts" ("id");

ALTER TABLE "Transactions" ADD FOREIGN KEY ("toaccount_id") REFERENCES "Accounts" ("id");

ALTER TABLE "Transactions" ADD FOREIGN KEY ("transactiontype_id") REFERENCES "TransactionTypes" ("id");

ALTER TABLE "Transactions" ADD FOREIGN KEY ("transactioncategory_id") REFERENCES "TransactionCategories" ("id");

ALTER TABLE "Transactions" ADD CONSTRAINT tonoteqfrom CHECK (toaccount_id <> fromaccount_id);
