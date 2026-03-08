# 📊 AMEX Operational Intelligence Suite 💳 📈

## 🚀 Enterprise Data Ecosystem (Sisense ElasticCube)
This repository showcases a comprehensive **Single Source of Truth (SSoT)** designed for AMEX operations. It integrates 15+ complex fact tables and master dimensions to bridge the gap between operational performance, quality compliance, and financial integrity.

![AMEX ElasticCube Architecture](./AMEX%20Elastic%20cube.png)

---

## 🏗️ Data Modeling Architecture

The project follows a **Star Schema** approach, utilizing **SQL (Sisense/Snowflake Dialect)** and **SCD Type 2 logic** to ensure 100% historical accuracy in reporting.

### 1. 🛡️ Quality & Compliance Module
Focuses on internal/external audit alignment and customer sentiment (CSAT).
* **Internal Quality Framework**: Automated unpivoting of Soft Skills and Regulatory Compliance audits for granular failure-point analysis.
* **External Quality (RBST)**: Unified legacy and 2024/2025 survey sources into a standardized schema for multi-year trend reporting.
* **Customer Experience (RTF/OSAT)**: Mathematical scoring model that transforms qualitative feedback into quantitative NPS-style KPIs.

### 2. ⚡ Operational Efficiency Module
A high-precision engine designed to optimize labor costs and agent productivity.
* **Adherence & Absenteeism**: Tracking "Planned vs. Actual" compliance and intelligent classification of schedule states (Sick, Late, PTO).
* **Workday Payroll Bridge**: Financial integration isolating operational paid hours from holidays for accurate cost-per-hour analysis.
* **Agent States (Shrinkage)**: Normalization of 15+ system auxiliary states (AUX) into "Billable" vs. "Non-Billable" categories.
* **Call Handling Time (CHT)**: Productivity modeling of Talk Time and ACW to monitor total agent capacity.

### 3. 🧩 Core Dimensions (The Connectors)
The "glue" of the ecosystem, providing referential integrity across all modules.
* **Universal Date Dimension**: A central calendar hub with mapped keys for every fact table to enable seamless time-series analysis.
* **SCD Historical Roster**: Implementation of **Slowly Changing Dimensions (Type 2)** with a dummy record (-1) to handle orphaned records and ensure point-in-time attribution.
* **Master Roster Snapshot**: A unified identity layer combining Workday, Contractor, and Max Sine IDs for cross-platform data validation.

---

## 🛠️ Key Technical Features
* **SCD Implementation**: All models utilize `ods_daterange_roster` to ensure interactions are attributed to the correct leadership at the time of the event.
* **Data Normalization**: Strategic use of `UNION ALL` and `UNPIVOT` to handle evolving data structures across fiscal years.
* **Defensive SQL**: Robust `CASE`, `CAST`, and `TOFLOAT` logic to prevent data-type mismatches and handle null values.
* **Privacy by Design**: High-privacy tables (PII) and specific financial reimbursements are excluded to comply with data protection standards.

---

## 📁 Repository Structure
```text
AMEX-Operational-Intelligence-Suite/
├── modeling/
│   ├── quality-compliance/      # Audit, Compliance & CX Models (6 scripts)
│   ├── operational-efficiency/  # Productivity, Shrinkage & Payroll (5 scripts)
│   └── dimensions/              # Universal Calendar & SCD Rosters (3 scripts)
├── AMEX Elastic cube.png        # System Architecture Diagram
├── .gitignore                   # Environment protection
└── README.md                    # Project Documentation
