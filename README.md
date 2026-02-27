# ⚽ FIFA World Cup Match Analysis (1930–2014)

> An end-to-end data analysis project exploring 84 years of FIFA World Cup match data — covering goals, wins, attendance trends, and team performance using SQL, Excel, and PowerPoint.

---

## 📌 Project Overview

This project performs a comprehensive analysis of FIFA World Cup matches from **1930 to 2014**, covering all **20 tournaments** and **835 matches**. The goal was to uncover patterns and insights from historical match data using structured SQL queries, and present the findings through a professional visual presentation.

The analysis answers questions like:
- Which team scored the most goals across all World Cups?
- Which year had the highest average goals per match?
- How often do home teams win vs away teams?
- How has tournament attendance grown over the decades?

---

## 👥 Team

| Name | Role |
|------|------|
| **Kaushiki Sharma** | Data Analysis, SQL Queries, Presentation |
| **Sakshi** | Collaborator |
| **Shagun Vashisth** | Collaborator |

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white) | Data querying & analysis |
| ![Excel](https://img.shields.io/badge/Excel-217346?style=flat&logo=microsoft-excel&logoColor=white) | Data cleaning & exploration |
| ![PowerPoint](https://img.shields.io/badge/PowerPoint-B7472A?style=flat&logo=microsoft-powerpoint&logoColor=white) | Presentation design |
| 🔲 Power BI | Dashboard *(coming soon)* |

---

## 📁 Repository Structure

```
WorldCup-Analysis/
│
├── data/
│   └── WorldCupMatches_cleaned.csv      # Cleaned dataset (835 matches)
│
├── sql/
│   └── WorldCupMatch_Sql.sql            # 40 SQL queries for full analysis
│
├── presentation/
│   └── WorldCup_Analysis.pptx           # 7-slide professional presentation
│
├── dashboard/                           # Coming soon — Power BI dashboard
│
└── README.md
```

---

## 📊 Dataset

- **Source:** FIFA World Cup Matches (publicly available dataset)
- **Period:** 1930 – 2014
- **Records:** 835 matches across 20 tournaments
- **Key Columns:** Year, Stage, Home Team, Away Team, Home Goals, Away Goals, Attendance, City, Stadium

---

## 🔍 SQL Analysis — Query Highlights

The `sql/WorldCupMatch_Sql.sql` file contains **40 queries** ranging from basic to advanced:

| # | Query | Type |
|---|-------|------|
| Q1–Q10 | Basic SELECT, filters, sorting | Beginner |
| Q11–Q20 | Aggregations — SUM, AVG, COUNT, GROUP BY | Intermediate |
| Q21–Q30 | HAVING, subqueries, multi-column grouping | Intermediate |
| Q31–Q40 | Window functions — RANK(), DENSE_RANK(), OVER() | Advanced |

**Sample — Team with Most Goals (UNION + Subquery):**
```sql
SELECT Team, SUM(Goals) AS Total_Goals
FROM (
    SELECT `Home Team Name` AS Team, `Home Team Goals` AS Goals FROM worldcupmatches_cleaned
    UNION ALL
    SELECT `Away Team Name`, `Away Team Goals` FROM worldcupmatches_cleaned
) t
GROUP BY Team
ORDER BY Total_Goals DESC
LIMIT 1;
```

**Sample — Rank Teams by Goals (Window Function):**
```sql
SELECT Team,
       SUM(Goals) AS Total_Goals,
       RANK() OVER (ORDER BY SUM(Goals) DESC) AS Goal_Rank
FROM (
    SELECT `Home Team Name` AS Team, `Home Team Goals` AS Goals FROM worldcupmatches_cleaned
    UNION ALL
    SELECT `Away Team Name`, `Away Team Goals` FROM worldcupmatches_cleaned
) t
GROUP BY Team;
```

---

## 📈 Key Findings

| Insight | Detail |
|---------|--------|
| 🏆 **Most Successful Team** | Brazil — 221 goals & 70 wins across all tournaments |
| ⚽ **Most Goals in a Year** | 1998 — 171 total goals (64 matches) |
| 📊 **Highest Avg Goals/Match** | 1954 — 5.38 goals per match |
| 🏠 **Home Advantage** | Home teams won 57% of matches vs 20% for away teams |
| 📉 **Lowest Scoring Era** | 1990 — 2.21 avg goals per match |
| 🌍 **Tournament Growth** | Expanded from 13 teams (1930) to 32 teams (1998+) |

---

## 🖥️ Presentation Slides

The presentation covers 7 slides with charts, stat cards, and insights:

| Slide | Title |
|-------|-------|
| 1 | Title — FIFA World Cup Historical Match Analysis |
| 2 | Key Statistics at a Glance |
| 3 | Goals Scored Per World Cup (Bar Chart) |
| 4 | Top Teams by Total Goals Scored |
| 5 | Match Outcomes & Scoring Insights |
| 6 | SQL Analysis — Query Highlights |
| 7 | Key Findings & Conclusions |

---

## 🔲 Coming Soon

- [ ] Power BI interactive dashboard
- [ ] Team-level deep dive analysis
- [ ] Host country performance analysis

---

## 📬 Contact

Feel free to reach out or connect:

**Kaushiki Sharma** — *Data Analyst*  
**Shakshi Rawat** — *Data Analyst*  
**Shagun Vashisth** — *Data Analyst*

---

*Data sourced from the FIFA World Cup Matches public dataset. All analysis performed for educational purposes.*
