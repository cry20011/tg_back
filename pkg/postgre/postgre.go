package postgre

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

type Postgre struct {
	*sql.DB
}

func New(user, pass, dbName, host, port string) (*Postgre, error) {
	connStr := fmt.Sprintf(
		"user=%s password=%s dbname=%s host=%s port=%s sslmode=disable",
		user, pass, dbName, host, port,
	)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, err
	}

	return &Postgre{DB: db}, nil
}
