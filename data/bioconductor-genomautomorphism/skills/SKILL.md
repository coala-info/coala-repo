---
name: bioconductor-genomautomorphism
description: This tool analyzes DNA mutational events and evolutionary processes using algebraic representations and automorphisms on finite Abelian groups. Use when user asks to compute automorphism coefficients between aligned DNA sequences, represent codons in algebraic groups like Z64 or Z5^3, identify conserved genomic regions, or classify mutations based on genetic-code cubes.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomAutomorphism.html
---

# bioconductor-genomautomorphism

name: bioconductor-genomautomorphism
description: Analyze DNA mutational events using algebraic representations (Abelian finite groups) and automorphisms. Use this skill to compute automorphism coefficients between aligned DNA sequences, represent codons in different algebraic groups (Z64, Z125, Z5^3), and classify mutations based on genetic-code cubes.

# bioconductor-genomautomorphism

## Overview
The `GenomAutomorphism` package provides tools for the algebraic analysis of DNA sequences. It represents multiple sequence alignments (MSA) as elements of finite Abelian groups (specifically prime-power order groups). By computing automorphisms between sequences, users can quantitatively describe mutational events and evolutionary processes. This approach is particularly useful for protein-coding regions, allowing for the differentiation of mutations at different codon positions and the identification of conserved genomic regions.

## Core Workflow

### 1. Data Preparation and Encoding
Load the library and prepare your sequence alignment (typically a `DNAMultipleAlignment` or `DNAStringSet`).

```r
library(Biostrings)
library(GenomAutomorphism)

# Load example data
data(covid_aln, package = "GenomAutomorphism")

# Convert DNA bases to integers based on a specific cube (e.g., "ACGT")
base2int("ACGT", group = "Z4", cube = "ACGT")
```

### 2. Codon Coordinate Representation
Represent codons as coordinates in specific Abelian groups (e.g., $Z_{64}$ for the 64 codons).

```r
codons <- codon_coord(
  codon = covid_aln,
  cube = "ACGT",
  group = "Z64",
  start = 1,
  end = 750
)
```

### 3. Computing Automorphisms
Calculate the automorphism coefficients ($k$) that map one sequence to another. This is the primary method for quantifying mutational changes.

```r
# Compute automorphisms in Z64
autm <- automorphisms(
  seqs = covid_aln,
  group = "Z64",
  cube = c("ACGT", "TGCA"),
  cube_alt = c("CATG", "GTAC"),
  verbose = FALSE
)

# For 3D representation in GF(5)
autm_3d <- automorphisms(seqs = covid_aln, group = "Z5^3")
```

### 4. Summarizing and Analyzing Results
Summarize the automorphisms by genomic ranges or by coefficients to identify mutation types.

```r
# Summarize by ranges
aut_range <- automorphismByRanges(autm)

# Group by coefficients to see mutation types
autby_coef <- automorphism_bycoef(autm)

# Calculate posterior probabilities of mutation types (Bayesian framework)
post_prob <- automorphism_prob(autby_coef)
```

### 5. Identifying Conserved Regions
Extract regions where the sequences are identical (automorphism coefficient = 1).

```r
conserved <- conserved_regions(autm)
unique_conserved <- conserved_regions(autm, output = "unique")
```

## Key Parameters and Groups
- **Groups**: 
  - `Z64`: Standard representation for 64 codons.
  - `Z125`: Alternative representation.
  - `Z5^3`: 3D vector space representation (Galois Field GF(5)).
- **Cubes**: Represent the 24 possible base orders (e.g., "ACGT", "TGCA"). Dual cubes (like ACGT and TGCA) are used to account for complementary strands.
- **Translations (Trnl)**: Regions that cannot be described by automorphisms (often indels) are labeled as translations.

## Tips for Success
- **Indels**: If a region returns "Trnl" in the cube column, it typically indicates an insertion or deletion event.
- **Strand Awareness**: Automorphisms found in the "TGCA" cube (the dual of "ACGT") represent mutational events affecting the negative strand.
- **Performance**: For whole-genome alignments, use the `verbose = FALSE` flag and consider using the pre-computed datasets provided in the package (e.g., `data(covid_autm)`) for testing.

## Reference documentation
- [Get started-with GenomAutomorphism](./references/GenomAutomorphism.md)
- [GenomAutomorphism Vignette](./references/GenomAutomorphism.Rmd)