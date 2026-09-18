-- =============================================
--- EVENT MANAGEMENT SYSTEM - SAMPLE DATA
-- =============================================

USE event_management_db;

-- =============================================
--- INSERT SAMPLE VENUES
-- =============================================

INSERT INTO venues (venue_name, venue_address, city, phone_number, capacity, rental_cost) VALUES
('Convention Center Hall A', '123 Main Street', 'Berlin', '030-12345678', 500, 5000.00),
('Riverside Conference Room', '456 River Road', 'Munich', '089-87654321', 200, 2000.00),
('Grand Ballroom Hotel', '789 Luxury Lane', 'Hamburg', '040-55555555', 300, 3500.00),
('Tech Innovation Hub', '321 Silicon Valley', 'Cologne', '0221-9999999', 150, 1500.00),
('Outdoor Garden Space', '654 Green Park', 'Frankfurt', '069-1111111', 400, 1000.00);

-- =============================================
--- INSERT SAMPLE EVENTS
-- =============================================

INSERT INTO events (event_name, event_description, event_type, venue_id, event_date, start_time, end_time, event_status, max_participants, ticket_price, organizer_name, organizer_email) VALUES
('Annual Tech Conference 2024', 'A major conference bringing together tech professionals', 'Conference', 1, '2024-12-15', '09:00:00', '17:00:00', 'Planned', 500, 99.99, 'John Smith', 'john.smith@techevents.com'),
('Sarah and Michael Wedding Reception', 'Celebration of marriage between Sarah Johnson and Michael Williams', 'Wedding', 3, '2024-11-23', '18:00:00', '23:30:00', 'Planned', 250, 0.00, 'Sarah Johnson', 'sarah.johnson@email.com'),
('European Business Summit', 'Summit for discussing business strategies and networking opportunities', 'Conference', 2, '2024-10-10', '08:30:00', '16:30:00', 'Completed', 200, 149.99, 'Emma Wilson', 'emma.wilson@business.com'),
('Live Jazz Night', 'Evening of live jazz music with international artists', 'Concert', 5, '2024-11-30', '19:00:00', '22:00:00', 'Planned', 400, 45.00, 'David Brown', 'david.brown@musicevents.com'),
('Web Development Workshop', 'Hands-on workshop for learning modern web development technologies', 'Workshop', 4, '2024-12-02', '10:00:00', '14:00:00', 'Planned', 150, 79.99, 'Lisa Chen', 'lisa.chen@techtraining.com');

-- =============================================
--- INSERT SAMPLE PARTICIPANTS
-- =============================================

INSERT INTO participants (first_name, last_name, email, phone_number, address, city, postal_code) VALUES
('Alice', 'Anderson', 'alice.anderson@email.com', '030-1111111', '100 Park Street', 'Berlin', '10115'),
('Bob', 'Brown', 'bob.brown@email.com', '089-2222222', '200 Mountain Road', 'Munich', '80331'),
('Catherine', 'Clark', 'catherine.clark@email.com', '040-3333333', '300 Harbor View', 'Hamburg', '20095'),
('Daniel', 'Davis', 'daniel.davis@email.com', '0221-4444444', '400 Tech Plaza', 'Cologne', '50667'),
('Emma', 'Evans', 'emma.evans@email.com', '069-5555555', '500 Garden Lane', 'Frankfurt', '60311'),
('Frank', 'Fischer', 'frank.fischer@email.com', '030-6666666', '600 Business Way', 'Berlin', '10117'),
('Grace', 'Garcia', 'grace.garcia@email.com', '089-7777777', '700 Art Street', 'Munich', '80333'),
('Henry', 'Harris', 'henry.harris@email.com', '040-8888888', '800 Commerce Road', 'Hamburg', '20097'),
('Isabella', 'Ionescu', 'isabella.ionescu@email.com', '0221-9999999', '900 Innovation Way', 'Cologne', '50668'),
('James', 'Johnson', 'james.johnson@email.com', '069-1010101', '1000 Trade Street', 'Frankfurt', '60312');

-- =============================================
--- INSERT SAMPLE BOOKINGS
-- =============================================

INSERT INTO bookings (participant_id, event_id, booking_date, booking_status, number_of_tickets, total_cost, special_requirements) VALUES
(1, 1, '2024-11-01', 'Confirmed', 1, 99.99, 'Vegetarian meal required'),
(2, 1, '2024-11-02', 'Confirmed', 2, 199.98, 'None'),
(3, 1, '2024-11-03', 'Confirmed', 1, 99.99, 'Wheelchair accessible seat needed'),
(6, 1, '2024-11-05', 'Confirmed', 1, 99.99, 'None'),
(4, 3, '2024-09-15', 'Completed', 1, 149.99, 'Gluten-free meals needed'),
(5, 3, '2024-09-16', 'Completed', 1, 149.99, 'None'),
(7, 3, '2024-09-17', 'Completed', 2, 299.98, 'None'),
(8, 4, '2024-11-10', 'Confirmed', 2, 90.00, 'VIP seating preferred'),
(9, 4, '2024-11-11', 'Confirmed', 1, 45.00, 'None'),
(10, 4, '2024-11-12', 'Confirmed', 3, 135.00, 'Together as a group'),
(1, 5, '2024-11-20', 'Confirmed', 1, 79.99, 'Beginner level participant'),
(2, 5, '2024-11-21', 'Confirmed', 1, 79.99, 'Advanced level participant'),
(4, 5, '2024-11-22', 'Confirmed', 1, 79.99, 'Intermediate level participant');

-- =============================================
--- INSERT SAMPLE PAYMENTS
-- =============================================

INSERT INTO payments (booking_id, amount_paid, payment_method, payment_status, transaction_id) VALUES
(1, 99.99, 'Credit Card', 'Completed', 'TXN001-2024'),
(2, 199.98, 'Online Transfer', 'Completed', 'TXN002-2024'),
(3, 99.99, 'Debit Card', 'Completed', 'TXN003-2024'),
(4, 99.99, 'Credit Card', 'Completed', 'TXN004-2024'),
(5, 149.99, 'Credit Card', 'Completed', 'TXN005-2024'),
(6, 149.99, 'Online Transfer', 'Completed', 'TXN006-2024'),
(7, 299.98, 'Credit Card', 'Completed', 'TXN007-2024'),
(8, 90.00, 'Credit Card', 'Completed', 'TXN008-2024'),
(9, 45.00, 'Debit Card', 'Pending', 'TXN009-2024'),
(10, 135.00, 'Online Transfer', 'Completed', 'TXN010-2024'),
(11, 79.99, 'Credit Card', 'Completed', 'TXN011-2024'),
(12, 79.99, 'Credit Card', 'Completed', 'TXN012-2024'),
(13, 79.99, 'Online Transfer', 'Pending', 'TXN013-2024');

-- =============================================
--- VERIFICATION QUERIES
-- =============================================

SELECT COUNT(*) AS total_venues FROM venues;
SELECT COUNT(*) AS total_events FROM events;
SELECT COUNT(*) AS total_participants FROM participants;
SELECT COUNT(*) AS total_bookings FROM bookings;
SELECT COUNT(*) AS total_payments FROM payments;

-- =============================================
--= DATA INSERTION COMPLETE
-- =============================================
