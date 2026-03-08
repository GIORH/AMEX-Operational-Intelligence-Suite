# 📊 AMEX Operational Intelligence Suite 💳 📈

## 🚀 Enterprise Data Ecosystem (Sisense ElasticCube)
This repository showcases a comprehensive **Single Source of Truth (SSoT)** designed for AMEX operations, integrating 15+ complex fact tables to bridge the gap between operational performance and financial integrity.

![AMEX ElasticCube Architecture](./AMEX%20Elastic%20cube.png)

---

## 🏗️ Data Modeling Architecture

The project is structured into two core analytical pillars, utilizing **SQL (Sisense/Snowflake Dialect)** and **SCD Type 2 logic** for 100% historical accuracy.

### 1. 🛡️ Quality & Compliance Module
Focuses on internal/external audit alignment and customer sentiment (CSAT).
* **01-03 Internal Quality Framework**: Automated unpivoting of Soft Skills and Regulatory Compliance audits for granular failure-point analysis.
* **04-05 External Quality (RBST)**: Unified legacy and 2024 survey sources into a standardized schema for multi-year trend reporting.
* **06 Customer Experience (RTF/OSAT)**: Mathematical scoring model that transforms qualitative feedback into quantitative NPS-style KPIs.

### 2. ⚡ Operational Efficiency Module
A high-precision engine designed to optimize labor costs and agent productivity.
* **01-02 Adherence & Absenteeism**: Tracking "Planned vs. Actual" compliance and intelligent classification of schedule states (Sick, Late, PTO).
* **03 Workday Payroll Bridge**: Financial integration isolating operational paid hours from holidays for cost-per-hour analysis.
* **04 Agent States (Shrinkage)**: Normalization of 15+ system auxiliary states into "Billable" vs. "Non-Billable" categories.
* **05 Call Handling Time (CHT)**: Productivity modeling of Talk Time and ACW to monitor total agent capacity.

---

## 🛠️ Key Technical Features
* **SCD Implementation**: All models utilize Slowly Changing Dimensions via `ods_daterange_roster` to ensure accurate agent attribution over time.
* **Data Normalization**: Strategic use of `UNION ALL` and `UNPIVOT` to handle evolving data structures across fiscal years.
* **Defensive SQL**: Robust `CASE`, `CAST`, and `TOFLOAT` logic to prevent data-type mismatches in high-volume environments.

---

## 📁 Repository Structure
```text
AMEX-Operational-Intelligence-Suite/
├── modeling/
│   ├── quality-compliance/      # Audit, Compliance & CX Models (6 scripts)
│   └── operational-efficiency/  # Productivity & Payroll Models (5 scripts)
├── AMEX Elastic cube.png        # System Architecture Diagram
├── .gitignore                   # Environment protection
└── README.md                    # Project Documentation
