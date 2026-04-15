---
name: bioconductor-qplexanalyzer
description: This package provides a pipeline for the statistical analysis and differential expression of qPLEX-RIME and TMT/iTRAQ proteomics data. Use when user asks to perform quality control, normalize quantitative proteomics data, aggregate peptides to proteins, or identify differentially expressed proteins in multiplexed experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/qPLEXanalyzer.html
---

# bioconductor-qplexanalyzer

name: bioconductor-qplexanalyzer
description: Statistical analysis of qPLEX-RIME and TMT/iTRAQ proteomics data. Use this skill to perform quality control, normalization, peptide-to-protein aggregation, bait-protein regression, and differential expression analysis using the limma-based qPLEXanalyzer workflow.

# bioconductor-qplexanalyzer

## Overview

The `qPLEXanalyzer` package is designed for the analysis of qPLEX-RIME (Quantitative Proteomics of Immobilized Enzymes) data, which combines RIME with multiplex TMT chemical isobaric labeling. It is also applicable to standard TMT or iTRAQ total proteome datasets. The package provides a structured pipeline to transform raw peptide intensities into statistically significant protein-level insights, specifically addressing challenges like bait-protein dependency and non-specific binding in pull-down assays.

## Core Workflow

### 1. Data Import and Object Creation
The package uses the `MSnSet` class from the `MSnbase` package to store quantitative data and metadata.

```r
library(qPLEXanalyzer)

# Create MSnSet from intensity matrix and metadata
# indExpData: indices of columns containing quantitative data
# Sequences/Accessions: indices of columns for peptide sequences and protein IDs
MSnset_data <- convertToMSnset(exp_data$intensities,
                               metadata = exp_data$metadata,
                               indExpData = c(7:16),
                               Sequences = 2,
                               Accessions = 6)
```

### 2. Quality Control
Assess data quality and identify outliers using various visualization functions:

- `intensityPlot(MSnset_data)` / `intensityBoxplot(MSnset_data)`: Check intensity distributions across samples.
- `rliPlot(MSnset_data)`: Relative Log Intensity plot to visualize unwanted variation.
- `corrPlot(MSnset_data)`: Sample-to-sample correlation matrix.
- `pcaPlot(MSnset_data, labelColumn = "Group")`: Principal Component Analysis to identify batch effects or groupings.
- `coveragePlot(MSnset_data, ProteinID = "P12345", fastaFile = "path/to/fasta")`: Visualize bait protein sequence coverage.

### 3. Normalization
Choose a normalization method based on the experiment type:

- `normalizeScaling(MSnset_data, scalingFunction = median)`: Aligns central tendencies (recommended for most cases).
- `groupScaling(MSnset_data, groupingColumn = "SampleGroup")`: Normalizes within groups (essential for qPLEX-RIME to keep IgG controls separate from bait samples).
- `normalizeQuantiles(MSnset_data)`: Strongest normalization; use primarily for total proteome, not pull-downs.
- `rowScaling(MSnset_data)`: Scales each feature by its mean/median across samples.

### 4. Aggregation and Merging
Convert peptide-level data to protein-level data:

```r
# Summarize peptides to proteins
MSnset_P <- summarizeIntensities(MSnset_norm,
                                 summarizationFunction = sum,
                                 annotation = annotation_df)

# Visualize specific protein aggregation
peptideIntensityPlot(MSnset_data, combinedIntensities = MSnset_P, ProteinID = "P03372")
```

For PTM studies (Phospho/Acetyl), use `mergePeptides` or `mergeSites` to unify redundant sequences or modified sites.

### 5. Bait Regression Analysis
In qPLEX-RIME, captured proteins may depend on the amount of bait pulled down. `regressIntensity` removes this dependency by fitting a linear model and using the residuals.

```r
# Exclude IgG controls from regression
IgG_indices <- which(pData(MSnset_P)$SampleGroup == "IgG")
MSnset_reg <- regressIntensity(MSnset_P, controlInd = IgG_indices, ProteinId = "Bait_Accession")
```

### 6. Differential Expression Analysis
Uses `limma` to identify significantly enriched proteins.

```r
# Define contrasts
contrasts <- c(Condition_vs_Control = "Condition - Control")
diffstats <- computeDiffStats(MSnset_P, contrasts = contrasts)

# Extract results and filter against IgG background
# controlGroup: specifies the mock/IgG group for background filtering
results <- getContrastResults(diffstats, 
                              contrast = "Condition_vs_Control", 
                              controlGroup = "IgG")

# Visualization
maVolPlot(diffstats, contrast = "Condition_vs_Control", plotType = "Volcano")
```

## Tips for Success
- **Missing Values**: `qPLEXanalyzer` functions expect a complete matrix. Impute missing values using `MSnbase` methods or filter them out during `convertToMSnset`.
- **IgG Handling**: Always normalize IgG samples separately (using `groupScaling`) to avoid over-correcting low-intensity background signals.
- **Specific Interactors**: Use the `controlLogFoldChange` column in the results to filter for proteins that are significantly higher than the IgG control (e.g., log2FC > 1).

## Reference documentation
- [qPLEXanalyzer](./references/qPLEXanalyzer.md)