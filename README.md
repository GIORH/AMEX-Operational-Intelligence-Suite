# AMEX Operational Intelligence Suite 💳📊

## 🏗️ Enterprise Data Ecosystem (Sisense ElastiCube)
This repository showcases a comprehensive **Single Source of Truth (SSoT)** designed for AMEX operations, integrating 15+ complex fact tables to bridge the gap between operational performance and financial integrity.

![AMEX ElastiCube Architecture](./AMEX%20Elastic%20cube.png)

### 🧩 Architectural Pillars
* **Operational Efficiency:** Integration of `fact_cht`, `fact_aux`, and `fact_workday` to analyze Shrinkage (Paid vs. Connected time).
* **360° Quality & Experience:** Unified view of Internal Quality (`fact_rtf`, `vibes_fact`), External Audits (`fact_rbst_survey`), and Soft Skills (`m1_comp_str_ce`).
* **Financial & Risk Integrity:** Monitoring `fact_writeoff` to quantify human error impact and a nested **Training Compliance Cube** for 100% audit readiness.
* **Data Governance:** Consolidation of hybrid rosters (`operations_master_roster`) and historical versioning for 2025 migrations.
