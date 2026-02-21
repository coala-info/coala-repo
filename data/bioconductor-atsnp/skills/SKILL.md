---
name: bioconductor-atsnp
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/atSNP.html
---

# bioconductor-atsnp

name: bioconductor-atsnp
description: Comprehensive analysis of SNP effects on transcription factor binding affinity. Use when Claude needs to: (1) Compute binding affinity scores for SNPs and motifs, (2) Calculate p-values for allele-specific binding and affinity changes, (3) Load motif libraries (ENCODE, JASPAR, or custom), (4) Process SNP data from tables, rsids, or fasta files, and (5) Visualize motif matches.

# bioconductor-atsnp

## Overview

The `atSNP` package (Affinity Test for regulatory SNP detection) provides a high-performance framework for identifying SNPs that disrupt transcription factor binding. It uses an importance sampling algorithm to compute p-values for allele-specific binding affinity and, crucially, the significance of the change in affinity between alleles.

## Core Workflow

### 1. Load Motif Libraries

Use built-in libraries or load custom PWMs.

```r
library(atSNP)

# Load built-in ENCODE or JASPAR libraries
data(encode_library) # encode_motif, encode_motifinfo
data(jaspar_library) # jaspar_motif, jaspar_motifinfo

# Load custom library from URL or file
pwms <- LoadMotifLibrary(
  urlname = "path/to/motifs.txt",
  tag = ">", 
  transpose = FALSE, 
  field = 1, 
  sep = c("\t", " "), 
  skipcols = 1, 
  skiprows = 1, 
  pseudocount = 0
)
```

### 2. Load SNP Data

`atSNP` requires SNP coordinates and alleles. It integrates with `BSgenome` for sequence extraction and `SNPlocs` for rsid lookups.

**From a table:**
The table must have columns: `chr`, `snp` (coordinate), `snpid`, `a1`, `a2`.

```r
snp_info <- LoadSNPData(
  "snp_file.txt", 
  genome.lib = "BSgenome.Hsapiens.UCSC.hg38", 
  half.window.size = 30, 
  mutation = FALSE, # FALSE matches alleles to reference; TRUE replaces ref with a1/a2
  default.par = TRUE # Use TRUE for < 1000 SNPs
)
```

**From rsids:**
```r
snp_info <- LoadSNPData(
  snpids = c("rs5050", "rs616488"), 
  genome.lib = "BSgenome.Hsapiens.UCSC.hg38", 
  snp.lib = "SNPlocs.Hsapiens.dbSNP144.GRCh38", 
  half.window.size = 30
)
```

### 3. Compute Affinity Scores

Calculate the log-likelihood of binding for both the reference and SNP alleles.

```r
atsnp.scores <- ComputeMotifScore(motif_library, snp_info, ncores = 1)
# Result contains $snp.tbl (sequences) and $motif.scores (affinity scores)
```

### 4. Compute P-values

Test the significance of the scores and the change between alleles.

```r
atsnp.result <- ComputePValues(
  motif.lib = motif_library, 
  snp.info = snp_info,
  motif.scores = atsnp.scores$motif.scores, 
  testing.mc = TRUE,
  ncores = 1
)
```

**Key Output Columns:**
- `pval_ref` / `pval_snp`: Significance of binding for each allele.
- `pval_rank`: Significance of the SNP effect on affinity change (recommended for identifying regulatory SNPs).
- `log_lik_ratio`: The difference in log-likelihood scores.

### 5. Visualization and Subsequence Analysis

Extract the specific sequences matching the motif and visualize the alignment.

```r
# Extract matching subsequences
match_res <- MatchSubsequence(
  snp.tbl = atsnp.scores$snp.tbl, 
  motif.scores = atsnp.result, 
  motif.lib = motif_library, 
  snpids = "rs53576"
)

# Plot motif match
match.seq <- dtMotifMatch(
  atsnp.scores$snp.tbl, 
  atsnp.scores$motif.scores, 
  snpids = "rs53576", 
  motifs = "SIX5_disc1", 
  motif.lib = motif_library
)
plotMotifMatch(match.seq, motif.lib = motif_library)
```

## Tips and Best Practices

- **Mutation Argument**: Set `mutation = TRUE` in `LoadSNPData` if working with general single nucleotide mutations where neither allele necessarily matches the reference genome.
- **Markov Model**: `default.par = TRUE` uses pre-fitted parameters from the GWAS catalog, which is more stable for small SNP sets.
- **Parallelization**: Use the `ncores` argument in `ComputeMotifScore` and `ComputePValues` to speed up analysis for large datasets.
- **Multiple Testing**: `atSNP` does not adjust p-values automatically. Use `p.adjust(atsnp.result$pval_rank, method = "BH")` or the `qvalue` package for FDR control.

## Reference documentation

- [atSNP Vignette](./references/atsnp-vignette.md)