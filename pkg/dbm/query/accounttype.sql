-- name: GetAccountType :one
SELECT * FROM "AccountTypes"
WHERE "id" = $1 LIMIT 1;

-- name: ListAccountTypes :many
SELECT * FROM "AccountTypes"
ORDER BY "accounttype";

-- name: CreateAccountType :one
INSERT INTO "AccountTypes" (
  "accounttype"
) VALUES (
  $1
)
RETURNING *;

-- name: UpdateAccountType :exec
UPDATE "AccountTypes"
  set "accounttype" = $2
WHERE id = $1;

-- name: DeleteAccountType :exec
DELETE FROM "AccountTypes"
WHERE id = $1;
