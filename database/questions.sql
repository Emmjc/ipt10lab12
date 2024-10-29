CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    item_number INT NOT NULL UNIQUE,
    question TEXT NOT NULL,
    choices JSON NOT NULL,
    correct_answer CHAR(1) NOT NULL
);

CREATE TABLE exam_attempts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    exam_items INT NOT NULL,
    score INT NOT NULL,
    attempt_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users_answers (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    attempt_id INT REFERENCES exam_attempts(id) ON DELETE CASCADE,
    answers JSON NOT NULL,
    date_answered TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);