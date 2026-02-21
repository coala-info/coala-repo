---
name: bioconductor-bandits
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BANDITS.html
---

# bioconductor-bandits

## Overview
BANDITS is a Bayesian hierarchical method for detecting Differential Transcript Usage (DTU). It employs a Dirichlet-multinomial model to account for over-dispersion between biological replicates and treats the allocation of reads to transcripts as a latent variable sampled via MCMC. This approach allows for both gene-level and transcript-level testing while incorporating mapping uncertainty.

## Core Workflow

### 1. Data Preparation
BANDITS requires three main components:
- **Gene-Transcript Matching**: A data frame with `gene_id` and `transcript_id`.
- **Transcript Counts**: Estimated counts (e.g., from `tximport`).
- **Equivalence Classes**: Files from Salmon (`--dumpEq`) or Kallisto (`bus`).

```r
library(BANDITS)
library(tximport)

# Load gene-transcript mapping
data("gene_tr_id", package = "BANDITS")

# Load transcript counts via tximport
txi = tximport(files = quant_files, type = "salmon", txOut = TRUE)
counts = txi$counts

# Compute median effective transcript lengths
eff_len = eff_len_compute(x_eff_len = txi$length)
```

### 2. Pre-filtering (Recommended)
Filtering lowly abundant transcripts improves sensitivity and reduces computational overhead.
```r
transcripts_to_keep = filter_transcripts(gene_to_transcript = gene_tr_id,
                                         transcript_counts = counts, 
                                         min_transcript_proportion = 0.01,
                                         min_transcript_counts = 10, 
                                         min_gene_counts = 20)
```

### 3. Creating the BANDITS Data Object
Import equivalence classes and create the S4 object.
```r
# For Salmon
input_data = create_data(salmon_or_kallisto = "salmon",
                         gene_to_transcript = gene_tr_id,
                         salmon_path_to_eq_classes = equiv_classes_files,
                         eff_len = eff_len, 
                         n_cores = parallel::detectCores(),
                         transcripts_to_keep = transcripts_to_keep)

# Filter genes with low total counts across all samples
input_data = filter_genes(input_data, min_counts_per_gene = 20)
```

### 4. Informative Prior for Precision
Estimating a prior for the Dirichlet-multinomial precision parameter ($\delta$) is highly recommended.
```r
set.seed(123)
precision = prior_precision(gene_to_transcript = gene_tr_id,
                            transcript_counts = counts, 
                            n_cores = 2,
                            transcripts_to_keep = transcripts_to_keep)
# precision$prior contains mean and SD of log-precision
```

### 5. Testing for DTU
Run the MCMC to infer posterior distributions and calculate p-values.
```r
samples_design = data.frame(sample_id = sample_names, group = c("A", "A", "B", "B"))

results = test_DTU(BANDITS_data = input_data,
                   precision = precision$prior,
                   samples_design = samples_design,
                   group_col_name = "group",
                   R = 10^4, burn_in = 2*10^3, 
                   n_cores = 2,
                   gene_to_transcript = gene_tr_id)
```

## Interpreting Results

### Accessing Tables
- `top_genes(results)`: Gene-level results. Includes `p.values_inverted` (conservative measure for dominant transcript changes) and `DTU_measure` (magnitude of change, 0 to 2).
- `top_transcripts(results)`: Transcript-level results. Includes `Max_Gene_Tr.Adj.p.val` (ensures transcript significance only if the gene is significant).
- `convergence(results)`: Check MCMC stationary status.

### Visualization
Plot estimated transcript proportions for a specific gene:
```r
plot_proportions(results, gene_id = "ENSG00000162585", CI = TRUE)
```

## Key Parameters for `test_DTU`
- `R`: MCMC iterations (minimum $10^4$).
- `burn_in`: Initial iterations to discard (minimum $2 \times 10^3$).
- `n_cores`: Parallelize across genes.
- `gene_to_transcript`: Required to correctly map results back to IDs.

## Reference documentation
- [BANDITS: Bayesian ANalysis of DIfferenTial Splicing](./references/BANDITS.md)
- [BANDITS Vignette Source](./references/BANDITS.Rmd)