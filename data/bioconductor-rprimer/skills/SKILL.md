---
name: bioconductor-rprimer
description: This tool designs degenerate primers and probes for sequence-variable targets using multiple DNA sequence alignments. Use when user asks to perform sequence conservation analysis, generate consensus profiles, design degenerate PCR oligos, and validate assays against target alignments.
homepage: https://bioconductor.org/packages/release/bioc/html/rprimer.html
---

# bioconductor-rprimer

name: bioconductor-rprimer
description: Design degenerate primers and probes for sequence-variable targets (e.g., RNA viruses) using multiple DNA sequence alignments. Use this skill when you need to perform sequence conservation analysis, generate consensus profiles, design PCR oligos (ambiguous or mixed/CODEHOP strategies), and validate assays against target alignments.

# bioconductor-rprimer

## Overview

The `rprimer` package is designed for the discovery and design of degenerate oligonucleotides from multiple sequence alignments (MSA). It is particularly useful for targeting highly variable pathogens like RNA viruses. The workflow transitions from an MSA to a consensus profile, then to individual oligos (primers/probes), and finally to paired PCR assays.

## Core Workflow

### 1. Data Import and Preparation
Load the package and import a FASTA alignment using `Biostrings`.

```r
library(rprimer)
library(Biostrings)

# Import alignment
fasta_path <- system.file("extdata", "example_alignment.txt", package = "rprimer")
my_alignment <- readDNAMultipleAlignment(fasta_path, format = "fasta")

# Optional: Mask regions to target specific genomic areas
# colmask(my_alignment, invert = TRUE) <- c(3000:4000)
```

### 2. Generate Consensus Profile
The `consensusProfile()` function calculates conservation metrics (identity, coverage) and IUPAC consensus characters.

```r
# ambiguityThreshold: 0 to 0.2 (0 captures all variation)
my_profile <- consensusProfile(my_alignment, ambiguityThreshold = 0.05)

# Visualize conservation
plotData(my_profile)
```

### 3. Design Oligos (Primers and Probes)
Use `designOligos()` to find candidates based on melting temperature (Tm), GC content, and degeneracy.

*   **Ambiguous Strategy (Default):** Degenerate bases allowed anywhere.
*   **Mixed Strategy (CODEHOP-like):** Degenerate 3' end, consensus 5' end. Best for high variability with low degeneracy.

```r
my_oligos <- designOligos(
  my_profile,
  designStrategyPrimer = "ambiguous", # or "mixed"
  tmPrimer = c(55, 65),
  probe = TRUE
)

# Visualize candidates
plotData(my_oligos)
```

### 4. Design Assays
Combine primers and probes into functional PCR assays using `designAssays()`.

```r
# length: desired amplicon size range
my_assays <- designAssays(my_oligos, length = c(65, 120))

# Filter for best scores (0 is best)
best_assays <- my_assays[my_assays$score == min(my_assays$score), ]
```

### 5. Validation and Export
Check how well the designed oligos match the original target sequences.

```r
# Check matches (perfect, 1-mismatch, etc.)
match_results <- checkMatch(best_assays[1:3, ], target = my_alignment)
plotData(match_results)

# Export to FASTA for external tools
oligo_set <- as(my_oligos[1:5, ], "DNAStringSet")
writeXStringSet(oligo_set, "my_primers.fasta")
```

## Key Functions and Tips

*   **`plotData()`**: A polymorphic visualization tool. It adapts its output based on whether you provide a profile, oligo set, assay set, or match result.
*   **Scoring**: The `score` column (0-9) integrates identity, coverage, and GC content. Always look for lower values.
*   **Mixed Strategy**: When using `designStrategyPrimer = "mixed"`, it is recommended to use longer primers (at least 25bp) to maintain Tm despite potential 5' mismatches.
*   **Troubleshooting**: If no oligos are found, try increasing the `ambiguityThreshold` in `consensusProfile()` or relaxing `tm` and `gc` constraints in `designOligos()`.
*   **Shiny UI**: For interactive exploration, use `runRprimerApp()`.

## Reference documentation

- [Getting started with rprimer](./references/getting-started-with-rprimer.md)
- [Getting started with rprimer (Rmd source)](./references/getting-started-with-rprimer.Rmd)