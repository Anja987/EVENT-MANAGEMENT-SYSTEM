# Event Management System

A relational database for managing events, participants, venues, bookings, and payments.

---

## What does it do?

I chose an event management system because it involves multiple interconnected entities with real-world relationships. Events are hosted at venues, participants register for events through bookings, and payments are tracked separately. This makes it an excellent example for demonstrating database design and relationships.

The database can:

- Store venue and event information
- Manage event registrations and participant details
- Handle multiple booking scenarios (single or group registrations)
- Track payment information and status
- Generate reports on capacity, revenue, and attendance

---

## File Structure

```
event-management-system/
│
├── sql/
│   ├── 01_schema.sql        # -- This Creates all the tables
│   ├── 02_sample_data.sql   # --This Adds sample data to the tables
│   └── 03_queries.sql       # --SQL queries for all operations
│
├── docs/
│   ├── erd.png              # --Entity Relationship Diagram
│   ├── report.pdf           # --Project report 
│   └── report.docx          # --Project report 
│
└── README.md
```

---


### Option 1: Using Command Line

```bash
mysql -u root -p < sql/01_schema.sql
mysql -u root -p < sql/02_sample_data.sql
```

### Option 2: Using MySQL Client or GUI Tool

1. Open your MySQL client (MySQL Workbench, SSMS, SQLPro, etc.)
2. Create a new query
3. Copy and paste content from `sql/01_schema.sql`
4. Execute the query
5. Repeat steps 2-4 with `sql/02_sample_data.sql`
6. Run any query from `sql/03_queries.sql` to test

---

## Tables

| Table | Purpose |
|-------|---------|
| **venues** | Stores venue information (name, address, capacity, rental cost) |
| **events** | Stores event details (name, date, time, type, organizer, ticket price) |
| **participants** | Stores attendee information (name, email, phone, address) |
| **bookings** | Junction table linking participants to events (registrations) |
| **payments** | Stores payment records for each booking |

---

## Database Relationships

```
VENUES (one-to-many)
EVENTS(many-to-many through BOOKINGS)
PARTICIPANTS
BOOKING(one-to-many)
PAYMENTS
```

---

## Queries Included

      | Type | What it does |

| **SELECT** | Retrieve venues, events, participants, bookings, payments |
| **INSERT** | Add new venues, events, participants, bookings, payments |
| **UPDATE** | Change event status, participant info, payment status |
| **DELETE** | Cancel bookings, remove events, delete participants |
| **JOIN** | Combine data from multiple tables (2-3 table joins) |
| **GROUP BY / COUNT / SUM** | Calculate totals, statistics, and revenue |
| **HAVING** | Filter grouped results |
| **ORDER BY** | Sort results by various fields |

---

## Sample Data

The database comes pre-loaded with:

- **5 Venues** across German cities (Berlin, Munich, Hamburg, Cologne, Frankfurt)
- **5 Events** of different types (Conference, Wedding, Concert, Workshop)
- **10 Participants** with complete contact information
- **13 Bookings** showing various registration scenarios
- **13 Payments** with different payment methods and statuses

---

## Key Features

 **Proper Normalization** - Follows 1NF, 2NF, 3NF principles  
 **Referential Integrity** - Foreign key constraints enforce data consistency  
 **Cascading Deletes** - Automatic cleanup of related records  
 **Indexes** - Performance optimization on frequently searched columns  
 **Views** - Simplified access to complex multi-table queries  
 **Complete CRUD** - All Create, Read, Update, Delete operations included  
 **Advanced Queries** - Aggregations, joins, and business logic included  
 **Well-Commented** - Every query and script is documented  

---

## Video Demonstration

A video demonstration showing:
- Database structure and table creation
- Sample data insertion
- Running various SELECT queries
- Demonstrating JOIN operations
- Showing GROUP BY aggregations
- Testing CRUD operations (INSERT, UPDATE, DELETE)

**Watch the video:** [Video Link Here]

---

## Author Information

**Name:**Anjali  
**Student ID:** GH1043715  
**University:** Gisma University of Applied Sciences  
**Module:** B103 Databases & Big Data  



---

## How to Test

1. **Run the schema ** (01_schema.sql) to create tables
2. **Run the sample data script** (02_sample_data.sql) to populate data
3. **Run queries** from 03_queries.sql to verify functionality

---


### Quick Start

```bash
# Step 1: Create database and tables
mysql -u root -p event_management_db < sql/01_schema.sql

# Step 2: Insert sample data
mysql -u root -p event_management_db < sql/02_sample_data.sql

# Step 3: Run a test query
mysql -u root -p event_management_db < sql/03_queries.sql
```





---



