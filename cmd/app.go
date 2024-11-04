package main

import (
	"back/internal/usecase/repo"
	"back/pkg/postgre"
	"context"
	"fmt"
	"log"
)

func main() {
	p, err := postgre.New("postgres", "postgres", "telegram", "localhost", "5432")
	if err != nil {
		log.Fatal(err.Error())
	}

	r := repo.NewUsers(p)

	m, err := r.GetUserChatsWithLastMessage(context.Background(), "user1")
	if err != nil {
		log.Fatal(err.Error())
	}

	fmt.Printf("%+v", m)
}
