create database silent-shield;
use silent-shield;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255),
    role ENUM('user','volunteer','admin') NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE volunteers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    govt_id_path VARCHAR(255),
    trust_score FLOAT DEFAULT 0,
    total_services INT DEFAULT 0,
    accepted_requests INT DEFAULT 0,
    rejected_requests INT DEFAULT 0,
    avg_response_time FLOAT DEFAULT 0,
    is_approved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE sos_alerts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    risk_level ENUM('safe','caution','high'),
    status ENUM('pending','assigned','resolved') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sos_locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sos_id INT,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sos_id) REFERENCES sos_alerts(id) ON DELETE CASCADE
);

CREATE TABLE sos_assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sos_id INT,
    volunteer_id INT,
    status ENUM('assigned','accepted','rejected','completed'),
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sos_id) REFERENCES sos_alerts(id),
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(id)
);

CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sos_id INT,
    volunteer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE high_risk_zones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    alert_count INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
