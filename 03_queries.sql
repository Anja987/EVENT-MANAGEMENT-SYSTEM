-- =============================================
-- EVENT MANAGEMENT SYSTEM

-- =============================================

USE event_management_db;

-- =============================================
-- SECTION 1: CREATE OPERATIONS 
-- =============================================

INSERT INTO venues (venue_name, venue_address, city, phone_number, capacity, rental_cost) 
VALUES ('New Convention Hall', '100 Exhibition Road', 'Stuttgart', '0711-1234567', 350, 3000.00);

INSERT INTO participants (first_name, last_name, email, phone_number, address, city, postal_code) 
VALUES ('Mark', 'Miller', 'mark.miller@email.com', '030-9999999', '1100 New Street', 'Berlin', '10119');

INSERT INTO events (event_name, event_description, event_type, venue_id, event_date, start_time, end_time, event_status, max_participants, ticket_price, organizer_name, organizer_email)
VALUES ('Database Design Masterclass', 'Learn advanced database design principles', 'Workshop', 2, '2024-12-20', '10:00:00', '13:00:00', 'Planned', 100, 89.99, 'Prof. Robert Chen', 'robert.chen@university.com');

INSERT INTO bookings (participant_id, event_id, booking_date, booking_status, number_of_tickets, total_cost)
VALUES (10, 1, '2024-11-08', 'Confirmed', 1, 99.99);

INSERT INTO payments (booking_id, amount_paid, payment_method, payment_status, transaction_id)
VALUES (14, 99.99, 'Credit Card', 'Completed', 'TXN014-2024');

-- =============================================
-- SECTION 2: READ OPERATIONS
-- =============================================

SELECT 
    event_id,
    event_name,
    event_type,
    event_date,
    start_time,
    ticket_price,
    organizer_name
FROM events
WHERE event_date >= CURDATE()
ORDER BY event_date ASC;

SELECT 
    venue_id,
    venue_name,
    city,
    capacity,
    rental_cost,
    phone_number
FROM venues
ORDER BY city ASC;

SELECT 
    participant_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    phone_number,
    city
FROM participants
ORDER BY last_name ASC;

SELECT 
    event_id,
    event_name,
    event_description,
    event_date,
    event_status,
    max_participants,
    ticket_price
FROM events
WHERE event_name LIKE '%Tech%';

SELECT 
    e.event_id,
    e.event_name,
    e.event_date,
    e.event_type,
    v.venue_name,
    v.city,
    v.capacity
FROM events e
JOIN venues v ON e.venue_id = v.venue_id
WHERE v.city = 'Berlin'
ORDER BY e.event_date ASC;

SELECT 
    b.booking_id,
    CONCAT(p.first_name, ' ', p.last_name) AS participant_name,
    p.email,
    b.booking_date,
    b.number_of_tickets,
    b.booking_status
FROM bookings b
JOIN participants p ON b.participant_id = p.participant_id
WHERE b.event_id = 1
ORDER BY b.booking_date DESC;

SELECT 
    e.event_id,
    e.event_name,
    e.event_date,
    e.start_time,
    v.venue_name,
    v.city,
    b.booking_status,
    b.number_of_tickets
FROM bookings b
JOIN events e ON b.event_id = e.event_id
JOIN venues v ON e.venue_id = v.venue_id
WHERE b.participant_id = 1
ORDER BY e.event_date ASC;

SELECT 
    e.event_id,
    e.event_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_cost) AS total_revenue,
    AVG(b.total_cost) AS average_booking_value
FROM events e
LEFT JOIN bookings b ON e.event_id = b.event_id
GROUP BY e.event_id, e.event_name
ORDER BY total_revenue DESC;

SELECT 
    e.event_id,
    e.event_name,
    e.max_participants,
    COUNT(b.booking_id) AS current_registrations,
    e.max_participants - COUNT(b.booking_id) AS available_spots,
    ROUND((COUNT(b.booking_id) / e.max_participants) * 100, 2) AS capacity_percentage
FROM events e
LEFT JOIN bookings b ON e.event_id = b.event_id
GROUP BY e.event_id, e.event_name, e.max_participants
ORDER BY capacity_percentage DESC;

SELECT 
    e.event_id,
    e.event_name,
    e.event_date,
    e.max_participants,
    COUNT(b.booking_id) AS current_registrations
FROM events e
LEFT JOIN bookings b ON e.event_id = b.event_id
GROUP BY e.event_id, e.event_name, e.event_date, e.max_participants
HAVING COUNT(b.booking_id) < 10
ORDER BY current_registrations ASC;

SELECT 
    payment_status,
    COUNT(*) AS number_of_payments,
    SUM(amount_paid) AS total_amount,
    AVG(amount_paid) AS average_amount
FROM payments
GROUP BY payment_status;

SELECT 
    b.booking_id,
    CONCAT(p.first_name, ' ', p.last_name) AS participant_name,
    e.event_name,
    b.total_cost,
    py.payment_status,
    py.payment_date
FROM bookings b
JOIN participants p ON b.participant_id = p.participant_id
JOIN events e ON b.event_id = e.event_id
JOIN payments py ON b.booking_id = py.booking_id
WHERE py.payment_status = 'Pending'
ORDER BY b.booking_date ASC;

SELECT 
    e.event_id,
    e.event_name,
    e.event_date,
    e.event_type,
    COUNT(b.booking_id) AS total_attendees,
    e.ticket_price,
    SUM(b.total_cost) AS total_revenue
FROM events e
LEFT JOIN bookings b ON e.event_id = b.event_id
WHERE e.event_status = 'Completed'
GROUP BY e.event_id, e.event_name, e.event_date, e.event_type, e.ticket_price
ORDER BY e.event_date DESC;

SELECT 
    v.venue_id,
    v.venue_name,
    v.city,
    v.capacity,
    COUNT(e.event_id) AS number_of_events,
    SUM(b.number_of_tickets) AS total_attendance
FROM venues v
LEFT JOIN events e ON v.venue_id = e.venue_id
LEFT JOIN bookings b ON e.event_id = b.event_id
GROUP BY v.venue_id, v.venue_name, v.city, v.capacity
ORDER BY number_of_events DESC;

-- =============================================
-- SECTION 3: UPDATE OPERATIONS
-- =============================================

UPDATE events
SET event_status = 'Ongoing'
WHERE event_id = 1;

UPDATE participants
SET phone_number = '030-5555555', email = 'newemail@email.com'
WHERE participant_id = 1;

UPDATE bookings
SET booking_status = 'Cancelled'
WHERE booking_id = 2;

UPDATE payments
SET payment_status = 'Completed', payment_date = NOW()
WHERE booking_id = 9 AND payment_status = 'Pending';

UPDATE events
SET event_status = 'Completed'
WHERE event_date < CURDATE() AND event_status != 'Completed';

UPDATE venues
SET capacity = 450, rental_cost = 5500.00
WHERE venue_id = 1;

-- =============================================
-- SECTION 4: DELETE OPERATIONS
-- =============================================

DELETE FROM bookings
WHERE booking_id = 5 AND booking_status != 'Completed'
LIMIT 1;

DELETE FROM payments
WHERE payment_status = 'Pending' 
AND payment_date < DATE_SUB(NOW(), INTERVAL 30 DAY)
LIMIT 10;

DELETE FROM events
WHERE event_id = 99 AND event_status = 'Cancelled';

DELETE FROM participants
WHERE participant_id = 99;

-- =============================================
-- SECTION 5: ADVANCED QUERIES
-- =============================================

SELECT 
    e.event_id,
    e.event_name,
    e.event_type,
    e.event_date,
    e.event_status,
    v.venue_name,
    v.city,
    v.capacity,
    COUNT(DISTINCT b.booking_id) AS number_of_bookings,
    COALESCE(SUM(b.total_cost), 0) AS total_revenue,
    (e.max_participants - COUNT(DISTINCT b.booking_id)) AS available_spots
FROM events e
JOIN venues v ON e.venue_id = v.venue_id
LEFT JOIN bookings b ON e.event_id = b.event_id
GROUP BY e.event_id, e.event_name, e.event_type, e.event_date, e.event_status, 
         v.venue_name, v.city, v.capacity, e.max_participants
ORDER BY e.event_date DESC;

SELECT 
    p.participant_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    p.email,
    COUNT(b.booking_id) AS events_attended,
    SUM(b.total_cost) AS total_spent,
    MAX(b.booking_date) AS last_booking_date
FROM participants p
LEFT JOIN bookings b ON p.participant_id = b.participant_id
GROUP BY p.participant_id, p.first_name, p.last_name, p.email
HAVING COUNT(b.booking_id) > 0
ORDER BY events_attended DESC;

SELECT 
    DATE_FORMAT(b.booking_date, '%Y-%m') AS month,
    COUNT(b.booking_id) AS bookings,
    SUM(b.total_cost) AS revenue
FROM bookings b
WHERE b.booking_status = 'Confirmed'
GROUP BY DATE_FORMAT(b.booking_date, '%Y-%m')
ORDER BY month DESC;

SELECT 
    e.event_name,
    p.city,
    COUNT(p.participant_id) AS participants_from_city,
    GROUP_CONCAT(CONCAT(p.first_name, ' ', p.last_name) SEPARATOR ', ') AS participant_names
FROM bookings b
JOIN events e ON b.event_id = e.event_id
JOIN participants p ON b.participant_id = p.participant_id
GROUP BY e.event_id, e.event_name, p.city
ORDER BY e.event_name, participants_from_city DESC;

SELECT 
    organizer_name,
    organizer_email,
    COUNT(event_id) AS number_of_events,
    SUM(max_participants) AS total_capacity,
    COUNT(DISTINCT venue_id) AS number_of_venues_used
FROM events
GROUP BY organizer_name, organizer_email
HAVING COUNT(event_id) > 1
ORDER BY number_of_events DESC;

