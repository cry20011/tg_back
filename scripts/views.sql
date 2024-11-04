CREATE VIEW user_chats_view  AS
SELECT users.id AS user_id,
       users.username,
       chats.id AS chat_id,
       chats.name
FROM users
         JOIN
     user_chats ON users.id = user_chats.user_id
         JOIN
     chats ON user_chats.chat_id = chats.id;

SELECT * FROM user_chats_view;

EXPLAIN ANALYSE SELECT * FROM user_chats_view;
