---
name: r-sigminer
description: The sigminer package provides a comprehensive toolset for mutational signature analysis across various genomic variation types. Use when user asks to extract de novo signatures, tally mutation components, estimate signature exposures, or visualize mutational profiles.
homepage: https://cran.r-project.org/web/packages/sigminer/index.html
---


# r-sigminer

## Overview
The `sigminer` package provides a comprehensive toolset for mutational signature analysis. It supports various mutation types including Single Substitution (SBS), Double Substitution (DBS), Indels (ID), and Copy Number (CN) variations. It facilitates the entire workflow from raw genomic data to signature extraction and visualization.

## Installation
```r
install.packages("sigminer")
# Or for the development version:
# remotes::install_github("ShixiangWang/sigminer", dependencies = TRUE)
```

## Core Workflow

### 1. Data Input and Tallying
Before extracting signatures, genomic data must be read and "tallied" into a component-by-sample matrix.

**For Copy Number (CN):**
```r
# Read segment data
cn <- read_copynumber(segTabs, 
                      seg_cols = c("chromosome", "start", "end", "segVal"),
                      genome_measure = "wg", complement = TRUE, add_loh = TRUE)

# Tally components (Method 'S' for Steele et al. or 'W' for Wang et al.)
tally_cn <- sig_tally(cn, method = "S")
```

**For SBS/Indels:**
Use `read_maf()` to load MAF files, then `sig_tally()`.

### 2. Signature Extraction
You can extract signatures *de novo* or using a Bayesian approach.

**Bayesian NMF (Recommended for stability):**
```r
# Survey different signature numbers
e1 <- bp_extract_signatures(mat, range = 2:10, n_bootstrap = 10, n_nmf_run = 20)
bp_show_survey2(e1)

# Get specific signature object
obj <- bp_get_sig_obj(e1, n_sig = 5)
```

**Automatic Extraction:**
```r
sig_denovo = sig_auto_extract(tally_cn$all_matrices$CN_48)
```

### 3. Signature Refitting (Exposure Estimation)
To calculate the contribution of known reference signatures (e.g., COSMIC) to your samples:
```r
# Refit to TCGA Copy Number signatures
act_refit = sig_fit(t(tally_cn$all_matrices$CN_48), sig_index = "ALL", sig_db = "CNS_TCGA")

# Filter low-contribution signatures
act_refit_filtered = act_refit[apply(act_refit, 1, sum) > 0.1, ]
```

### 4. Visualization
`sigminer` provides high-level plotting functions for profiles and exposures.

```r
# Plot signature profiles
show_sig_profile(obj, mode = "SBS", style = "cosmic")

# Plot signature exposure (activity)
show_sig_exposure(obj, rm_space = TRUE)
```

### 5. Similarity Analysis
Compare extracted signatures to reference databases:
```r
sim <- get_sig_similarity(obj, sig_db = "SBS")
# Access similarity matrix: sim$similarity
```

## Tips and Best Practices
- **Parallel Computing**: For large datasets or many bootstrap runs, `sigminer` uses the `future` package. Set `plan(multisession)` to speed up extraction.
- **Memory Management**: If you encounter `future` warnings, use:
  `options(future.rng.onMisuse = "ignore", future.globals.maxSize = Inf)`
- **Small Datasets**: For small cohorts, the refitting approach (`sig_fit`) is generally more robust than *de novo* extraction.

## Reference documentation
- [Analyze Copy Number Signatures with sigminer](./references/cnsignature.Rmd)
- [A Quick Start of sigminer Package](./references/sigminer.Rmd)