---
name: bioconductor-crisprbowtie
description: This tool aligns CRISPR gRNA spacer sequences and short DNA sequences to a reference genome using the Bowtie aligner. Use when user asks to map gRNA spacers with PAM constraints, perform on-target and off-target searches for CRISPR nucleases, or align short sequences like siRNA seeds.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprBowtie.html
---

# bioconductor-crisprbowtie

name: bioconductor-crisprbowtie
description: Alignment of CRISPR gRNA spacer sequences and short DNA sequences to a reference genome using Bowtie. Use this skill to perform fast on-target and off-target searches for CRISPR nucleases, map gRNA spacers with PAM constraints, or align short sequences like siRNA seeds within the R/Bioconductor environment.

# bioconductor-crisprbowtie

## Overview

`crisprBowtie` is an R package that provides a platform-independent interface to the Bowtie aligner via the `Rbowtie` package. It is specifically optimized for the `crisprVerse` ecosystem to map CRISPR guide RNA (gRNA) spacer sequences to a reference genome while accounting for specific CRISPR nuclease requirements (like PAM sequences) and allowing for mismatches.

The package features two primary functions:
1. `runCrisprBowtie`: For CRISPR-specific alignments (requires a `CrisprNuclease` object).
2. `runBowtie`: For general short-read alignments (e.g., RNAi seeds) without PAM constraints.

## Workflow: Building a Bowtie Index

Before alignment, you must create a Bowtie index from a FASTA file. This only needs to be done once per genome.

```r
library(Rbowtie)
library(crisprBowtie)

# Path to your genome FASTA
fasta_path <- "path/to/genome.fa"
index_dir <- tempdir()

Rbowtie::bowtie_build(fasta_path,
                      outdir = index_dir,
                      prefix = "my_genome_index",
                      force = TRUE)

index_base <- file.path(index_dir, "my_genome_index")
```

## Workflow: CRISPR gRNA Alignment

Use `runCrisprBowtie` to find on-target and off-target sites for specific spacers.

```r
library(crisprBowtie)
library(crisprBase)

# 1. Load a nuclease object (e.g., SpCas9)
data(SpCas9, package="crisprBase")

# 2. Define spacers (20bp for SpCas9)
spacers <- c("TCCGCGGGCGACAATGGCAT", "TGATCCCGCGCTCCCCGATG")

# 3. Run alignment
# n_mismatches: max mismatches allowed (usually 0-3)
# canonical: if FALSE, includes non-canonical PAMs (e.g., NAG/NGA for SpCas9)
results <- runCrisprBowtie(spacers,
                           crisprNuclease = SpCas9,
                           n_mismatches = 3,
                           canonical = FALSE,
                           bowtie_index = index_base)

# Results return a data.frame with:
# spacer, protospacer, pam, chr, pam_site, strand, n_mismatches, canonical
```

## Workflow: General Sequence Alignment (RNAi/siRNA)

Use `runBowtie` for short sequences where PAM sequences are not relevant.

```r
seeds <- c("GTAAAGGT", "AAGGATTG")

# Align with up to 2 mismatches
seed_results <- runBowtie(seeds,
                          n_mismatches = 2,
                          bowtie_index = index_base)

# Returns a data.frame with query, target, chr, pos, strand, and n_mismatches
```

## Tips and Best Practices

- **Nuclease Compatibility**: Ensure the `CrisprNuclease` object matches the spacers you are using. You can check available nucleases using `crisprBase::getAvailableCrisprNucleases()`.
- **Index Path**: The `bowtie_index` argument requires the full path prefix (the directory plus the prefix used during `bowtie_build`).
- **Performance**: Bowtie is highly efficient for short sequences (spacers are typically 17-25bp). For very large-scale off-target searching, ensure your R session has sufficient memory to load the index.
- **Integration**: This package is often used as a backend for `crisprDesign`. If you are using `crisprDesign`, you will likely interact with this functionality via `addSpacerAlignments`.

## Reference documentation

- [Introduction to crisprBowtie](./references/crisprBowtie.Rmd)
- [crisprBowtie: alignment of gRNA spacer sequences using bowtie](./references/crisprBowtie.md)