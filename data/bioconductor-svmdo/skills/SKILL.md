---
name: bioconductor-svmdo
description: This tool performs transcriptome-based supervised classification by integrating Disease Ontology enrichment with SVM modeling to identify discriminative gene sets and prognostic markers. Use when user asks to perform supervised classification of RNA-Seq data, identify tumor-discriminating gene sets, or conduct survival analysis for prognostic marker detection.
homepage: https://bioconductor.org/packages/release/bioc/html/SVMDO.html
---


# bioconductor-svmdo

name: bioconductor-svmdo
description: Expert guidance for the SVMDO Bioconductor package. Use this skill to perform transcriptome-based supervised classification using Disease Ontology (DO) enrichment and SVM models. It is specifically designed for identifying tumor/normal discriminating gene sets and individual prognostic markers from FPKM/RPKM normalized RNA-Seq data.

# bioconductor-svmdo

## Overview
SVMDO (Support Vector Machines with Disease Ontology) is a supervised classification framework that integrates Disease Ontology enrichment analysis with feature selection (Wilk’s lambda criterion) and SVM modeling. It is designed to filter high-dimensional RNA-Seq data to find biologically relevant, discriminative gene sets and perform survival analysis for prognostic marker detection.

## Installation
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SVMDO")
```

## Data Preparation
The package expects two primary data structures in `.txt` format:

### 1. Transcriptome Dataset
A matrix or data frame where rows are samples and columns include `id`, `tissue_type`, and gene expressions.
- **tissue_type**: Must contain labels "Normal" and "Tumour" (or "Tumor").
- **id**: Mandatory for survival analysis; optional otherwise.

### 2. Clinical Dataset
Required only for survival analysis.
- **id**: Must match the transcriptome dataset IDs.
- **days_to_death**: Survival time.
- **vital_status**: Patient status (e.g., "Alive", "Dead").

## Workflow and GUI Usage
The primary interface for SVMDO is a Shiny-based GUI.

### Launching the GUI
```R
library(SVMDO)
runGUI()
# Or without loading the library:
# SVMDO::runGUI()
```

### Analysis Steps in GUI
1. **Upload Expression Data**: Load your transcriptome `.txt` file.
2. **DEG Analysis**: Click to perform Differential Expression Gene analysis. Ensure `tissue_type` labels are correct ("Nor" and "Tum").
3. **Input Size**: Define the number (n) of upregulated and downregulated genes to filter (default is 50).
4. **DO Analysis**: Click to apply Disease Ontology-based gene filtration.
5. **Classification**: Click to run the feature selection (Wilk's lambda) and SVM classification.
6. **Survival Analysis**: Upload clinical data and click "Survival Analysis" to identify prognostic genes from the discriminative set.

### Results and Output
- **Gene Results**: View the final discriminative gene set in a table.
- **Survival Plots**: Generate and visualize Kaplan-Meier plots for individual genes.
- **Downloads**: Set an output directory and download the gene list (.txt) and survival plots (.png/pdf).

## Best Practices
- **Workspace Clearance**: Always click the **Clear Environment** button in the GUI after completing a task to remove global variables and prevent errors in subsequent runs.
- **Normalization**: Ensure input data is FPKM or RPKM normalized.
- **Test Data**: Use the built-in test datasets (TCGA-COAD or TCGA-LUSC) available in the GUI to familiarize yourself with the workflow before using custom data.

## Reference documentation
- [SVMDO-Tutorial](./references/SVMDO_guide.md)