<div style="text-align:center; padding:20px; border-radius:10px; background:#0B490A; color:white;">
  <h1 style="margin:0; font-size:38px;">🦠 Antimicrobial Resistance in Spain</h1>
  <h3 style="margin:0; font-weight:300;">2000–2018 • Data Analysis & Public Health Insights</h3>
</div>


This repository contains a complete data analysis project focused on **antimicrobial resistance (AMR)** in Spain, using surveillance data from the **European Antimicrobial Resistance Surveillance Network (EARS-Net)** covering the years **2000 to 2018**.

The project is designed following **industry‑standard practices** for data science and analytics, including modular code structure, reproducible workflows, and clear documentation.

---

## Executive Summary

This project analyzes 18 years of antimicrobial resistance (AMR) data in Spain using EARS‑Net surveillance records.  

The results show increasing resistance trends, especially in betalactam antibiotics and high‑risk pathogens such as *Acinetobacter spp.*.  

Age and gender analyses reveal distinct resistance patterns, with children aged 0–4 showing unique profiles.  

Predictive models (ARIMA and classification tree) indicate continued upward resistance trends across multiple antibiotic groups.  

These findings highlight the need for targeted surveillance, optimized antibiotic stewardship, and data‑driven public health strategies.

---

## Objectives

The analysis explores:

- Resistance patterns by **age group**
- Resistance patterns by **gender**
- **Bacteria–antibiotic** resistance profiles
- **Temporal evolution** of resistance across 18 years
- **Predictive modeling**, including:
  - Time series forecasting (ARIMA)
  - Classification tree for antibiotic decision support

The goal is to provide insights into AMR trends and support evidence‑based decision‑making in clinical and public health contexts.

---

## Project Structure

antimicrobial-resistance-spain/
│
├── data/
│   ├── raw/               # Original dataset (not modified)
│   └── processed/         # Cleaned and transformed datasets
│
├── reports/
│   └── antimicrobial_resistance_report.Rmd   # Full analysis report
│
├── outputs/
│   ├── figures/           # Generated plots
│   └── tables/            # Summary tables
│
├── scripts/               # Modular R scripts (optional if using the Rmd only)
│
└── README.md               # Project documentation
└── main.R                  # Pipeline entry point 
└── .gitignore
└── LICENSE

## Objectives

- Analyze AMR patterns by **age**, **gender**, **bacteria**, and **antibiotic group**
- Evaluate **temporal trends** in resistance
- Identify **high‑risk bacteria–antibiotic combinations**
- Build predictive models:
  - Time series forecasting (ARIMA)
  - Classification tree for antibiotic decision support

## How to Run

1. Clone the repository:

git clone https://github.com/PatriCT240/antimicrobial-resistance-spain.git

2. Place the raw dataset inside:

data/raw/

3. Open the RMarkdown report:

reports/antimicrobial_resistance_report.Rmd

4. Knit the document to HTML, PDF, or Word.

All analyses, visualizations, and models will be generated automatically.

---

## Methods and Techniques

The project includes:

- Data cleaning and transformation  
- Exploratory data analysis (EDA)  
- Boxplots, PCA, correlation matrices  
- ANOVA (multifactorial)  
- Time series modeling (ARIMA)  
- Classification tree modeling  
- Trend analysis for betalactam vs non‑betalactam antibiotics  

All code is written in **R**, following clean, readable, and reproducible standards.

---

## Data Source

- European Centre for Disease Prevention and Control (ECDC)  
- EARS-Net surveillance data  
- Pre‑cleaned dataset by Sam Fenske (Kaggle)

---

## References

See the full list of APA‑formatted references in the RMarkdown report.

---

## Author

**Patrícia C. Torrell**  
Clinical Data Analyst & Data Science Practitioner  
Focused on public health analytics, antimicrobial resistance, and reproducible research.
