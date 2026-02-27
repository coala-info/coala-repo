---
name: bioconductor-qsutils
description: This tool analyzes viral quasispecies amplicon data from next-generation sequencing to assess genetic diversity. Use when user asks to load and preprocess haplotype sequences, perform error correction, calculate biodiversity indices, compute functional diversity, or simulate quasispecies populations.
homepage: https://bioconductor.org/packages/release/bioc/html/QSutils.html
---


# bioconductor-qsutils

name: bioconductor-qsutils
description: Analysis of viral quasispecies amplicon data from NGS. Use this skill to load haplotype sequences and frequencies, perform error correction (gaps/Ns, strand intersection), calculate biodiversity indices (Shannon, Gini-Simpson, Hill numbers), compute functional diversity (mutation frequency, nucleotide diversity), and simulate quasispecies populations.

## Overview
QSutils provides tools for managing and analyzing quasispecies data, typically represented as an alignment of haplotypes with associated frequencies. It is designed for viral quasispecies but is applicable to any amplicon-based genetic diversity study (e.g., metagenomics, tumor genetics).

## Core Workflows

### Data Loading and Preprocessing
The package expects FASTA files where headers contain haplotype IDs and frequencies separated by a vertical bar `|`.

```r
library(QSutils)

# Load data into a list containing counts (nr) and sequences (hseqs)
filepath <- "path/to/data.fna"
lst <- ReadAmplSeqs(filepath, type = "DNA")

# Load, filter by minimum percentage, and sort by mutations relative to dominant
lstG <- GetQSData(filepath, min.pct = 2, type = "DNA")

# Collapse raw reads into haplotypes
library(Biostrings)
reads <- readDNAStringSet("reads.fna")
lstCollapsed <- Collapse(reads)
```

### Error Correction
Correct technical artifacts like gaps or indeterminate bases ('N') and validate haplotypes using forward/reverse strand intersection.

```r
# Correct Gaps and Ns based on a reference (usually the dominant haplotype)
corrected_seqs <- CorrectGapsAndNs(lstCollapsed$hseqs[-1], lstCollapsed$hseqs[[1]])

# Intersect forward and reverse strands to filter low-frequency noise
lstI <- IntersectStrandHpls(fw_nr, fw_seqs, rv_nr, rv_seqs)
```

### Diversity Analysis
QSutils categorizes diversity into incidence-based, abundance-based, and functional indices.

*   **Incidence-based:** `SegSites(seqs)` (polymorphic sites), `TotalMutations(seqs)`.
*   **Abundance-based:** `Shannon(nr)`, `GiniSimpson(nr)`, `Hill(nr, q=1)`.
*   **Functional:** `MutationFreq(dst)` (by entity) or `MutationFreq(nm, nr, len)` (by molecule), `NucleotideDiversity(dst, nr)`.

### Visualization and Exploration
*   **Dotted Alignment:** Use `DottedAlignment(hseqs)` to see mutations relative to the dominant sequence (represented by dots).
*   **Mutation Tables:** `MutsTbl(hseqs, nr)` or `SummaryMuts(hseqs, nr)` provide frequency matrices of mutations per position.
*   **Information Profile:** `GetInfProfile(hseqs, nr)` calculates the information content (IC) per position.

### Simulation
Simulate quasispecies for benchmarking or testing.
*   **Abundance:** `fn.ab(n, fn="pcf")` or `geom.series(n, p)`.
*   **Genomes:** `GetRandomSeq(len)` to create a master sequence; `GenerateVars(master, n, max.muts)` to create variants.

## Tips
*   **Sample Size Bias:** Use `DSFT(nr, size)` (Down Sampling and Fringe Trimming) when comparing samples with different sequencing depths to avoid biased diversity estimates.
*   **Genotyping:** Use `DBrule` to classify unknown haplotypes against a set of reference genotype standards.
*   **Sorting:** Always use `SortByMutations` before visualization to ensure the dominant haplotype is the reference point.

## Reference documentation
- [Quasispecies Data Exploration and Manipulation](./references/QSUtils-Alignment.md)
- [Characterizing Viral Quasispecies Diversity](./references/QSutils-Diversity.md)
- [Simulating Quasispecies Composition](./references/QSutils-Simulation.md)