---
name: bioconductor-msa2dist
description: The bioconductor-msa2dist package calculates pairwise distances and synonymous/nonsynonymous substitution rates for DNA and amino acid sequences. Use when user asks to calculate pairwise sequence distances, perform Ka/Ks codon analysis, translate DNA sequences with frame awareness, or convert sequence formats between Biostrings, ape, and seqinr.
homepage: https://bioconductor.org/packages/release/bioc/html/MSA2dist.html
---

# bioconductor-msa2dist

## Overview
The `MSA2dist` package is designed for calculating pairwise distances between sequences in a `Biostrings` object (DNAStringSet or AAStringSet). It is particularly powerful for evolutionary biology workflows, offering multi-threaded calculations for IUPAC nucleotide distances, Grantham's amino acid distances, and comprehensive codon-based analysis. It supports a wide array of Ka/Ks calculation models (including those from KaKs_Calculator 2.0) and provides utilities for frame-aware translation and sequence format conversion between common R bioinformatics packages.

## Sequence Format Conversion
`MSA2dist` provides seamless conversion between `Biostrings`, `ape`, and `seqinr` formats.

```r
library(MSA2dist)

# DNAStringSet to/from DNAbin (ape)
dna_bin <- dnastring2dnabin(dna_string_set)
dna_ss <- dnabin2dnastring(dna_bin)

# DNAStringSet to/from alignment (seqinr)
aln <- dnastring2aln(dna_string_set)
dna_ss <- aln2dnastring(aln)

# AAStringSet to/from AAbin (ape)
aa_bin <- aastring2aabin(aa_string_set)
aa_ss <- aabin2aastring(aa_bin)
```

## Frame-Aware Translation
Use `cds2aa()` to translate DNA to Amino Acids while handling specific reading frames and ensuring lengths are multiples of three.

```r
# Translate starting at frame 2, shortening to maintain codon triplets
aa_seqs <- cds2aa(dna_ss, frame = 2, shorten = TRUE)

# Use specific genetic codes (e.g., Mitochondrial)
aa_mito <- cds2aa(dna_ss, genetic.code = Biostrings::getGeneticCode("2"))
```

## Pairwise Distance Calculation
Calculate distance matrices for phylogenetic analysis.

### Amino Acid Distances
Use `aastring2dist()` with a scoring matrix. Grantham's distance is a common choice for evolutionary divergence.
```r
# Using Grantham's distance
aa_dist <- aastring2dist(aa_ss, score = granthamMatrix())

# Access the distance matrix
dist_matrix <- as.dist(aa_dist$distSTRING)

# Plot a tree using ape
plot(ape::bionj(dist_matrix))
```

### DNA Distances
Use `dnastring2dist()` for nucleotide models or IUPAC ambiguity codes.
```r
# K80 model
dna_dist_k80 <- dnastring2dist(dna_ss, model = "K80")

# IUPAC literal distance (useful for phased diploid sequences)
dna_dist_iupac <- dnastring2dist(dna_ss, model = "IUPAC", threads = 4)
```

## Codon Analysis (Ka/Ks)
Calculate synonymous (Ks) and nonsynonymous (Ka) substitutions.

### Standard Models
```r
# Li (1993) model
kaks_li <- dnastring2kaks(dna_ss, model = "Li")

# Nei and Gojobori (1986) model
kaks_ng <- dnastring2kaks(dna_ss, model = "NG86")
```

### Advanced Models (KaKs_Calculator 2.0)
Supports models like MYN, YN, GY, and more.
```r
# Modified Yang-Nielsen (MYN) model
kaks_myn <- dnastring2kaks(dna_ss, model = "MYN")

# Calculate for specific pairs using indices
idx <- list(c(1, 2), c(3, 4))
kaks_subset <- indices2kaks(dna_ss, idx, model = "MYN")
```

## Codon-Level Visualization
Analyze the average behavior (Synonymous vs Nonsynonymous vs Indels) across the alignment.

```r
# Create codon matrix and calculate xy coordinates
codon_mat <- dnastring2codonmat(dna_ss)
hiv_xy <- codonmat2xy(codon_mat)

# Resulting dataframe contains SynMean, NonSynMean, and IndelMean per codon position
# Suitable for plotting with ggplot2 to identify selection hotspots
```

## Tips
- **Pre-alignment**: Sequences must be pre-aligned (MSA) before using distance or Ka/Ks functions.
- **Parallelization**: Most distance and Ka/Ks functions support a `threads` argument to speed up calculations on multi-core systems.
- **Gap Handling**: Be aware that different models handle gaps (indels) differently; `dnastring2codonmat` is useful for inspecting how gaps are distributed across codons.

## Reference documentation
- [MSA2dist](./references/MSA2dist.md)