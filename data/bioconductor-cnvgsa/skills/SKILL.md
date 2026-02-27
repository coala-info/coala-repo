---
name: bioconductor-cnvgsa
description: This package performs gene-set enrichment analysis for rare copy number variants using a logistic regression approach with global burden correction. Use when user asks to test for enrichment of rare CNVs in specific gene-sets, perform burden analysis with covariate adjustment, or identify novel CNV signals by filtering known risk loci.
homepage: https://bioconductor.org/packages/release/bioc/html/cnvGSA.html
---


# bioconductor-cnvgsa

## Overview

The `cnvGSA` package is designed for testing the enrichment of rare CNVs (typically <1% frequency) within specific gene-sets. Unlike "competitive" tests (like Fisher's Exact Test or GSEA), `cnvGSA` uses a "self-contained" logistic regression approach. It treats subjects as sampling units and implements critical global burden correction. This ensures that results are not driven by a few subjects with very large or numerous CNVs, which is common in disorders like autism or schizophrenia.

## Core Workflow

### 1. Data Preparation and Import

The package uses a central `CnvGSAInput` object. While you can build slots manually, the `cnvGSAIn()` function is the standard way to load data via a configuration file.

```r
library(cnvGSA)

# Initialize input object
cnvGSA.in <- CnvGSAInput()

# Load data using a config file (tab-delimited text file defining paths)
# See references/cnvGSAUsersGuide.md for config file structure
cnvGSA.in <- cnvGSAIn("path/to/configFile.txt", cnvGSA.in)
```

**Required Input Components:**
*   **CNV Data:** SID, Chr, BP1, BP2, TYPE, and geneID (delimited string of genes overlapped).
*   **Phenotype/Covariate Data:** SID, Condition (1 for case, 0 for control), and covariates (e.g., Sex, Batch).
*   **Gene Sets:** A list of gene-sets (usually loaded from an `.RData` file or GMT).
*   **Known Loci/Genes:** (Optional) Used to filter out subjects with CNVs in well-known disease regions to find "novel" signals.

### 2. Statistical Analysis

The primary function is `cnvGSAlogRegTest`. It fits two models:
*   **Model A:** Covariates + Global Burden (e.g., total CNV length or total genes overlapped).
*   **Model B:** Model A + Number of genes in the specific gene-set overlapped by CNVs.

The models are compared using a deviance chi-square test.

```r
cnvGSA.out <- CnvGSAOutput()
cnvGSA.out <- cnvGSAlogRegTest(cnvGSA.in, cnvGSA.out)
```

**Key Parameters (defined in config or params.ls):**
*   `corrections`: Methods for global burden (e.g., `uni_gc` for universe gene count, `tot_l` for total length, `cnvn_ml` for count/mean length).
*   `Kl`: Set to "ALL", "YES", or "NO" to include/exclude subjects with CNVs in known risk loci.
*   `cnvType`: Filter analysis to specific types (e.g., "1" for losses, "3" for gains).

### 3. Reviewing Results

Results are stored in the `res.ls` slot of the output object.

```r
# Access the results data frame
results_df <- res.ls(cnvGSA.out)[[1]]

# Key columns:
# GsID: Gene set ID
# Coeff_U: Regression coefficient (log odds) with universe correction
# Pvalue_U_dev: Deviance p-value with universe correction
# FDR_BH_U: Benjamini-Hochberg adjusted p-value
```

To see exactly which CNVs and genes contributed to a specific gene-set's signal:
```r
# Generate detailed tables
cnvGSA.out <- cnvGSAgsTables(cnvGSA.in, cnvGSA.out)
gs_tables <- gsTables.ls(cnvGSA.out)
# View table for the first gene set
head(gs_tables[[1]])
```

### 4. Visualization and Export

The package provides built-in plotting and export for Cytoscape's Enrichment Map.

```r
# Create significance and support plots
f.makeViz(cnvGSA.in, cnvGSA.out)

# Export files for Cytoscape Enrichment Map
f.enrFiles(cnvGSA.in, cnvGSA.out)
```

## Best Practices

*   **Rare Variants Only:** Ensure input data is filtered for rare CNVs (<1% frequency). Burden tests are inappropriate for common variants.
*   **Global Burden:** Always use at least one correction model (e.g., `uni_gc`). Uncorrected results in CNV studies are often confounded by global genomic instability.
*   **Gene ID Consistency:** Ensure the `geneID` column in your CNV file uses the same system (e.g., Entrez IDs) as your Gene Set file.
*   **Parallelization:** On Windows, if `cnvGSAlogRegTest` fails, set `parallel` to "NO" in the parameters, as R parallelization can be unstable on that OS.

## Reference documentation

- [cnvGSA Package Introduction](./references/cnvGSA-vignette.md)
- [cnvGSA: Gene-Set Analysis of (Rare) Copy Number Variants](./references/cnvGSAUsersGuide.md)