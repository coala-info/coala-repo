---
name: miniprot-boundary-scorer
description: This tool scores and validates splice sites and coding boundaries in miniprot protein-to-genome alignments to improve annotation reliability. Use when user asks to score splice sites, validate coding boundaries in miniprot alignments, or filter exons and introns based on substitution matrices.
homepage: https://github.com/tomasbruna/miniprot-boundary-scorer
metadata:
  docker_image: "quay.io/biocontainers/miniprot-boundary-scorer:1.0.1--h9948957_0"
---

# miniprot-boundary-scorer

## Overview

The `miniprot-boundary-scorer` is a specialized post-processing tool designed to enhance the reliability of `miniprot` alignments. While `miniprot` is efficient at mapping proteins to genomic sequences, this tool adds a layer of validation by scoring splice sites and coding boundaries using amino acid substitution matrices and weighted kernels. It is particularly useful in genome annotation workflows where high-confidence intron and exon boundaries are required for downstream gene modeling.

## Usage Instructions

### Basic Execution
The tool reads from standard input (`stdin`), making it ideal for direct piping from `miniprot`. You must provide an amino acid scoring matrix (typically in CSV format).

```bash
miniprot [options] genome.fasta protein.fasta | miniprot_boundary_scorer -s blosum62.csv -o output_scored.txt
```

### Key Parameters and Tuning
*   **Scoring Matrix (`-s`)**: Required. Path to a CSV file containing the amino acid substitution scores (e.g., BLOSUM62).
*   **Window Width (`-w`)**: Controls the size of the scoring window around intron boundaries. The default is 10. Increase this if you expect alignment quality to be informative over a larger distance from the splice site.
*   **Weighting Kernels (`-k`)**: Determines how scores are weighted within the window.
    *   `triangular` (Default): Gives more weight to matches closer to the boundary.
    *   `box`: Uniform weighting across the window.
    *   `parabolic` / `triweight`: Alternative non-linear weighting schemes.
*   **Filtering Thresholds**:
    *   `-e`: Minimum exon score (default 25). Exons below this are discarded.
    *   `-x`: Minimum initial exon score (default 25).
    *   `-i`: Minimum initial intron score (default 0).

### Handling Frameshifts and Gaps
The tool provides specific penalties to account for biological or sequencing artifacts:
*   Use `-g` to set the penalty for gaps in exons or near boundaries (default 4).
*   Use `-f` for frameshifts specifically at exon boundaries (default 4).
*   Use `-F` for a heavier penalty against frameshifts or read-through stop codons within exons (default 20).

## Expert Tips
*   **Piping Efficiency**: Since `miniprot` can output large volumes of data, always pipe directly to `miniprot_boundary_scorer` to avoid creating massive intermediate files.
*   **Initial Exon Sensitivity**: Initial exons are often shorter and harder to score. If you are losing too many gene starts, consider lowering the `-x` and `-i` thresholds while keeping the general exon filter `-e` more stringent.
*   **Matrix Compatibility**: Ensure your scoring matrix CSV is formatted correctly; the tool expects a standard substitution matrix where row and column headers are amino acid characters.

## Reference documentation
- [Miniprot boundary scorer Overview](./references/anaconda_org_channels_bioconda_packages_miniprot-boundary-scorer_overview.md)
- [tomasbruna/miniprot-boundary-scorer GitHub Repository](./references/github_com_tomasbruna_miniprot-boundary-scorer.md)