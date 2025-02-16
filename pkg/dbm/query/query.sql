-- name: GetOwner :one
SELECT * FROM "Owners"
WHERE "id" = $1 LIMIT 1;

-- -- name: ListOwners :many
-- SELECT * FROM Owners
-- ORDER BY ownername;

-- -- name: CreateOwner :one
-- INSERT INTO Owners (
--   ownername, emailaddress, birthdate
-- ) VALUES (
--   $1, $2, $3
-- )
-- RETURNING *;

-- -- name: UpdateOwner :exec
-- UPDATE Owners
--   set ownername = $2,
--   emailaddress = $3,
--   birthdate = $4
-- WHERE id = $1;

-- -- name: DeleteOwner :exec
-- DELETE FROM Owners
-- WHERE id = $1;