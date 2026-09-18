-- =============================================
-- EVENT MANAGEMENT SYSTEM DATABASE
-- =============================================


DROP DATABASE IF EXISTS event_management_db;

-- Create the database
CREATE DATABASE event_management_db;
USE event_management_db;

-- =============================================
-- TABLE 1: VENUES
-- =============================================

CREATE TABLE venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    venue_address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    capacity INT NOT NULL,
    rental_cost DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- TABLE 2: EVENTS
-- =============================================
--- this sorts events 

CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(150) NOT NULL,
    event_description TEXT,
    event_type VARCHAR(50) NOT NULL,
    venue_id INT NOT NULL,
    event_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    event_status VARCHAR(20) DEFAULT 'Planned',
    max_participants INT NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL,
    organizer_name VARCHAR(100) NOT NULL,
    organizer_email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venue_id) REFERENCES venues(venue_id) ON DELETE RESTRICT
);

-- =============================================
-- TABLE 3: PARTICIPANTS
-- =============================================
-- This stores the information about people who participated

CREATE TABLE participants (
    participant_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    postal_code VARCHAR(10),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- TABLE 4:- BOOKINGS
-- =============================================


CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    event_id INT NOT NULL,
    booking_date DATE NOT NULL,
    booking_status VARCHAR(20) DEFAULT 'Confirmed',
    number_of_tickets INT NOT NULL DEFAULT 1,
    total_cost DECIMAL(10, 2) NOT NULL,
    special_requirements TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    UNIQUE KEY unique_participant_event (participant_id, event_id)
);

-- =============================================
-- TABLE 5: PAYMENTS
-- =============================================
-- payments info about booking

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(100),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- =============================================
-- INDEXES FOR PERFORMANCE
-- =============================================

CREATE INDEX idx_event_date ON events(event_date);
CREATE INDEX idx_event_organizer ON events(organizer_email);
CREATE INDEX idx_booking_participant ON bookings(participant_id);
CREATE INDEX idx_booking_event ON bookings(event_id);
CREATE INDEX idx_payment_booking ON payments(booking_id);

-- =============================================
-- VIEWS FOR SIMPLIFIED ACCESS
-- =============================================

CREATE VIEW event_venue_details AS
SELECT 
    e.event_id,
    e.event_name,
    e.event_type,
    e.event_date,
    e.start_time,
    e.end_time,
    e.event_status,
    e.max_participants,
    e.ticket_price,
    v.venue_name,
    v.venue_address,
    v.city,
    v.capacity,
    COUNT(b.booking_id) AS current_registrations
FROM events e
JOIN venues v ON e.venue_id = v.venue_id
LEFT JOIN bookings b ON e.event_id = b.event_id
GROUP BY e.event_id, v.venue_id;

CREATE VIEW booking_details AS
SELECT 
    b.booking_id,
    p.participant_id,
    CONCAT(p.first_name, ' ', p.last_name) AS participant_name,
    p.email AS participant_email,
    e.event_id,
    e.event_name,
    e.event_date,
    b.booking_date,
    b.booking_status,
    b.number_of_tickets,
    b.total_cost
FROM bookings b
JOIN participants p ON b.participant_id = p.participant_id
JOIN events e ON b.event_id = e.event_id;


