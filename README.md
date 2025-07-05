
# ABM Geodata SQL Analysis (Synthetic Project)

This repository showcases SQL querying and data analysis skills using a fully synthetic dataset inspired by real-world geospatial and operational data. The project is modeled after real tasks performed during my role as a Data Analyst at ABM Engineering.

> ⚠️ **Note:**  
> This dataset is entirely synthetic and was created for learning and demonstration purposes only. It does not contain any real or proprietary information from ABM Engineering.

---

## Dataset Overview

The database includes four main tables:

- **Locations**: Contains region names and GPS coordinates.
- **Wells**: Information about drilled wells, including depth, date, and status.
- **Measurements**: Geological data per well (porosity, permeability, pressure).
- **KPI_Data**: Business KPIs such as cost per well and efficiency index by region.

---

## SQL Concepts Demonstrated

- `JOIN`, `GROUP BY`, `WHERE`, `ORDER BY`
- Aggregations (e.g., `AVG`, `COUNT`)
- Filtering with conditions
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions (`RANK()`, `ROW_NUMBER()`, `AVG() OVER(...)`)
- KPI performance comparisons
- Geospatial insights using coordinates

---

## Sample Analyses

Some of the questions answered using SQL queries:

- What is the average well depth per region in the last 3 years?
- Which wells have a porosity greater than 14%?
- What is the efficiency index by region?
- How does each region's cost per well compare to the global average?
- What are the GPS coordinates of all active wells?
- What are the top 3 deepest wells?

---

## Tools Used

- Microsoft SQL Server (T-SQL)
- SSMS (SQL Server Management Studio)
- Git / GitHub

---

## Repository Structure

```
abm-sql-data-analysis/
├── schema.sql          # Database structure and sample data
├── queries.sql         # SQL queries: basic + advanced
└── README.md           # Project documentation
```

---

## 👤 Author

**Nazim Valikhanov**  
_Data Analyst_  
[LinkedIn Profile](https://www.linkedin.com/in/nazim-valikhanov/)

---
