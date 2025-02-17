-- name: GetTransaction :one
SELECT * FROM "Transactions"
WHERE "id" = $1 LIMIT 1;

-- name: ListTransactions :many
SELECT * FROM "Transactions"
ORDER BY "transdate";

-- name: CreateTransaction :one
INSERT INTO "Transactions" (
  "fromaccount_id", "toaccount_id", "transactiontype_id", "transdate", "amount", "transactioncategory_id", "notes"
) VALUES (
  $1, $2, $3, $4, $5, $6, $7
)
RETURNING *;

-- name: UpdateTransaction :exec
UPDATE "Transactions"
  set "fromaccount_id" = $2,
  "toaccount_id" = $3,
  "transactiontype_id" = $4,
  "transdate" = $5,
  "amount" = $6,
  "transactioncategory_id" = $7, 
  "notes" = $8
WHERE id = $1;

-- name: DeleteTransaction :exec
DELETE FROM "Transactions"
WHERE id = $1;
