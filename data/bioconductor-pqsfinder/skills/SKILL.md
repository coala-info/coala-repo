---
name: bioconductor-pqsfinder
description: The pqsfinder package provides an efficient scoring-based algorithm for identifying potential intramolecular G-quadruplex patterns in DNA and RNA sequences. Use when user asks to detect G-quadruplexes, identify G4 motifs with bulges or mismatches, or export predicted quadruplex locations to GFF3 or FASTA formats.
homepage: https://bioconductor.org/packages/release/bioc/html/pqsfinder.html
---


# bioconductor-pqsfinder

## Overview

The `pqsfinder` package provides an efficient algorithm for identifying DNA and RNA sequence patterns likely to fold into intramolecular G-quadruplexes (G4). Unlike rigid motif-based searches, `pqsfinder` uses a scoring system that accounts for imperfect G-runs containing bulges or mismatches, making it highly sensitive for biological research. It is designed to be scalable and customizable, allowing users to modify scoring parameters or provide custom scoring functions for specialized G4 types.

## Core Workflow

### 1. Basic PQS Detection
The primary function is `pqsfinder()`, which requires a `DNAString` object.

```r
library(pqsfinder)
library(Biostrings)

# Define sequence
seq <- DNAString("TTTTGGGCGGGAGGAGTGGAGTTTTTAACCCCAAAAATTTGGGAGGGTGGGTGGGAGAA")

# Detect PQS with a minimum score threshold
pqs <- pqsfinder(seq, min_score = 20)

# View results
print(pqs)
```

### 2. Inspecting Results
Results are returned as a `PQSViews` object (extending `XStringViews`).

*   **Standard Accessors:** Use `start()`, `width()`, `score()`, and `strand()`.
*   **Detailed Metadata:** Use `elementMetadata(pqs)` to see G-tetrad count (`nt`), bulges (`nb`), mismatches (`nm`), and specific run/loop lengths (`rl1-3`, `ll1-3`).
*   **Density:** Use `density(pqs)` with the `deep = TRUE` argument in the search to get a vector of overlapping PQS counts per position.

### 3. Tuning Search Parameters
Adjust the algorithm to target specific G4 topologies:

| Parameter | Description | Default |
| :--- | :--- | :--- |
| `min_score` | Minimum score to report (52 is recommended for human G4 data) | 52 |
| `max_defects` | Max total bulges + mismatches (0-3) | 3 |
| `run_min_len` | Minimum length of G-runs | 2 |
| `loop_max_len` | Maximum length of loops | 30 |
| `overlapping` | If TRUE, reports all overlapping PQS instead of just the best | FALSE |

### 4. Exporting Data
`pqsfinder` integrates with the Bioconductor ecosystem for downstream analysis.

**Convert to GRanges (for GFF3 export):**
```r
library(rtracklayer)
gr <- as(pqs, "GRanges")
export(gr, "results.gff", version = "3")
```

**Convert to DNAStringSet (for FASTA export):**
```r
dss <- as(pqs, "DNAStringSet")
writeXStringSet(dss, file = "results.fa", format = "fasta")
```

## Advanced Customization

### Custom Scoring Functions
You can override the default scoring by providing a function to `custom_scoring_fn`. The function must accept 10 arguments: `subject`, `score`, `start`, `width`, `loop_1`, `run_2`, `loop_2`, `run_3`, `loop_3`, and `run_4`.

```r
# Example: Bonus for loops containing only Cytosine
c_loop_bonus <- function(subject, score, start, width, loop_1, run_2, loop_2, run_3, loop_3, run_4) {
  # Logic to check loop composition and modify score
  return(score + 20) 
}

pqs <- pqsfinder(seq, custom_scoring_fn = c_loop_bonus)
```

### Non-Standard Motifs
To detect fundamentally different structures (like interstrand G-quadruplexes), disable the default scoring system and provide a custom regular expression for runs:
```r
pqs <- pqsfinder(seq, 
                 use_default_scoring = FALSE, 
                 run_re = "G{3,6}|C{3,6}", 
                 custom_scoring_fn = my_custom_logic)
```

## Tips for Performance
*   **Large Genomes:** When processing whole chromosomes, use `BSgenome` objects and process sequences in chunks or specific regions of interest.
*   **Defect Constraints:** At least one G-run must be perfect (no defects). The algorithm allows at most one type of defect per run.
*   **Score Interpretation:** Higher scores indicate higher stability/probability of G4 formation.

## Reference documentation
- [pqsfinder: User Guide](./references/pqsfinder.md)