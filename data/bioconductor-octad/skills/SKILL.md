---
name: bioconductor-octad
description: This tool performs virtual drug screening and cancer therapeutic discovery by identifying compounds that reverse disease gene expression signatures. Use when user asks to select cancer case and control samples, compute differential expression signatures, calculate drug reversal potency scores, or perform in silico validation using pharmacogenomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/octad.html
---


# bioconductor-octad

name: bioconductor-octad
description: Perform virtual drug screening and cancer therapeutic discovery using the OCTAD pipeline. Use this skill to select cancer case and control samples from a database of ~20,000 patient tissues, compute disease gene expression signatures, calculate drug reversal potency scores (sRGES), and perform in silico validation using pharmacogenomics data.

# bioconductor-octad

## Overview

The `octad` package provides a workspace for virtually screening compounds that target specific cancer patient groups. It leverages a massive database of patient tissue samples (TCGA, GTEx) and compound-induced expression profiles (LINCS). The core workflow involves identifying a disease signature and finding drugs that "reverse" that signature (shifting the expression profile from a disease state toward a healthy state).

## Workflow

### 1. Load Metadata and Select Samples

Start by loading the phenotype data frame (`phenoDF`) to identify case samples (e.g., specific cancer types or subtypes).

```r
library(octad)

# Load sample metadata from ExperimentHub
phenoDF = get_ExperimentHub_data("EH7274")

# Select case samples (e.g., Primary Hepatocellular Carcinoma)
HCC_primary = subset(phenoDF, cancer == 'liver hepatocellular carcinoma' & sample.type == 'primary')
case_id = HCC_primary$sample.id
```

### 2. Select Control Samples

Use `computeRefTissue` to find the most transcriptomically similar healthy tissues to serve as controls, or manually select adjacent normal tissues.

```r
# Automatically compute top 50 reference tissues based on correlation
control_id = computeRefTissue(case_id, output=FALSE, adjacent=TRUE, source="octad", control_size=50)

# Alternatively, select specific normal tissues manually
# control_id = subset(phenoDF, biopsy.site == 'LIVER' & sample.type == 'normal')$sample.id[1:50]
```

### 3. Differential Expression (DE)

Compute the disease signature. By default, `octad` uses a small dataset of 978 LINCS landmark genes. For the full transcriptome, use `source='octad.whole'`.

```r
# Compute DE using the Wilcoxon test (default is edgeR)
res = diffExp(case_id, control_id, source='octad.small', output=FALSE, DE_method='wilcox')

# Filter for significant genes
res_sig = subset(res, abs(log2FoldChange) > 1 & padj < 0.001)
```

### 4. Compute Drug Reversal Potency (sRGES)

The `runsRGES` function identifies drugs that potentially reverse the disease signature. A score (sRGES) < -0.2 is typically considered a good starting point for candidates.

```r
# Compute summarized Reverse Gene Expression Score
sRGES = runsRGES(res_sig, max_gene_size=100, permutations=1000, output=FALSE)
head(sRGES)
```

### 5. In Silico Validation

Validate predictions by correlating sRGES with drug sensitivity data (AUC/IC50) from the CTRPv2 database for specific cell lines.

```r
# Identify the best cell line for validation based on correlation to cases
cell_line_res = computeCellLine(case_id=case_id, source='octad.small')

# Evaluate top drug candidates against a specific cell line (e.g., HEPG2)
topLineEval(topline = 'HEPG2', mysRGES = sRGES)
```

### 6. Drug Enrichment Analysis

Identify drug classes (MeSH terms, targets, or chemical structures) significantly enriched among the top-scoring compounds.

```r
# Perform target enrichment using ChEMBL
octadDrugEnrichment(sRGES = sRGES, target_type='chembl_targets')
```

## Tips for Success

*   **Data Sources**: Use `source='octad.small'` for quick testing (978 genes) and `source='octad.whole'` for final analysis. The latter requires downloading the full `.h5` expression matrix (`EH7277`).
*   **Custom Data**: You can use external expression matrices by setting `source='side'` in `diffExp` and providing your matrix to the `expSet` argument. Ensure row names are Ensembl IDs.
*   **Visualization**: Use the precomputed t-SNE data (`EH7276`) to visualize how your selected cases and controls cluster relative to the rest of the OCTAD database.
*   **Output**: If setting `output=TRUE` in functions, always specify an `outputFolder` to avoid files being written to temporary directories.

## Reference documentation

- [OCTAD: Open Cancer TherApeutic Discovery](./references/octad.md)