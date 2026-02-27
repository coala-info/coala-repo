---
name: bioconductor-musicatk
description: "bioconductor-musicatk performs comprehensive mutational signature analysis including variant extraction, signature discovery, and exposure prediction across multiple mutation modalities. Use when user asks to extract variants from VCF or MAF files, build mutation count tables, discover de novo signatures using NMF or LDA, predict exposures for known COSMIC signatures, or visualize signature profiles and exposure distributions."
homepage: https://bioconductor.org/packages/release/bioc/html/musicatk.html
---


# bioconductor-musicatk

name: bioconductor-musicatk
description: Mutational signature analysis using the musicatk R package. Use this skill to extract variants from VCF/MAF files, build mutation count tables (SBS, DBS, Indel), discover novel signatures using NMF or LDA, predict exposures for known signatures (e.g., COSMIC), and visualize results through signature profiles, exposure barplots, and UMAP embeddings.

## Overview
`musicatk` (Mutational Signature Comprehensive Analysis Toolkit) is a Bioconductor package designed for the end-to-end analysis of mutational signatures. It supports multiple mutation modalities including Single Base Substitutions (SBS), Double Base Substitutions (DBS), and Indels. The package provides a unified framework to move from raw variant files to signature discovery, exposure prediction, and downstream comparative visualization.

## Core Workflow

### 1. Setup and Data Import
The primary data structure is the `musica` object. You can create it from variant files or existing count matrices.

```r
library(musicatk)

# 1. Extract variants (from MAF, VCF, or data.frames)
variants <- extract_variants("path/to/variants.maf")

# 2. Select a genome (hg19, hg38, mm9, mm10 supported via BSgenome)
g <- select_genome("hg38")

# 3. Create the musica object
musica <- create_musica_from_variants(x = variants, genome = g)
```

### 2. Building Count Tables
Before analysis, variants must be summarized into motif counts. Standard schemas include SBS96, DBS78, and IND83.

```r
# Build standard SBS96 table
build_standard_table(musica, g = g, modality = "SBS96")

# Other modalities: "DBS78", "IND83", "SBS192_Trans" (Transcript Strand)
build_standard_table(musica, g = g, modality = "DBS78")

# Combine tables for multi-modal discovery
combine_count_tables(musica, to_comb = c("SBS96", "DBS78"), name = "sbs_dbs")
```

### 3. Signature Discovery (De Novo)
Use NMF or LDA to find novel signatures. It is recommended to test multiple values of $k$ (number of signatures).

```r
# Determine optimal k
k_comparison <- compare_k_vals(musica, modality = "SBS96", min_k = 2, max_k = 5, reps = 5)

# Discover signatures
discover_signatures(musica = musica, 
                    modality = "SBS96", 
                    num_signatures = 3, 
                    algorithm = "nmf", 
                    model_id = "my_model")
```

### 4. Exposure Prediction (Known Signatures)
Predict the contribution of established signatures (like COSMIC) in your samples.

```r
data("cosmic_v2_sigs")
predict_exposure(musica = musica, 
                 modality = "SBS96", 
                 signature_res = cosmic_v2_sigs, 
                 signatures_to_use = c(1, 4, 7), 
                 algorithm = "lda", 
                 model_id = "cosmic_pred")
```

### 5. Visualization and Annotation
`musicatk` provides extensive plotting functions, often with `plotly = TRUE` support for interactivity.

```r
# Plot signature profiles
plot_signatures(musica, model_id = "my_model")

# Add sample annotations for grouping
samp_annot(musica, "Condition") <- c("Control", "Tumor", ...)

# Plot exposures grouped by annotation
plot_exposures(musica, model_id = "my_model", plot_type = "bar", 
               group_by = "annotation", annotation = "Condition")

# UMAP visualization
create_umap(musica, model_id = "my_model")
plot_umap(musica, model_id = "my_model", color_by = "annotation", annotation = "Condition")
```

## Tips for Success
- **Reproducibility:** Many functions (discovery, UMAP, prediction) use stochastic algorithms. Always use `set.seed()` or `withr::with_seed()` before these calls.
- **Genome Matching:** Ensure the `BSgenome` object matches the reference used for variant calling. `select_genome` is a helper, but any `BSgenome` object can be passed.
- **Accessors:** Use `signatures(musica, ...)` and `exposures(musica, ...)` to extract the raw matrices from a result model.
- **Comparison:** Use `compare_cosmic_v2()` or `compare_cosmic_v3()` to see how your de novo signatures correlate with known biological processes.

## Reference documentation
- [Mutational Signature Comprehensive Analysis Toolkit](./references/musicatk.md)
- [Mutational Signature Comprehensive Analysis Toolkit (RMarkdown Source)](./references/musicatk.Rmd)