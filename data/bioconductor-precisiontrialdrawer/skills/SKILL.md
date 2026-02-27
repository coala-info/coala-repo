---
name: bioconductor-precisiontrialdrawer
description: This tool designs and analyzes NGS-based gene panels for cancer clinical trials by simulating their effectiveness against genomic data. Use when user asks to design gene panels for umbrella or basket trials, fetch genomic data from cBioPortal, calculate patient coverage, or perform power and sample size estimations for clinical studies.
homepage: https://bioconductor.org/packages/3.9/bioc/html/PrecisionTrialDrawer.html
---


# bioconductor-precisiontrialdrawer

name: bioconductor-precisiontrialdrawer
description: Analyze and design NGS-based gene panels for cancer clinical trials (umbrella and basket trials). Use this skill to create CancerPanel objects, fetch genomic data from cBioPortal, calculate patient coverage, perform power/sample size estimations for survival or proportion studies, and generate BED files for panel design.

## Overview

PrecisionTrialDrawer (PTD) is a Bioconductor package designed to bridge the gap between cancer research and clinical genomics. It allows users to simulate the effectiveness of custom gene panels by testing them against real-world genomic data (mutations, copy number alterations, expression, and fusions). It is particularly useful for designing "umbrella" (one tumor, multiple drugs) and "basket" (one drug, multiple tumors) clinical trials.

## Core Workflow

### 1. Defining the Cancer Panel
A panel is a data frame where each row represents a specific alteration.

```r
library(PrecisionTrialDrawer)
# Example structure
panel_df <- data.frame(
  drug = c("Vemurafenib", "no_drug"),
  gene_symbol = c("BRAF", "KRAS"),
  alteration = c("SNV", "SNV"),
  exact_alteration = c("amino_acid_variant", "mutation_type"),
  mutation_specification = c("V600E", "missense"),
  group = c("Actionable", "Driver"),
  stringsAsFactors = FALSE
)

# Initialize the CancerPanel object
mypanel <- newCancerPanel(panel_df)
```

### 2. Data Acquisition
Fetch data from cBioportal or provide custom datasets.

```r
# Check available tumor types
showTumorType()

# Fetch data for specific cancers (e.g., breast and lung)
mypanel <- getAlterations(mypanel, tumor_type = c("brca", "luad"))

# Apply panel specifications to the downloaded data
mypanel <- subsetAlterations(mypanel)
```

### 3. Visualization and Statistics
Evaluate how well the panel covers the patient population.

*   **Coverage**: `coveragePlot(mypanel, grouping="tumor_type")` shows absolute samples covered.
*   **Stacked Coverage**: `coverageStackPlot(mypanel, var="drug", grouping="gene_symbol")` breaks down drug coverage by gene.
*   **Saturation**: `saturationPlot(mypanel, adding="gene_symbol")` shows the trade-off between genomic space and patient coverage.
*   **Mutual Exclusivity**: `coocMutexPlot(mypanel, var="drug")` identifies if alterations occur in the same or different patients.

### 4. Power and Sample Size Calculation
Estimate the required screening size for clinical trials.

```r
# Survival study power calculation
survPowerSampleSize(mypanel, 
                    HR = c(0.5, 0.6), 
                    power = 0.8, 
                    alpha = 0.05, 
                    fu = 3) # 3 years follow-up
```

**Priority Trials**: For multi-drug designs, use the `priority.trial` parameter in `survPowerSampleSize` to simulate a cascade algorithm that minimizes the total number of patients to screen.

### 5. Basket Trial Design
Adjust for unbalanced sample sizes across tumor types using:
*   `tumor.freqs`: Weighted mean frequencies (e.g., `c(brca=0.5, luad=0.5)`).
*   `tumor.weights`: Randomly sample a fixed number of patients per tumor type.

### 6. Panel Design (BED Generation)
Convert the validated panel into a BED format for NGS providers.

```r
mydesign <- panelDesigner(mypanel, padding_length = 10, merge_window = 100)
# Access the BED file
head(mydesign$BedStylePanel)
```

## Tips and Best Practices
*   **Rules**: Use the `rules` parameter in `newCancerPanel` or `subsetAlterations` to handle drug resistance (e.g., exclude Erlotinib if KRAS is mutated).
*   **Mirror Servers**: If biomaRt is slow, use `myhost` in `newCancerPanel` (e.g., `"uswest.ensembl.org"`).
*   **Interactive Optimization**: Use `panelOptimizer(mypanel)` to launch a Shiny app for ratiometric design of genomic regions.
*   **Data Extraction**: Use `dataExtractor()` to pull raw data for custom plotting outside the package's built-in functions.

## Reference documentation
- [PrecisionTrialDrawer](./references/PrecisionTrialDrawer.md)