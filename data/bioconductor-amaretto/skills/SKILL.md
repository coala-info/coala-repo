---
name: bioconductor-amaretto
description: Bioconductor-amaretto integrates multi-omics data to identify cancer driver genes and co-expressed gene modules through regulatory modeling. Use when user asks to identify cancer drivers, perform regulatory network analysis, integrate multi-omics data, or cluster genes into functional modules based on genomic alterations.
homepage: https://bioconductor.org/packages/release/bioc/html/AMARETTO.html
---


# bioconductor-amaretto

name: bioconductor-amaretto
description: Use the AMARETTO R package to integrate multi-omics data (gene expression, copy number, and DNA methylation) to identify cancer driver genes and co-expressed gene modules. Use this skill when performing regulatory network analysis, identifying cancer drivers, or clustering genes into functional modules based on genomic and epigenomic alterations.

## Overview

AMARETTO is a computational algorithm that identifies cancer driver genes by integrating multi-omics data. It follows a two-step process:
1.  **Regulatory Modeling**: It models the effects of DNA copy number alterations (CNA) and DNA methylation on gene expression to identify potential drivers.
2.  **Module Construction**: It connects these drivers to clusters of co-expressed genes (modules) using a penalized regression approach (Elastic Net).

The package is particularly useful for TCGA data analysis but can be applied to any multi-omics cohort with at least 100 samples.

## Typical Workflow

### 1. Data Acquisition and Preprocessing
AMARETTO provides built-in functions to download and preprocess TCGA data.

```r
library(AMARETTO)

# Download TCGA data (e.g., Liver Hepatocellular Carcinoma - LIHC)
TargetDir <- tempfile()
CancerSite <- "LIHC"
DataSetDirectories <- AMARETTO_Download(CancerSite = CancerSite, TargetDirectory = TargetDir)

# Preprocess data (handles missing values, batch correction via ComBat, and GISTIC output)
# Note: MethylStates.rda or similar methylation data is required
ProcessedData <- AMARETTO_Preprocess(DataSetDirectories = DataSetDirectories)
```

### 2. Initializing AMARETTO
Initialization clusters the gene expression data and prepares the regulator data object.

```r
# NrModules: Number of modules to identify (recommend 100 for first run)
# VarPercentage: Top percentage of most varying genes to use (recommend 25%)
AMARETTOinit <- AMARETTO_Initialize(ProcessedData = ProcessedData,
                                    NrModules = 100, 
                                    VarPercentage = 25)
```

### 3. Running the Algorithm
The main execution step identifies the regulatory relationships.

```r
AMARETTOresults <- AMARETTO_Run(AMARETTOinit = AMARETTOinit)
```

### 4. Evaluation and Visualization
Evaluate the model performance using R-squared values and visualize specific modules.

```r
# Evaluate performance on the training set
AMARETTOtestReport <- AMARETTO_EvaluateTestSet(
  AMARETTOresults = AMARETTOresults,
  MA_Data_TestSet = AMARETTOinit$MA_matrix_Var,
  RegulatorData_TestSet = AMARETTOinit$RegulatorData
)

# Visualize a specific module (e.g., Module 1)
AMARETTO_VisualizeModule(AMARETTOinit = AMARETTOinit,
                         AMARETTOresults = AMARETTOresults,
                         ProcessedData = ProcessedData,
                         ModuleNr = 1)
```

### 5. Generating Reports
Create an HTML report including heatmaps and gene set enrichment analysis (GSEA).

```r
gmt_file <- system.file("templates/H.C2CP.genesets.gmt", package="AMARETTO")
AMARETTO_HTMLreport(AMARETTOinit = AMARETTOinit,
                    AMARETTOresults = AMARETTOresults,
                    ProcessedData = ProcessedData,
                    hyper_geo_test_bool = TRUE,
                    hyper_geo_reference = gmt_file,
                    MSIGDB = TRUE)
```

## Key Functions
- `AMARETTO_Download()`: Programmatic download of TCGA data via Firehose.
- `AMARETTO_Preprocess()`: Cleans expression and CNA data, performs batch correction.
- `AMARETTO_Initialize()`: Sets up the clustering and regulator matrices.
- `AMARETTO_Run()`: Executes the Elastic Net-based module network inference.
- `AMARETTO_EvaluateTestSet()`: Validates the model on training or independent test data.
- `AMARETTO_VisualizeModule()`: Generates heatmaps showing regulator and target gene expression.

## Tips for Success
- **Sample Size**: For robust results, use cohorts with at least 100 samples where expression, CNA, and methylation data are available for the same patients.
- **Custom Data**: If using non-TCGA data, ensure your matrices have genes as rows and patients as columns, and that data is centered and scaled to unit variance.
- **Regulators**: AMARETTO specifically looks for "drivers" (CNA or Methylation changes) that explain "targets" (Gene Expression). Ensure your regulator matrix is correctly formatted during initialization.

## Reference documentation
- [AMARETTO](./references/amaretto.md)