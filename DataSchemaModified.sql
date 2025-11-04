CREATE TABLE platform (
    platform_id INT PRIMARY KEY,
    platform_type VARCHAR(30) NOT NULL,
    os VARCHAR(30) NOT NULL
);

CREATE TABLE system_info (
    system_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    version VARCHAR(20),
    platform_id INT,
    FOREIGN KEY (platform_id)
        REFERENCES platform (platform_id)
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    device_type VARCHAR(30)
);

CREATE TABLE humidity (
    humidity_id INT PRIMARY KEY,
    current_value FLOAT
        CHECK (current_value BETWEEN 0 AND 100),
    measurement_date TIMESTAMP NOT NULL,
    system_id INT,
    FOREIGN KEY (system_id)
        REFERENCES system_info (system_id)
);

CREATE TABLE threshold (
    threshold_id INT PRIMARY KEY,
    min_threshold FLOAT NOT NULL
        CHECK (min_threshold >= 0),
    max_threshold FLOAT NOT NULL
        CHECK (max_threshold <= 100),
    system_id INT,
    FOREIGN KEY (system_id)
        REFERENCES system_info (system_id)
);

CREATE TABLE notification (
    notification_id INT PRIMARY KEY,
    message_text VARCHAR(255) NOT NULL
        CHECK (message_text ~ '^[A-Za-zА-Яа-я0-9 ,.!?-]{5,255}$'),
    date_sent TIMESTAMP NOT NULL,
    notification_type VARCHAR(20)
        CHECK (notification_type ~ '^(Critical|Informational|Warning)$'),
    user_id INT,
    system_id INT,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id),
    FOREIGN KEY (system_id)
        REFERENCES system_info (system_id)
);

CREATE TABLE recommendation (
    recommendation_id INT PRIMARY KEY,
    description VARCHAR(255) NOT NULL
        CHECK (description ~ '^[A-Za-zА-Яа-я0-9 ,.!?-]{5,255}$'),
    action_type VARCHAR(50),
    system_id INT,
    FOREIGN KEY (system_id)
        REFERENCES system_info (system_id)
);

CREATE TABLE analytics (
    analytics_id INT PRIMARY KEY,
    average_value FLOAT,
    deviation FLOAT,
    period VARCHAR(30),
    system_id INT,
    FOREIGN KEY (system_id)
        REFERENCES system_info (system_id)
);

CREATE TABLE optimization (
    optimization_id INT PRIMARY KEY,
    planned_actions VARCHAR(255),
    planning_date TIMESTAMP,
    user_id INT,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);
