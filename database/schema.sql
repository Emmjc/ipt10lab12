CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complete_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP NULL DEFAULT NULL
);


CREATE TABLE questions (
	    id INT AUTO_INCREMENT PRIMARY KEY,
    	item_number INT NOT NULL,
    	question TEXT NOT NULL,
    	choices JSON NOT NULL,
    	correct_answer CHAR(1) NOT NULL,
    	CONSTRAINT chk_correct_answer CHECK (correct_answer IN ('A', 'B', 'C', 'D'))
);


CREATE TABLE exam_attempts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    exam_items INT NOT NULL,
    score INT NOT NULL,
    attempt_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE users_answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    attempt_id INT NOT NULL,
    answers JSON NOT NULL,
    date_answered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (attempt_id) REFERENCES exam_attempts(id)
);

INSERT INTO questions
SET
item_number=1,
question="What is the smallest planet in our Solar System?",
choices='[
    {"letter": "A", "choice": "Mercury"},
    {"letter": "B", "choice": "Mars"},
    {"letter": "C", "choice": "Venus"},
    {"letter": "D", "choice": "Earth"}
]',
correct_answer='A';

INSERT INTO questions
SET
item_number=2,
question="What is the chemical symbol for the element Oxygen?",
choices='[
    {"letter": "A", "choice": "O"},
    {"letter": "B", "choice": "Ox"},
    {"letter": "C", "choice": "O2"},
    {"letter": "D", "choice": "Om"}
]',
correct_answer='A';

INSERT INTO questions
SET
item_number=3,
question="Which planet is known as the Red Planet?",
choices='[
    {"letter": "A", "choice": "Earth"},
    {"letter": "B", "choice": "Jupiter"},
    {"letter": "C", "choice": "Mars"},
    {"letter": "D", "choice": "Saturn"}
]',
correct_answer='C';

INSERT INTO questions
SET
item_number=4,
question="How many bones are there in the adult human body?",
choices='[
    {"letter": "A", "choice": "206"},
    {"letter": "B", "choice": "201"},
    {"letter": "C", "choice": "196"},
    {"letter": "D", "choice": "211"}
]',
correct_answer='A';

INSERT INTO questions
SET
item_number=5,
question="Which planet has the most moons?",
choices='[
    {"letter": "A", "choice": "Mars"},
    {"letter": "B", "choice": "Saturn"},
    {"letter": "C", "choice": "Jupiter"},
    {"letter": "D", "choice": "Neptune"}
]',
correct_answer='B';
