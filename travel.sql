CREATE DATABASE travel_data;

USE travel_data;

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

select * from users;

-- Packages Table
CREATE TABLE packages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    price_bus DECIMAL(10,2) NOT NULL DEFAULT 0,
    price_train DECIMAL(10,2) NOT NULL DEFAULT 0,
    price_flight DECIMAL(10,2) NOT NULL DEFAULT 0
);

-- Inserting data in Packages
INSERT INTO packages (name, description, price, image_url, price_bus, price_train, price_flight) VALUES
('Beach Paradise', 'Enjoy a 5-day beach vacation with luxury hotels and activities.', 499.99, 'p1.png', 399.99, 449.99, 599.99),
('Mountain Adventure', 'Hike and explore the best mountain trails with expert guides.', 599.99, 'p2.png', 499.99, 549.99, 699.99),
('City Lights', 'Discover vibrant city life with guided tours and top attractions.', 699.99, 'p3.png', 599.99, 649.99, 799.99),
('Desert Safari', 'Experience the thrill of dune bashing, camel rides, and desert camping.', 349.99, 'p4.png', 299.99, 319.99, 429.99),
('Tropical Island', 'Relax on a secluded island with crystal-clear waters and exotic wildlife.', 899.99, 'p5.png', 799.99, 849.99, 999.99),
('Cultural Heritage', 'Explore ancient temples, museums, and historical landmarks.', 449.99, 'p6.png', 349.99, 399.99, 529.99);

select * from packages;

-- Bookings Table
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    package_id INT NOT NULL,
    package_name VARCHAR(255) NOT NULL,
    mode_of_travel ENUM('Bus', 'Train', 'Flight') NOT NULL,
    num_persons INT NOT NULL DEFAULT 1,
    total_price DECIMAL(10,2) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);

select * from bookings;

-- Payments Table
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    package_id INT NOT NULL,
    package_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('SUCCESS', 'FAILED') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE
);


-- Contact Messages Table
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from contact_messages;

