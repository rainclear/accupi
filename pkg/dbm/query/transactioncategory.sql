-- name: GetTransactionCategory :one
SELECT * FROM "TransactionCategories"
WHERE "id" = $1 LIMIT 1;

-- name: ListTransactionCategories :many
SELECT * FROM "TransactionCategories"
ORDER BY "transactioncategory";

-- name: CreateTransactionCategory :one
INSERT INTO "TransactionCategories" (
  "transactioncategory"
) VALUES (
  $1
)
RETURNING *;

-- name: UpdateTransactionCategory :exec
UPDATE "TransactionCategories"
  set "transactioncategory" = $2
WHERE id = $1;

-- name: DeleteTransactionCategory :exec
DELETE FROM "TransactionCategories"
WHERE id = $1;
