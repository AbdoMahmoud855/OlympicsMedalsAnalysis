# 🏅 Summer Olympics Medals Analysis — SQL Window Functions

Ranking countries and athletes in the Summer Olympics dataset using SQL Server, to find who dominates each year and who the top performers are.

---

## 📌 Project Overview

This project goes beyond simple data retrieval. It uses **Window Functions and CTEs** to rank data inside groups and answer questions such as: which country won the most medals in each Olympic year, and who is the most decorated athlete in each country.

## 🗂️ Dataset

The `summer` table contains Summer Olympics medal records. Columns used in this project:

| Column | Description |
|---|---|
| `Year` | Olympic year |
| `Athlete` | Athlete name |
| `Country` | Country the athlete represents |
| `Medal` | Medal won |

---

## 🧠 Queries & Solutions

| # | Task | Techniques |
|---|---|---|
| 1 | Assign a sequence number to each row | `ROW_NUMBER()` |
| 2 | Assign a sequence number within each year | `ROW_NUMBER()`, `PARTITION BY` |
| 3 | Count medals per athlete and rank athletes by total medals | `COUNT()`, `GROUP BY`, `ROW_NUMBER()` |
| 4 | Count medals per country in each year and rank countries within the year | `COUNT()`, `PARTITION BY` |
| 5 | Find the country with the most medals in each year | CTE, `ROW_NUMBER()`, `PARTITION BY` |
| 6 | Find the athlete with the most medals in each country | CTE, `ROW_NUMBER()`, `PARTITION BY` |

### Example: Top Country in Each Olympic Year

```sql
WITH ranking_country AS (
    SELECT 
        s.year,
        s.country,
        COUNT(s.medal) AS n_medals,
        ROW_NUMBER() OVER (
            PARTITION BY s.year 
            ORDER BY COUNT(s.medal) DESC
        ) AS rank_1
    FROM summer AS s
    GROUP BY s.year, s.country
)
SELECT country, n_medals, year
FROM ranking_country
WHERE rank_1 = 1
ORDER BY year;
```

---

## 💡 Key Concepts Practiced

- **ROW_NUMBER():** assigning sequential numbers to rows
- **PARTITION BY:** restarting the ranking for each group (year, country)
- **GROUP BY vs window functions:** grouping collapses rows, while window functions keep them and rank inside each group
- **CTEs:** isolating `rank = 1` to get the top result per group in a clean, readable query
- **Aggregate functions** combined with window functions

## 📝 Notes

`ROW_NUMBER()` breaks ties arbitrarily. If two countries or athletes have the same number of medals, only one is returned. For tie-aware results, `RANK()` or `DENSE_RANK()` would be the better choice.

---

## 🗂️ Data Source

The dataset is available here:
🔗 [Add the dataset link]

> The data is not included in this repository. Download it and import it into SQL Server as a table named `summer` before running the queries.

## ▶️ How to Run

1. Install **SQL Server** and **SQL Server Management Studio** (or Azure Data Studio).
2. Import the dataset into a table named `summer` (in the `dbo` schema).
3. Open `olympic_medals_analysis.sql` and run each query.


## 🛠️ Tools

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Window Functions](https://img.shields.io/badge/Window%20Functions-0A66C2?style=for-the-badge)
![CTEs](https://img.shields.io/badge/CTEs-444444?style=for-the-badge)

