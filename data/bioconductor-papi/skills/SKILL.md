---
name: bioconductor-papi
description: This tool predicts metabolic pathway activity from metabolite abundance data using the PAPi algorithm. Use when user asks to map metabolite names to KEGG codes, calculate pathway activity scores, perform statistical comparisons between experimental conditions, or visualize pathway activity changes.
homepage: https://bioconductor.org/packages/3.5/bioc/html/PAPi.html
---


# bioconductor-papi

name: bioconductor-papi
description: Predict metabolic pathway activity from metabolomics data using the PAPi algorithm. Use this skill when you need to map metabolite abundances to KEGG pathways, calculate pathway activity scores, perform statistical comparisons (ANOVA/t-test) between experimental conditions, and visualize pathway activity changes.

# bioconductor-papi

## Overview

The Pathway Activity Profiling (PAPi) package predicts the activity of metabolic pathways based on metabolite abundance data. Unlike traditional enrichment analysis, PAPi generates "Activity Scores" (AS) for each pathway. A key characteristic of PAPi is that the Activity Score is inversely proportional to the predicted pathway activity (higher score = lower activity). The package automates the mapping of metabolite names to KEGG codes and provides tools for statistical testing and visualization.

## Core Workflow

### 1. Data Preparation
PAPi requires a data frame where the first column contains metabolite identifiers and subsequent columns contain abundances. To enable automatic group detection, the first row should define experimental conditions.

```r
# Example structure
# Row 1: "Replicates", "cond1", "cond1", "cond2", "cond2"
# Row 2: "Glucose", 0.8, 0.6, 1.2, 1.1
```

### 2. Mapping to KEGG Codes
The `papi` function requires KEGG compound codes (e.g., C00031). Use `addKeggCodes` to convert common names.

```r
# inputData: metabolites in 1st column, abundances in others
# keggCodes: data frame with KEGG codes in 1st col, names in 2nd col
papiData <- addKeggCodes(inputData = metabolomicsData, 
                         keggCodes = keggLibrary, 
                         save = FALSE, 
                         addCodes = TRUE)
```

### 3. Predicting Pathway Activity
The `papi` function calculates the Activity Scores. It can run online (accessing KEGG live) or offline (using a local database).

```r
# Calculate Activity Scores
# offline = TRUE is recommended for speed and reproducibility
results <- papi(papiData, save = FALSE, offline = TRUE, localDatabase = "default")
```

### 4. Statistical Analysis
Use `papiHtest` to identify significantly different pathways between conditions. It automatically chooses between t-test (2 groups) and ANOVA (>2 groups).

```r
# Filter for pathways with p-value < 0.05
statResults <- papiHtest(results, signif.level = 0.05, log.transform = FALSE, save = FALSE)
```

### 5. Visualization
`papiLine` generates a profile of pathway activities. Setting `relative = TRUE` is common practice to invert the y-axis (so higher points represent higher activity) and scale results to a reference condition.

```r
papiLine(results, 
         relative = TRUE, 
         setRef.cond = TRUE, 
         Ref.cond = "control", 
         save = FALSE)
```

## Key Functions

- `buildDatabase`: Downloads KEGG data to create a local database for offline use.
- `addKeggCodes`: Maps user metabolite names to KEGG identifiers.
- `papi`: The main engine for calculating pathway Activity Scores.
- `papiHtest`: Performs statistical significance testing on Activity Scores.
- `papiLine`: Creates line graphs of pathway activity profiles across conditions.

## Important Considerations

- **Inverse Relationship**: By default, a high Activity Score (AS) means low pathway activity. Use `relative = TRUE` in `papiLine` to flip this for intuitive visualization.
- **Missing Values**: Metabolites not found in KEGG or marked as 'absent' are ignored by the algorithm.
- **Database Versioning**: Because KEGG is updated frequently, use `buildDatabase` to lock a version for a specific study to ensure reproducibility.

## Reference documentation

- [PAPi](./references/PAPi.md)
- [PAPiPackage](./references/PAPiPackage.md)