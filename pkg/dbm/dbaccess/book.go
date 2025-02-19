package dbm

import (
	"context"
	"fmt"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

// // Book defines all functions to execute db queries and transactions
// type Book interface {
// 	Queries
// 	DoubleEntryTx(ctx context.Context, arg DoubleEntryTxParams) (DoubleEntryTxResult, error)
// }

// SQLBook provides all functions to execute SQL queries and transactions
type Book struct {
	*Queries
	connPool *pgxpool.Pool
}

// NewBook creates a new store
func NewBook(connPool_ *pgxpool.Pool) *Book {
	return &Book{
		Queries:  New(connPool_),
		connPool: connPool_,
	}
}

func (book *Book) execTx(ctx context.Context, fn func(*Queries) error) error {
	tx, err := book.connPool.BeginTx(ctx, pgx.TxOptions{})

	if err != nil {
		return err
	}

	q := New(tx)
	err = fn(q)

	if err != nil {
		if rbErr := tx.Rollback(ctx); rbErr != nil {
			return fmt.Errorf("tx err: %v, rb err: %v", err, rbErr)
		}
		return err
	}

	return tx.Commit(ctx)
}
