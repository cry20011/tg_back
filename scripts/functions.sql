CREATE OR REPLACE FUNCTION get_last_n_messages_from_all_user_chats(u VARCHAR, n INT)
    RETURNS TABLE
            (
                chat_id    INT,
                user_id    INT,
                message    TEXT,
                created_at TIMESTAMP
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT subquery.chat_id,
               subquery.user_id,
               subquery.message,
               subquery.created_at
        FROM (SELECT res.chat_id,
                     messages.user_id,
                     messages.message,
                     messages.created_at,
                     ROW_NUMBER()
                     OVER (PARTITION BY messages.chat_id ORDER BY messages.created_at DESC) AS rn
              FROM ((SELECT res.chat_id
                     FROM (users INNER JOIN user_chats uc on users.id = uc.user_id) AS res
                     WHERE res.username = u) as res
                  LEFT JOIN messages ON res.chat_id = messages.chat_id)) subquery
        WHERE rn <= n
        ORDER BY created_at DESC;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_last_n_messages_from_all_user_chats(character varying,integer);

SELECT res.chat_id
FROM (users INNER JOIN user_chats uc on users.id = uc.user_id) AS res
WHERE res.username = 'user1';

SELECT * FROM get_last_n_messages_from_all_user_chats('user1', 1);
