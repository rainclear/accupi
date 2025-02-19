package dbm

import (
	"context"
	"fmt"

	"github.com/jackc/pgx/v5/pgtype"
)

type TransactionTxParams struct {
	FromaccountID         int64          `json:"fromaccount_id"`
	ToaccountID           int64          `json:"toaccount_id"`
	TransactiontypeID     int64          `json:"transactiontype_id"`
	Transdate             pgtype.Date    `json:"transdate"`
	Amount                pgtype.Numeric `json:"amount"`
	TransactioncategoryID pgtype.Int8    `json:"transactioncategory_id"`
	Notes                 pgtype.Text    `json:"notes"`
}

// TransferTxResult is the result of the transfer transaction
type TransactionTxResult struct {
	Transaction Transaction `json:"transaction"`
	FromAccount Account     `json:"from_account"`
	ToAccount   Account     `json:"to_account"`
}

func (book *Book) TransactionTx(ctx context.Context, arg TransactionTxParams) (TransactionTxResult, error) {
	var result TransactionTxResult

	if arg.ToaccountID == arg.FromaccountID {
		return result, fmt.Errorf("tx err: ToAccountID cannot be the same as the FromAccountID")
	}

	err := book.execTx(ctx, func(q *Queries) error {
		var exErr error

		// Create Transaction
		result.Transaction, exErr = q.CreateTransaction(ctx, CreateTransactionParams{
			FromaccountID:         arg.FromaccountID,
			ToaccountID:           arg.ToaccountID,
			TransactiontypeID:     arg.TransactiontypeID,
			Transdate:             arg.Transdate,
			Amount:                arg.Amount,
			TransactioncategoryID: arg.TransactioncategoryID,
			Notes:                 arg.Notes,
		})
		if exErr != nil {
			return exErr
		}

		// Decrease FromAccount and assign it to result
		exErr = q.DecreaseAccountBalance(ctx, DecreaseAccountBalanceParams{
			ID:     arg.FromaccountID,
			Amount: arg.Amount,
		})
		if exErr != nil {
			return exErr
		}
		result.FromAccount, exErr = q.GetAccount(ctx, arg.FromaccountID)
		if exErr != nil {
			return exErr
		}

		// Increase ToAccount and assign it to result
		exErr = q.IncreaseAccountBalance(ctx, IncreaseAccountBalanceParams{
			ID:     arg.ToaccountID,
			Amount: arg.Amount,
		})
		if exErr != nil {
			return exErr
		}
		result.ToAccount, exErr = q.GetAccount(ctx, arg.ToaccountID)
		if exErr != nil {
			return exErr
		}

		return exErr
	})

	return result, err

}
