# State Legibility in the Digital Age: fsQCA Analysis of eGovernment Success in the EU

**Author:** Daniel Commerford  
**Degree:** MSc in AI and Governance, Vrije Universiteit Amsterdam  
**Supervisor:** Dr. Federica Fusi  
**Date:** August 2025  

---

## Overview

This repository contains the R scripts, calibration procedures, and supporting data for my Master’s Thesis *“State Legibility in the Digital Age: Civil Registry Comprehensiveness and Citizen Satisfaction with eGovernment in the EU.”*  

The study investigates how the **comprehensiveness of national civil registries**—as conceptualized through **State Legibility Theory (Scott, 2020)**—affects **citizen satisfaction with digital public services** across the 27 EU member states. Using **Fuzzy-set Qualitative Comparative Analysis (fsQCA)**, it identifies **configurations of digital infrastructure and governance factors** that jointly lead to successful public service delivery.

---

## Research Objective

To determine **which combinations of institutional, technical, and user-centric conditions** lead to **high citizen satisfaction** with digital government services in the European Union.

**Research question:**  
> “Which configurations of causal conditions reflecting civil registry comprehensiveness are associated with higher public satisfaction in the 27 EU member states?”

---

## Methodological Summary

### Method: fsQCA (Fuzzy-set Qualitative Comparative Analysis)
- Based on **set-theoretic logic (Ragin, 2008)**.
- Captures **causal complexity, equifinality, and asymmetry**—that is, multiple pathways to the same successful outcome.
- Implemented in **R** using the `QCA` and `SetMethods` packages.

### Data Sources
| Source | Description | Year |
|---------|--------------|------|
| **EU eGovernment Benchmark** | Measures digital public service performance across 4 dimensions: User Centricity, Transparency, Key Enablers, Cross-Border Services. | 2022–2023 |
| **Special Eurobarometer 551 – The Digital Decade** | Measures citizens’ perceptions of whether digitalization “makes life easier or more difficult.” Serves as the *outcome variable*. | 2024 |

---

## Code Structure

### Main Script: `fsQCA_civil_registry.R`

This R script performs the complete analytical pipeline:

1. **Load and inspect data**
   ```r
   data <- read_excel("IV - condition scores.xlsx")
   head(data)
