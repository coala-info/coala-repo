---
name: bioconductor-rtpca
description: This package implements Thermal Proximity Co-aggregation to analyze protein-protein interactions and complexes using mass spectrometry-based thermal proteome profiling data. Use when user asks to test for co-aggregation of protein complexes, perform differential interaction analysis between conditions, or visualize thermal denaturation profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/Rtpca.html
---


# bioconductor-rtpca

## Overview

The `Rtpca` package implements the Thermal Proximity Co-aggregation (TPCA) concept for mass spectrometry-based Thermal Proteome Profiling (TPP) datasets. It operates on the principle that interacting proteins or members of the same complex tend to have similar thermal denaturation profiles. The package provides tools to:
1.  Import and preprocess TPP data (often in conjunction with the `TPP` package).
2.  Test for co-aggregation of known protein-protein interactions (PPIs) or protein complexes.
3.  Perform differential TPCA to identify changes in protein interactions between conditions.
4.  Visualize results through ROC curves, volcano plots, and melting profile comparisons.

## Core Workflow

### 1. Data Preparation and Import
`Rtpca` can accept data as a list of matrices/data frames or `ExpressionSet` objects from the `TPP` package.

```r
library(Rtpca)
library(TPP)

# Example using TPP-style import
trData <- tpptrImport(configTable = my_config, data = my_data_frames)
```

### 2. Defining Annotations
You must provide annotations for the interactions or complexes you wish to test. The package includes built-in human datasets:
*   `data("string_ppi_df")`: PPIs from StringDB.
*   `data("ori_et_al_complexes_df")`: Curated protein complexes.

```r
# Filter for high-confidence interactions
data("string_ppi_df")
ppi_anno <- subset(string_ppi_df, combined_score >= 950)
```

### 3. Running TPCA (Single Condition)
Use `runTPCA` to evaluate how well the thermal profiles match the provided annotations.

```r
# Test for PPI co-aggregation
vehTPCA <- runTPCA(objList = trData, ppiAnno = ppi_anno)

# Test for complex co-aggregation
data("ori_et_al_complexes_df")
vehComplexTPCA <- runTPCA(objList = trData, 
                          complexAnno = ori_et_al_complexes_df, 
                          minCount = 2)
```

### 4. Differential TPCA (Two Conditions)
Use `runDiffTPCA` to find interactions that change significantly between a control and a treatment.

```r
diffTPCA <- runDiffTPCA(
    objList = trData[1:2],       # Control replicates
    contrastList = trData[3:4],   # Treatment replicates
    ctrlCondName = "Vehicle",
    contrastCondName = "Treatment",
    ppiAnno = ppi_anno
)

# Extract results
results <- diffTpcaResultTable(diffTPCA)
```

### 5. Visualization
*   **ROC Curves**: Evaluate the global signal for PPIs or complexes.
    ```r
    plotPPiRoc(vehTPCA, computeAUC = TRUE)
    plotComplexRoc(vehComplexTPCA, computeAUC = TRUE)
    ```
*   **Volcano Plots**: Visualize differential interaction changes.
    ```r
    plotDiffTpcaVolcano(diffTPCA)
    ```
*   **Profile Plots**: Inspect specific protein pairs to validate hits.
    ```r
    plotPPiProfiles(diffTPCA, pair = c("ProteinA", "ProteinB"))
    ```

## Tips for Success
*   **Filtering**: Always filter for high-confidence PPIs (e.g., StringDB score > 900) to reduce noise in the ROC analysis.
*   **Input Format**: If not using `TPP` objects, ensure your data frames have a column for protein/gene names and that the column names for temperatures are consistent across replicates.
*   **Validation**: Significant hits in differential TPCA should always be manually inspected using `plotPPiProfiles` to ensure the "co-aggregation" isn't driven by a single outlier or low-quality data point.

## Reference documentation
- [Introduction to Rtpca](./references/Rtpca.md)