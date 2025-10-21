# State Legibility in the Digital Age: fsQCA Analysis of eGovernment Success in the EU 🇪🇺

**Author:** Daniel Commerford G.  
**Degree:** MSc Public Administration (AI and Governance), Vrije Universiteit Amsterdam  
**Supervisor:** Dr. Federica Fusi  
**Date:** August 2025  

---

## Overview

This repository contains the R scripts, calibration procedures, and supporting data for my Master’s Thesis *“State Legibility in the Digital Age: Civil Registry Comprehensiveness and Citizen Satisfaction with eGovernment in the EU.”* 

This study examines how the comprehensiveness of national civil registries — key instruments of state information capacity — shapes citizen satisfaction with digital public services in the European Union. Drawing on James C. Scott’s State Legibility Theory, it argues that states with more interoperable and transparent registry systems exhibit higher citizen satisfaction.

Using data from the 2024 eGovernment Benchmark and Special Eurobarometer 551, the analysis employs fuzzy-set Qualitative Comparative Analysis (fsQCA) to identify configurations of institutional, technical, and user-centric conditions that lead to high satisfaction. Results reveal multiple, equifinal pathways, confirming that successful eGovernment outcomes emerge from the joint presence of interoperability, realiable identification, and transparency rather than any single factor alone.

This thesis advances understanding of how state information capacity shapes citizen satisfaction with digital public services. Its findings provide both a theoretical and empirical foundation for future research on digital governance and offer policymakers evidence of the infrastructural conditions necessary for effective and inclusive eGovernment adoption

---

## Research Objective ❏

To determine **which combinations of institutional, technical, and user-centric conditions** lead to **high citizen satisfaction** with digital government services in the European Union.

**Research question:**  
> “Which configurations of causal conditions reflecting civil registry comprehensiveness are associated with higher public satisfaction in the 27 EU member states?”

---

## Methodological Summary

### Method: fsQCA (Fuzzy-set Qualitative Comparative Analysis)
- Based on set-theoretic logic (Ragin, 2008).
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
   
2. **Outcome calibration (fs_success)**
Calibrates Eurobarometer “positive perception” scores into fuzzy-set membership (0–1).  
**Thresholds:** [0.71, 0.77, 0.83]  
Visualized with an S-curve plot to show membership transformation.

3. **Condition calibration**

Six causal conditions represent dimensions of civil registry comprehensiveness:

| Condition | Benchmark Indicator | Thresholds (Full non-member, Crossover, Full member) |
|------------|--------------------|------------------------------------------------------|
| fs_user_support | User support / help tools | (80, 94.5, 98) |
| fs_eid | Electronic identification | (60, 71.5, 93) |
| fs_availability | Online and mobile availability | (90, 94, 98) |
| fs_edocument | Electronic document submission | (66.5, 86, 96) |
| fs_transparency | Transparency of service delivery | (60, 70, 80) |
| fs_prefilled | Pre-filled online forms | (60, 71, 85) |

---

## Visualization

- Histograms of fuzzy membership distributions for each calibrated condition  
- Grid plots (patchwork) illustrating threshold cutoffs and membership spread

---

## Necessity Analysis

Conducted using `QCAfit()` and `superSubset()` to test for single and disjunctive necessity.  
No single condition or negation meets the **0.90 necessity threshold**, indicating that success is **configurational**.

---

## Truth Table and Sufficiency Analysis

Created using `truthTable()` and minimized with `minimize()` to identify sufficient configurations leading to high success (`fs_success`).

---

## Conceptual Framework

Civil Registry Comprehensiveness (CRC) is operationalized through six measurable dimensions from the EU’s eGovernment Benchmark.  
Together, these form the informational foundation of state legibility in the digital age.

**Theoretical model:**

Civil Registry Comprehensiveness → Information Capacity → Effective Digital Public Service Delivery → Citizen Satisfaction

This framework bridges **James C. Scott’s State Legibility Theory** with modern digital governance research, showing how well-integrated, transparent, and user-centric digital infrastructures foster higher citizen trust and satisfaction.

---

## 📈 Expected Outputs

- Calibrated dataset (`IV - condition scores.xlsx` with fuzzy-set transformations)
- Diagnostic plots showing calibration curves and membership distributions
- Truth table summarizing consistent configurations of conditions
- Minimized solutions identifying alternative (equifinal) pathways to high success

**Example outcome structure:**
```r
solution <- minimize(tt, details = TRUE, show.cases = TRUE)
print(solution)
```

Output includes:

- Consistency and coverage scores for each configuration
- Case membership (countries) per solution pathway
- Interpretation of necessary vs. sufficient conditions

---

##  Dependencies

Install required R packages before running:
```r
install.packages(c(
  "QCA", "SetMethods", "psych", "readxl", "ggplot2",
  "writexl", "tidyverse", "knitr", "rmarkdown",
  "dplyr", "patchwork"
))
```

---

## ✍︎ Citation 

If you use this repository, please cite as:

Commerford, D. (2025). State Legibility in the Digital Age: Civil Registry 
Comprehensiveness and Citizen Satisfaction with eGovernment in the EU. 
[Master's thesis, Vrije Universiteit Amsterdam].


---

## Repository Contents
```
 VUThesis_fsQCA/
 ├── VUThesis_fsQCA.R                  # Main analysis script
 ├── IV - condition scores.xlsx        # Input dataset (EU27 indicators)
 ├── calibration_plots/                # Calibration visualizations
 ├── truth_tables/                     # Truth table outputs
 ├── thesis_reference.pdf              # Thesis manuscript (optional)
 └── README.md                         # Project overview
```

---

## License

This work is released under the MIT License. You are free to use, modify, and distribute the code with appropriate attribution.

---

## 🤝 Acknowledgments

This project was supervised by Dr. Federica Fusi (Vrije Universiteit Amsterdam) and supported by data from the European Commission and Eurobarometer research programs.


