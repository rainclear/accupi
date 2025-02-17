// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.28.0
// source: currency.sql

package sqlc

import (
	"context"
)

const createCurrency = `-- name: CreateCurrency :one
INSERT INTO "Currencies" (
  "currency"
) VALUES (
  $1
)
RETURNING id, currency
`

func (q *Queries) CreateCurrency(ctx context.Context, currency string) (Currency, error) {
	row := q.db.QueryRow(ctx, createCurrency, currency)
	var i Currency
	err := row.Scan(&i.ID, &i.Currency)
	return i, err
}

const deleteCurrency = `-- name: DeleteCurrency :exec
DELETE FROM "Currencies"
WHERE id = $1
`

func (q *Queries) DeleteCurrency(ctx context.Context, id int64) error {
	_, err := q.db.Exec(ctx, deleteCurrency, id)
	return err
}

const getCurrency = `-- name: GetCurrency :one
SELECT id, currency FROM "Currencies"
WHERE "id" = $1 LIMIT 1
`

func (q *Queries) GetCurrency(ctx context.Context, id int64) (Currency, error) {
	row := q.db.QueryRow(ctx, getCurrency, id)
	var i Currency
	err := row.Scan(&i.ID, &i.Currency)
	return i, err
}

const listCurrencies = `-- name: ListCurrencies :many
SELECT id, currency FROM "Currencies"
ORDER BY "currency"
`

func (q *Queries) ListCurrencies(ctx context.Context) ([]Currency, error) {
	rows, err := q.db.Query(ctx, listCurrencies)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Currency
	for rows.Next() {
		var i Currency
		if err := rows.Scan(&i.ID, &i.Currency); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const updateCurrency = `-- name: UpdateCurrency :exec
UPDATE "Currencies"
  set "currency" = $2
WHERE id = $1
`

type UpdateCurrencyParams struct {
	ID       int64
	Currency string
}

func (q *Queries) UpdateCurrency(ctx context.Context, arg UpdateCurrencyParams) error {
	_, err := q.db.Exec(ctx, updateCurrency, arg.ID, arg.Currency)
	return err
}
