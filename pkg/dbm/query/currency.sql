-- name: GetCurrency :one
SELECT * FROM "Currencies"
WHERE "id" = $1 LIMIT 1;

-- name: ListCurrencies :many
SELECT * FROM "Currencies"
ORDER BY "currency";

-- name: CreateCurrency :one
INSERT INTO "Currencies" (
  "currency"
) VALUES (
  $1
)
RETURNING *;

-- name: UpdateCurrency :exec
UPDATE "Currencies"
  set "currency" = $2
WHERE id = $1;

-- name: DeleteCurrency :exec
DELETE FROM "Currencies"
WHERE id = $1;
