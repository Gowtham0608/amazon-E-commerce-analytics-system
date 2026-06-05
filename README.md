# 🛒 Amazon E-Commerce — Business Analytics SQL Project

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-orange)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Level](https://img.shields.io/badge/Level-Beginner%20to%20Intermediate-yellow)

> An end-to-end SQL analytics project simulating a real Amazon marketplace — covering seller performance, customer behaviour, revenue analysis, and order fulfilment metrics.

---

## 📌 Project Overview

This project models a simplified Amazon-style e-commerce platform with 5 relational tables and answers **13 business questions** a real Business Analyst would be expected to solve. It demonstrates:

- Relational database design (DDL)
- Data loading (DML)
- Analytical SQL — joins, aggregates, window functions, CASE WHEN
- ETL thinking — calculated fields, data quality checks, reusable views

Built as a portfolio project targeting roles like **Business Analyst**, **Data Analyst**, and **SQL Developer** at e-commerce companies.

---

## 🗂️ Repository Structure

```
amazon-sql-project/
│
├── README.md                          ← You are here
├── schema/
│   └── schema_diagram.md              ← ERD & table descriptions
├── sql/
│   ├── 01_create_tables.sql           ← DDL — table definitions
│   ├── 02_insert_data.sql             ← DML — sample data
│   ├── 03_verify_data.sql             ← sanity checks
│   ├── 04_business_questions.sql      ← 13 analytical queries
│   └── 05_bonus_views.sql             ← views & advanced queries
├── results/
│   └── query_outputs.md               ← expected outputs for each query
└── CONTRIBUTING.md                    ← how to contribute or extend
```

---

## 🏗️ Database Schema

Five tables model the full order lifecycle:

```
customers ──< orders ──< order_items >── products >── sellers
```

| Table | Description | Rows |
|---|---|---|
| `customers` | Registered buyers with city & country | 6 |
| `sellers` | Marketplace vendors with rating & status | 5 |
| `products` | Items listed by sellers with price & stock | 6 |
| `orders` | Customer orders with status & total amount | 10 |
| `order_items` | Line items per order with quantity & discount | 11 |

Full ERD → [`schema/schema_diagram.md`](schema/schema_diagram.md)

---

## ❓ Business Questions Answered

| # | Question | SQL Concepts |
|---|---|---|
| Q1 | Total revenue from delivered orders | `SUM()`, `WHERE` |
| Q2 | Order count by status | `COUNT()`, `GROUP BY` |
| Q3 | Top 3 customers by spending | `JOIN`, `SUM()`, `LIMIT` |
| Q4 | Products listed per seller | `LEFT JOIN`, `COUNT()` |
| Q5 | Revenue per product category | Multi-table `JOIN`, `SUM()` |
| Q6 | Average order value per customer | `AVG()`, `ROUND()` |
| Q7 | Low stock alert (< 100 units) | `JOIN`, `WHERE` |
| Q8 | Monthly revenue trend | `DATE_FORMAT()`, time-series |
| Q9 | Top seller by net revenue | 4-table `JOIN`, discount calc |
| Q10 | Repeat customers (> 1 order) | `HAVING`, `COUNT()` |
| Q11 | Customer distribution by city | `GROUP BY`, `COUNT()` |
| Q12 | Customer spending rank | `RANK() OVER()` window function |
| Q13 | Return rate per seller | `CASE WHEN`, conditional agg |

---

## 🚀 How to Run

### Prerequisites
- MySQL 8.0+ (or MariaDB 10.5+)
- MySQL Workbench, DBeaver, or any SQL client

### Step-by-step

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/amazon-sql-project.git
cd amazon-sql-project

# 2. Open MySQL Workbench and connect to your local server

# 3. Run scripts in order:
#    sql/01_create_tables.sql
#    sql/02_insert_data.sql
#    sql/03_verify_data.sql
#    sql/04_business_questions.sql
#    sql/05_bonus_views.sql
```

Or run everything at once from the terminal:

```bash
mysql -u root -p < sql/01_create_tables.sql
mysql -u root -p amazon_db < sql/02_insert_data.sql
mysql -u root -p amazon_db < sql/04_business_questions.sql
```

---

## 💡 Key Concepts Demonstrated

```
✅ DDL            — CREATE TABLE, PRIMARY KEY, FOREIGN KEY, DEFAULT
✅ DML            — INSERT with multi-row values
✅ Joins          — INNER JOIN, LEFT JOIN, 4-table joins
✅ Aggregates     — SUM, COUNT, AVG, ROUND
✅ Filtering      — WHERE, HAVING (know the difference!)
✅ Grouping       — GROUP BY single and multiple columns
✅ Sorting        — ORDER BY ASC / DESC, LIMIT
✅ Date functions — DATE_FORMAT() for time-series analysis
✅ Conditionals   — CASE WHEN for conditional aggregation
✅ Window fns     — RANK() OVER() for customer leaderboard
✅ Views          — CREATE VIEW for reusable reporting layers
✅ Subqueries     — Inline derived tables
```

---

## 📊 Sample Output

**Q3 — Top 3 Customers by Spending**

```sql
SELECT c.customer_name, c.city, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 3;
```

| customer_name | city | total_spent |
|---|---|---|
| John Lee | New York | 6149.00 |
| Ravi Kumar | Mumbai | 4997.00 |
| Sunita Patel | Chennai | 4850.00 |

---

**Q12 — Customer Spending Rank (Window Function)**

```sql
SELECT customer_name, city, total_spent,
       RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM (
    SELECT c.customer_id, c.customer_name, c.city,
           SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name, c.city
) AS customer_totals
ORDER BY spending_rank;
```

| customer_name | city | total_spent | spending_rank |
|---|---|---|---|
| John Lee | New York | 6149.00 | 1 |
| Ravi Kumar | Mumbai | 4997.00 | 2 |
| Sunita Patel | Chennai | 4850.00 | 3 |
| Amit Sharma | Bangalore | 3700.00 | 4 |
| Priya Singh | Delhi | 1149.00 | 5 |

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Database engine |
| MySQL Workbench | Query development & ERD |
| SQL editing |
| GitHub | Version control & portfolio |

---

## 👤 Author

**Gowtham Ravindran**
- LinkedIn: [linkedin.com/in/gowthamravindran06](https://www.linkedin.com/in/gowthamravindran06/)
- GitHub: https://github.com/Gowtham0608
- Email: gowthamr.analyst06@gmail.com

---

## 📄 License

This project is open source under the [MIT License](LICENSE).

---

> ⭐ If this project helped you, please consider giving it a star on GitHub!
