package repo

import (
	"back/pkg/postgre"
	"context"
	"fmt"
)

type Telegram struct {
	postgre *postgre.Postgre
}

func NewUsers(p *postgre.Postgre) *Telegram {
	return &Telegram{postgre: p}
}

type Message struct {
	ChatID    int
	UserID    int
	Message   string
	CreatedAt string
}

func (u *Telegram) GetUserChatsWithLastMessage(ctx context.Context, username string) ([]Message, error) {
	rows, err := u.postgre.QueryContext(
		ctx,
		`SELECT * FROM get_last_n_messages_from_all_user_chats($1, 1)`,
		username,
	)
	if err != nil {
		return nil, err
	}

	defer func() {
		err := rows.Close()
		if err != nil {
			fmt.Printf("failed to close rows: %v", err)
		}
	}()

	var messages []Message

	for rows.Next() {
		message := Message{}
		err := rows.Scan(&message.ChatID, &message.UserID, &message.Message, &message.CreatedAt)
		if err != nil {
			return nil, err
		}

		messages = append(messages, message)
	}

	return messages, nil
}
