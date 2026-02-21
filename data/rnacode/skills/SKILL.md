---
name: rnacode
description: RNAcode is a specialized tool for identifying protein-coding genes within multiple sequence alignments.
homepage: https://github.com/ViennaRNA/RNAcode
---

# rnacode

## Overview
RNAcode is a specialized tool for identifying protein-coding genes within multiple sequence alignments. It operates by detecting evolutionary signatures such as synonymous/conservative mutations, reading frame conservation, and the absence of stop codons. This skill enables the identification of local regions with high coding potential and provides statistical significance (p-values) for these predictions. It is particularly useful for de novo gene annotation in non-model organisms or for validating predicted open reading frames (ORFs) across species.

## Input Requirements
*   **Format**: Supports Clustal W or MAF (Multiple Alignment Format).
*   **Sequence Count**: Requires a minimum of 3 sequences in the alignment.
*   **Reference Sequence**: The first sequence in the alignment is treated as the reference; all reported coordinates and frames are relative to this sequence.
*   **Characters**: Gaps must be represented by dashes (`-`). Unspecified bases (`N`) are treated neutrally.

## Common CLI Patterns

### Basic Analysis
Run a standard analysis on an alignment file and output detailed results to the console:
```bash
RNAcode alignment.aln
```

### High-Stringency Annotation
Generate a GTF file containing only the best non-overlapping hits with a p-value better than 0.01:
```bash
RNAcode --outfile results.gtf --gtf --best-region --cutoff 0.01 alignment.maf
```

### Visualizing Coding Potential
Create color-coded EPS plots for high-scoring segments to visualize the coding evidence:
```bash
RNAcode --eps --eps-dir plots_dir --eps-cutoff 0.05 alignment.aln
```

### Statistical Refinement
Increase the number of random samples to obtain more stable and precise p-values for marginal hits:
```bash
RNAcode --num-samples 1000 --stop-early alignment.aln
```

## Command Line Options Reference
*   `-o, --outfile <file>`: Specify output destination (default: stdout).
*   `-p, --cutoff <float>`: Filter results by p-value threshold (default: 1.0).
*   `-n, --num-samples <int>`: Number of random alignments for p-value calculation (default: 100).
*   `-s, --stop-early`: Stop sampling once it is clear the hit won't meet the p-value cutoff.
*   `-r, --best-region`: Suppress overlapping hits in different frames/strands; shows only the highest scorer.
*   `-b, --best-only`: Report only the single best hit for the entire alignment.
*   `-g, --gtf`: Output results in GTF format (useful for genome browsers).
*   `-t, --tabular`: Output results in a tab-delimited format.
*   `-e, --eps`: Generate vector graphic plots (EPS) for predicted segments.

## Expert Tips
*   **MAF for Coordinates**: Use MAF format if you need the output to reflect genomic coordinates. Clustal W input defaults the first nucleotide position to 1.
*   **Frame Interpretation**: Positive frames (e.g., +1) are relative to the reference sequence start. Negative frames indicate the prediction is on the reverse complement strand.
*   **Handling Overlaps**: Coding signals often bleed into alternative frames. Always use `--best-region` to filter out these artifacts and identify the most likely correct reading frame.
*   **Performance**: When running large-scale scans with high sample sizes (e.g., `-n 1000`), always use `--stop-early` to significantly reduce computation time for non-coding regions.

## Reference documentation
- [RNAcode GitHub Repository](./references/github_com_ViennaRNA_RNAcode.md)
- [RNAcode Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rnacode_overview.md)