---
name: bioconductor-isobayes
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/IsoBayes.html
---

# bioconductor-isobayes

name: bioconductor-isobayes
description: Bayesian inference for single protein isoforms using MS data (PSM counts or intensities). Use this skill to estimate protein isoform presence/absence and abundance, integrate transcriptomics (TPM) data as informative priors, and identify discrepancies between protein and transcript relative abundances.

# bioconductor-isobayes

## Overview
IsoBayes is a Bayesian framework for protein isoform-level inference. It addresses two major challenges in mass spectrometry (MS) proteomics: peptide identification uncertainty (via Posterior Error Probabilities - PEP) and peptide-to-isoform mapping ambiguity (degenerate peptides). It provides posterior probabilities of isoform presence, absolute abundance estimates with credible intervals, and relative abundance (Pi) metrics.

## Core Workflow

### 1. Data Preparation
IsoBayes requires MS data (PSM counts or intensities) and optionally transcriptomics data (TPM).

```r
library(IsoBayes)

# Define paths to data
data_dir <- system.file("extdata", package = "IsoBayes")
path_psm <- paste0(data_dir, "/AllPeptides.psmtsv")
path_tpm <- paste0(data_dir, "/jurkat_isoform_kallisto.tsv") # Optional
```

### 2. Generating the SummarizedExperiment (SE)
Use `generate_SE` to structure input files based on the source (MetaMorpheus, OpenMS/Percolator, or custom).

*   **MetaMorpheus (PSM):**
    ```r
    SE <- generate_SE(path_to_peptides_psm = path_psm, 
                      abundance_type = "psm", 
                      input_type = "metamorpheus")
    ```
*   **MetaMorpheus (Intensities):**
    ```r
    SE <- generate_SE(path_to_peptides_psm = path_psm,
                      path_to_peptides_intensities = "path/to/AllQuantifiedPeptides.tsv",
                      abundance_type = "intensities",
                      input_type = "metamorpheus")
    ```
*   **Custom Data:** Provide a data.frame with columns `Y` (abundance), `EC` (Equivalent Classes, e.g., "iso1|iso2"), and optionally `PEP` and `sequence`.

### 3. Pre-processing and Inference
Load the SE and TPM data, then run the MCMC-based inference.

```r
# Pre-process
data_loaded <- input_data(SE, path_to_tpm = path_tpm)

# Run Inference
# Use n_cores for speed on large datasets
set.seed(123)
results <- inference(data_loaded, n_cores = 1, traceplot = TRUE)
```

### 4. Gene-Level Normalization
To analyze alternative splicing within genes, provide a mapping file (2 columns: Isoform, Gene).

```r
path_map <- paste0(data_dir, "/map_iso_gene.csv")
results_norm <- inference(data_loaded, map_iso_gene = path_map, traceplot = TRUE)
```

## Interpreting Results
The output is a list containing:
*   `isoform_results`: Main table with `Prob_present`, `Abundance`, `Pi` (relative abundance), and `Log2_FC` (protein vs. transcript).
*   `normalized_isoform_results`: Relative abundances normalized to sum to 1 within each gene.
*   `gene_abundance`: Aggregated absolute abundance at the gene level.

## Visualization and Diagnostics

### Relative Abundance Plots
Compare protein and transcript levels for a specific gene:
```r
plot_relative_abundances(results_norm, gene_id = "TUBB", normalize_gene = TRUE)
```

### Convergence Diagnostics
Check MCMC traceplots for specific isoforms:
```r
plot_traceplot(results_norm, "TUBB-205")
```

## Key Tips
*   **PEP vs FDR:** It is recommended to use PEP (Posterior Error Probability) with a relaxed FDR threshold (0.1) to allow the model to account for identification uncertainty rather than hard-filtering at FDR 0.01.
*   **TPM Matching:** Ensure isoform names in the TPM file match the protein isoform names in the MS data exactly.
*   **Intensities:** Using intensities generally provides a marginal performance boost over PSM counts.

## Reference documentation
- [IsoBayes](./references/IsoBayes.md)
- [IsoBayes Vignette Source](./references/IsoBayes.Rmd)