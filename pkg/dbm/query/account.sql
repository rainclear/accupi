-- name: GetAccount :one
SELECT * FROM "Accounts"
WHERE "id" = $1 LIMIT 1;

-- name: ListAccounts :many
SELECT * FROM "Accounts"
ORDER BY "accountname";

-- name: CreateAccount :one
INSERT INTO "Accounts" (
  "owner_id", "currency_id", "accounttype_id", "accountname", "openingbalance", "openingdate", "balance", "institution", "accountnumber", "accountcategory_id", "notes"
) VALUES (
  $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
)
RETURNING *;

-- name: UpdateAccount :exec
UPDATE "Accounts"
  set "owner_id" = $2,
  "currency_id" = $3,
  "accounttype_id" = $4,
  "accountname" = $5,
  "openingbalance" = $6,
  "openingdate" = $7,
  "balance" = $8,
  "institution" = $9,
  "accountnumber" = $10,
  "accountcategory_id" = $11,
  "notes" = $12
WHERE id = $1;

-- name: UpdateAccountBalance :exec
UPDATE "Accounts"
  set "balance" = $2
WHERE id = $1;

-- name: DeleteAccount :exec
DELETE FROM "Accounts"
WHERE id = $1;
