-- name: GetTransactionType :one
SELECT * FROM "TransactionTypes"
WHERE "id" = $1 LIMIT 1;

-- name: ListTransactionTypes :many
SELECT * FROM "TransactionTypes"
ORDER BY "transactiontype";

-- name: CreateTransactionType :one
INSERT INTO "TransactionTypes" (
  "transactiontype"
) VALUES (
  $1
)
RETURNING *;

-- name: UpdateTransactionType :exec
UPDATE "TransactionTypes"
  set "transactiontype" = $2
WHERE id = $1;

-- name: DeleteTransactionType :exec
DELETE FROM "TransactionTypes"
WHERE id = $1;
