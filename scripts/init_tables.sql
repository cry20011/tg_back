CREATE TABLE IF NOT EXISTS users
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE chats
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_chats
(
    user_id INT REFERENCES users (id) ON DELETE CASCADE,
    chat_id INT REFERENCES chats (id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, chat_id)
);

CREATE TABLE messages
(
    id         SERIAL PRIMARY KEY,
    chat_id    INT REFERENCES chats (id) ON DELETE RESTRICT,
    user_id    INT REFERENCES users (id),
    message    TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username)
VALUES ('user1');
INSERT INTO users (username)
VALUES ('user2');
INSERT INTO users (username)
VALUES ('user3');

INSERT INTO chats (name)
VALUES ('Chat 1');
INSERT INTO chats (name)
VALUES ('Chat 2');
INSERT INTO chats (name)
VALUES ('Chat 3');
INSERT INTO chats (name)
VALUES ('Chat 4');

INSERT INTO user_chats (chat_id, user_id)
VALUES (1, 1);
INSERT INTO user_chats (chat_id, user_id)
VALUES (1, 2);
INSERT INTO user_chats (chat_id, user_id)
VALUES (2, 1);
INSERT INTO user_chats (chat_id, user_id)
VALUES (2, 3);
INSERT INTO user_chats (chat_id, user_id)
VALUES (3, 2);
INSERT INTO user_chats (chat_id, user_id)
VALUES (4, 1);

INSERT INTO messages (chat_id, user_id, message)
VALUES (1, 1, 'Hello from user1 in Chat 1!');
INSERT INTO messages (chat_id, user_id, message)
VALUES (1, 2, 'Hi user1, this is user2!');
INSERT INTO messages (chat_id, user_id, message)
VALUES (2, 1, 'User1 here in Chat 2!');
INSERT INTO messages (chat_id, user_id, message)
VALUES (2, 3, 'User3 joining the conversation!');
INSERT INTO messages (chat_id, user_id, message)
VALUES (3, 2, 'User2 in Chat 3!');
