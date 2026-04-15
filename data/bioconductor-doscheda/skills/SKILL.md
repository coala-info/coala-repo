---
name: bioconductor-doscheda
description: This tool analyzes downstream chemo-proteomics data to identify protein-drug interactions. Use when user asks to process quantitative chemical proteomics data, perform peptide-to-protein summarization, normalize fold-changes, or fit dose-response models to estimate drug affinity.
homepage: https://bioconductor.org/packages/release/bioc/html/Doscheda.html
---

# bioconductor-doscheda

name: bioconductor-doscheda
description: Analysis of downstream chemo-proteomics data using the Doscheda pipeline. Use this skill to process quantitative chemical proteomics (e.g., TMT, iTRAQ) or MS-CETSA data, perform peptide-to-protein summarization, normalize fold-changes, and fit linear or sigmoidal dose-response models to identify protein-drug interactions.

## Overview
Doscheda (DownStream Chemo-Proteomics Analysis) is designed for the analysis of mass spectrometry-based proteomics data from drug-binding experiments. It utilizes a central S4 class, `ChemoProtSet`, to manage input data, experimental parameters, normalization, and model fitting. The package supports both peptide-level intensities and protein-level fold-changes, offering specialized workflows for noise reduction (peptide removal) and affinity estimation (RB50 calculation).

## Core Workflow

### 1. Initialize and Set Parameters
Create a `ChemoProtSet` object and define the experimental design.

```r
library(Doscheda)

# Define the columns containing the abundance/intensity data
channels <- c("Abundance_126", "Abundance_127", "Abundance_128", 
              "Abundance_129", "Abundance_130", "Abundance_131")

ex <- new('ChemoProtSet')
ex <- setParameters(x = ex, 
                    chansVal = 6, 
                    repsVal = 1, 
                    dataTypeStr = 'intensity', # 'intensity', 'FC', or 'LFC'
                    modelTypeStr = 'linear',    # 'linear' or 'sigmoid'
                    organismStr = 'H.sapiens',
                    PDBool = FALSE)
```

### 2. Import Data
Attach your data frame to the object. Ensure column names for accessions and sequences match your input.

```r
ex <- setData(x = ex, 
              dataFrame = my_data, 
              dataChannels = channels,
              accessionChannel = "Master.Protein.Accessions",
              sequenceChannel = 'Sequence',
              qualityChannel = "Qvality.PEP")
```

### 3. Pre-processing and Normalization
If using peptide intensities, you can perform peptide removal based on replicate correlation. Then, normalize the data.

```r
# Optional: Remove noisy peptides (requires 2+ replicates)
ex <- removePeptides(ex, removePeps = FALSE)

# Run normalization ('loess', 'median', or 'none')
ex <- runNormalisation(ex, normalise = "loess")
```

### 4. Model Fitting
Fit the specified model (Linear: $y = ax^2 + bx + c$; Sigmoidal: 4-parameter dose-response).

```r
ex <- fitModel(ex)

# Access results in the finalData slot
results <- ex@finalData
```

### 5. Visualization
Doscheda provides several plotting methods for the `ChemoProtSet` object:

- `plot(ex)`: Distribution of p-values (linear) or top 15 proteins (sigmoidal).
- `volcanoPlot(ex)`: Mean vs. SD colored by p-values for each coefficient.
- `boxplot(ex)` / `densityPlot(ex)`: Data distribution across channels.
- `pcaPlot(ex)`: Principal Component Analysis of channels.
- `corrPlot(ex)`: Pearson correlation matrix between channels.

## Automated Pipeline
For a quick analysis without manual step-by-step execution, use the wrapper function:

```r
ex <- runDoscheda(dataFrame = my_data, 
                  dataChannels = channels,
                  chansVal = 6, 
                  repsVal = 1,
                  dataTypeStr = 'intensity',
                  modelTypeStr = 'linear',
                  accessionChannel = "Master.Protein.Accessions",
                  sequenceChannel = 'Sequence',
                  qualityChannel = "Qvality.PEP")
```

## Tips for Success
- **Sigmoidal Requirements**: Sigmoidal models require at least 5 concentrations. If you have a "pull-down of pull-down" (depletion factor) column, set `incPDofPDBool = TRUE` to calculate corrected RB50 values.
- **Linear Model**: The quadratic fit is useful for identifying non-monotonic binding profiles (e.g., "hook effects" or peaks in middle concentrations).
- **Shiny App**: Use `doschedaApp()` to launch the interactive GUI for the pipeline.

## Reference documentation
- [Doscheda: A DownStream Chemo-Proteomics Analysis Pipeline](./references/Doscheda.md)