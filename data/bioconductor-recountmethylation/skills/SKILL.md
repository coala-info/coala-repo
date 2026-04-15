---
name: bioconductor-recountmethylation
description: This package provides access to standardized, large-scale DNA methylation datasets and tools for cross-study analysis. Use when user asks to download HDF5-backed methylation compilations, filter cross-reactive probes, perform ancestry prediction, or conduct power analysis for epigenome-wide association studies.
homepage: https://bioconductor.org/packages/release/bioc/html/recountmethylation.html
---

# bioconductor-recountmethylation

## Overview
The `recountmethylation` package provides access to massive, standardized DNA methylation (DNAm) datasets. It facilitates the retrieval of cross-study compilations and provides tools for downstream analysis, including quality control, normalization, and specialized workflows like ancestry prediction and power analysis. It primarily works with `SummarizedExperiment` and `DelayedArray` objects to handle data that exceeds memory limits.

## Core Workflows

### 1. Accessing and Loading Data
Data is typically stored in HDF5-backed `SummarizedExperiment` objects (H5SE).

```r
library(recountmethylation)
library(HDF5Array)

# Download a compilation (e.g., HM450K)
get_rmdl(dataset = "hm450k", target_dir = "data")

# Load H5SE data
gm <- loadHDF5SummarizedExperiment("data/remethdb-h5se_gm_0-0-1")
gr <- loadHDF5SummarizedExperiment("data/remethdb-h5se_gr_0-0-1")
```

### 2. Working with DNAm Data Types
The package uses several `minfi`-compatible classes:
- `RGChannelSet` (rg): Raw signal (Red/Green).
- `MethylSet` (gm): Methylated/Unmethylated signals.
- `GenomicRatioSet` (gr): Beta-values or M-values with genomic coordinates.

**Conversion Example:**
```r
# Convert MethylSet to GenomicMethylSet
gms <- mapToGenome(gm)

# Extract Beta-values (DelayedArray)
beta <- getBeta(gr)
```

### 3. Probe Filtering and Annotation
Use the manifest-based annotations for filtering cross-reactive probes or SNPs.

```r
# Get cross-reactive probes
cross_reactive <- get_crossreactive_cpgs()
gr_filtered <- gr[!rownames(gr) %in% cross_reactive, ]

# Filter by SNP Minor Allele Frequency (MAF)
gms_filtered <- dropLociWithSnps(gms, maf = 0.01)
```

### 4. Specialized Analyses

#### Population Ancestry (EPISTRUCTURE)
Requires the `GLINT` software and `basilisk` for environment management.
```r
# Load explanatory CpGs for ancestry
cgv <- get(load(system.file("extdata", "glint_files", "glint_epistructure_explanatory-cpgs.rda", package = "recountmethylation")))

# Run via basilisk (requires GLINT setup)
# See reference: recountmethylation_glint.md
```

#### Power Analysis (pwrEWAS)
Estimate sample size requirements for EWAS.
```r
# Prepare summary stats (mu and var)
dfpwr <- data.frame(mu = rowMeans(beta_matrix), var = rowVars(beta_matrix))

# Run power simulation
results <- pwrEWAS_itable(tissueType = dfpwr, delta = c(0.05, 0.1), sims = 20)
```

#### Nearest Neighbor Search
Use HNSW indexes for rapid sample lookup in large compilations.
```r
# Query an existing index
dfnn <- query_si(sample_idv = c("GSM12345"), 
                 si_fname = "index_name", 
                 lkval = c(1, 10))
```

## Tips for Large Datasets
- **DelayedArrays**: Most assays are `DelayedArray` objects. Use `as.matrix()` only on subsets to avoid memory crashes.
- **Block Processing**: When calculating statistics across the whole array, process data in blocks (e.g., 10,000 rows at a time).
- **H5SE Updates**: Use `quickResaveHDF5SummarizedExperiment()` to save metadata changes without rewriting the entire large assay file.

## Reference documentation
- [Practical uses for provided CpG probe annotations](./references/cpg_probe_annotations.md)
- [Working with DNAm data types](./references/exporting_saving_data.md)
- [Data Analyses Examples](./references/recountmethylation_data_analyses.md)
- [Determine population ancestry from DNAm arrays](./references/recountmethylation_glint.md)
- [Power analysis for DNAm arrays](./references/recountmethylation_pwrewas.md)
- [Nearest neighbors analysis for DNAm arrays](./references/recountmethylation_search_index.md)
- [recountmethylation User's Guide](./references/recountmethylation_users_guide.md)