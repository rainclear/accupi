-- name: GetAccountCategory :one
SELECT * FROM "AccountCategories"
WHERE "id" = $1 LIMIT 1;

-- name: ListAccountCategories :many
SELECT * FROM "AccountCategories"
ORDER BY "accountcategory";

-- name: CreateAccountCategory :one
INSERT INTO "AccountCategories" (
  "accountcategory"
) VALUES (
  $1
)
RETURNING *;

-- name: UpdateAccountCategory :exec
UPDATE "AccountCategories"
  set "accountcategory" = $2
WHERE id = $1;

-- name: DeleteAccountCategory :exec
DELETE FROM "AccountCategories"
WHERE id = $1;
