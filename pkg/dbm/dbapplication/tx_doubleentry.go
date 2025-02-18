package dbm

import "github.com/jackc/pgx/pgtype"

type DoubleEntryTxParams struct {
	FromAccountID int64          `json:"fromaccount_id"`
	ToAccountID   int64          `json:"toaccount_id"`
	Amount        pgtype.Numeric `json:"amount"`
}
