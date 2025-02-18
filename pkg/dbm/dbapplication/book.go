package dbm

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"
)

// Book defines all functions to execute dbm queries and transactions
type Book interface {
	Querier
	DoubleEntryTx(ctx context.Context, arg DoubleEntryTxParams) (DoubleEntryTxResult, error)
}

// SQLBook provides all functions to execute SQL queries and transactions
type SQLBook struct {
	connPool *pgxpool.Pool
	*Queries
}

// NewBook creates a new store
func NewBook(connPool *pgxpool.Pool) Book {
	return &SQLBook{
		connPool: connPool,
		Queries:  New(connPool),
	}
}