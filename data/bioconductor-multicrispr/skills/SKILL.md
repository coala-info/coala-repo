---
name: bioconductor-multicrispr
description: The multicrispr package provides a comprehensive framework for designing and scoring CRISPR/Cas9 and Prime Editing gRNAs within the Bioconductor ecosystem. Use when user asks to define genomic targets, perform genome arithmetics, find spacers, calculate on-target efficiency scores, or analyze off-targets.
homepage: https://bioconductor.org/packages/release/bioc/html/multicrispr.html
---

# bioconductor-multicrispr

name: bioconductor-multicrispr
description: Expert guidance for using the multicrispr R package to design CRISPR/Cas9 and Prime Editing gRNAs. Use this skill when you need to define genomic targets, perform genome arithmetics (flanking/extending), find spacers, calculate on-target efficiency scores (Doench 2014/2016), and analyze off-targets using Bowtie or vcountPDict.

# bioconductor-multicrispr

## Overview
The `multicrispr` package is a comprehensive Bioconductor tool for gRNA design. It streamlines the workflow from defining genomic targets to finding spacers and scoring them for efficiency and specificity. It is particularly performant for large-scale designs (thousands of targets) and integrates seamlessly with `GRanges` objects.

## Core Workflow

### 1. Define Targets
Convert various inputs into `GRanges` objects.
```r
library(multicrispr)
library(magrittr)

# From BED file (0-based)
bedfile <- system.file('extdata/SRF.bed', package = 'multicrispr')
targets <- bed_to_granges(bedfile, genome = 'mm10')

# From Gene IDs (Entrez/Ensembl)
txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene::TxDb.Mmusculus.UCSC.mm10.knownGene
targets <- genes_to_granges(c("440"), txdb)

# From Coordinates (1-based)
targets <- char_to_granges(c(srf1 = 'chr13:119991554-119991569:+'), bsgenome)
```

### 2. Transform Targets (Genome Arithmetics)
Adjust target ranges to find spacers in specific regions (e.g., promoters or flanks).
```r
# Extend ranges
targets_ext <- extend(targets, start = -22, end = 22)

# Get upstream or downstream flanks
up <- up_flank(targets, -200, -1)
dn <- down_flank(targets, 1, 200)

# Double flanks (e.g., for deletion/insertion)
dbl <- double_flank(targets, -10, -1, 1, 20)
```

### 3. Find Spacers and Score
Find N20 spacers followed by NGG PAMs. This step includes off-target counting and on-target scoring.
```r
bsgenome <- BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10

# Standard CRISPR/Cas9
spacers <- find_spacers(
    targets_ext, 
    bsgenome, 
    mismatches = 0, 
    subtract_targets = TRUE
)

# Prime Editing (finds spacers, 3' extensions, and nicking spacers)
# 'edits' specifies the desired change relative to the (+) strand
pe_spacers <- find_primespacers(targets, bsgenome = bsgenome, edits = "T")
```

### 4. Process Results
Results are returned as `GRanges`. Use `gr2dt` to convert to a `data.table` for easy filtering.
```r
# Convert to data.table
spacer_dt <- gr2dt(spacers)

# Write to file
write_ranges(spacers, "my_guides.bed")
```

## Key Functions and Parameters
- `find_spacers()`: Main engine for standard CRISPR.
    - `complement`: Set to `FALSE` to target only the provided strand.
    - `mismatches`: Number of mismatches allowed for off-target analysis.
- `index_genome()`: Prepares Bowtie indexes for fast off-target searching.
- `plot_intervals()`: Visualizes targets and transformed ranges.
- `reticulate::use_condaenv('azienv')`: Required if using the Azimuth (Doench 2016) scoring method via Python.

## Tips for Success
- **Genome Indexing**: Always run `index_genome(bsgenome)` before `find_spacers` for significant speed gains in off-target analysis.
- **Coordinate Systems**: Remember that `bed_to_granges` handles 0-based BED files, while `char_to_granges` expects 1-based R-style coordinates.
- **Prime Editing**: When using `find_primespacers`, the `edits` argument must be defined with respect to the default (+) strand, regardless of the target's actual strand.

## Reference documentation
- [Crispr/Cas9 gRNA design](./references/crispr_grna_design.md)
- [Genome arithmetics](./references/genome_arithmetics.md)
- [Prime Editing](./references/prime_editing.md)