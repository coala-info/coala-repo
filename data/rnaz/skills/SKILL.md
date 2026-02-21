---
name: rnaz
description: The `rnaz` skill provides a specialized workflow for detecting functional RNA structures within evolutionary conserved sequences.
homepage: https://www.tbi.univie.ac.at/~wash/RNAz/
---

# rnaz

## Overview
The `rnaz` skill provides a specialized workflow for detecting functional RNA structures within evolutionary conserved sequences. It calculates two primary metrics: a secondary structure conservation index (SCI) and a thermodynamic stability z-score. By combining these into a single probability value (P-value), it distinguishes between random genomic background and functional RNA elements. This tool is essential for genome-wide screens and characterizing novel ncRNA candidates.

## Core Usage Patterns

### Basic Prediction
To analyze a single multiple sequence alignment (typically in CLUSTAL or FASTA format):
```bash
RNAz alignment.aln
```

### Large-Scale Genomic Screens
For long alignments (e.g., whole-chromosome alignments), use the windowing helper script to process the data in overlapping slices:
```bash
rnazWindow.pl --window=120 --slide=40 input.aln | RNAz
```

### Filtering and Sorting Results
Process the raw output to extract high-confidence hits (e.g., P > 0.5 or P > 0.9):
```bash
RNAz results.out | rnazFilter.pl --p-value=0.9 | rnazOutputSort.pl
```

## Expert Tips and Best Practices

- **Alignment Quality**: `rnaz` performance is highly dependent on the quality of the input alignment. Use structural aligners if possible, though standard sequence aligners (like ClustalW or MAFFT) are often sufficient for high-identity sequences.
- **Sequence Identity**: The tool is optimized for alignments with mean pairwise identity between 60% and 100%. Results outside this range may be less reliable.
- **Dinucleotide Content**: When estimating false discovery rates, use `rnazRandomizeAln.pl` with the `--level=2` flag to preserve dinucleotide content, which accounts for the thermodynamic bias of CpG islands and other local compositions.
- **P-Value Interpretation**: 
    - `P > 0.5`: Standard threshold for "RNA-like" signals.
    - `P > 0.9`: High-confidence threshold for minimizing false positives in large-scale screens.
- **Structural Alignment Model**: If your input alignments are already structurally informed, ensure you are using version 2.0+ which includes models specifically trained for structural alignments.

## Helper Script Reference
- `rnazWindow.pl`: Slices alignments into manageable windows.
- `rnazCluster.pl`: Groups overlapping hits from a windowed screen into single loci.
- `rnazAnnotate.pl`: Cross-references hits with existing genome annotations (BED/GFF).
- `rnazMAF2BED.pl`: Converts Multiple Alignment Format (MAF) results to BED format for genome browser visualization.

## Reference documentation
- [RNAz Main Documentation](./references/www_tbi_univie_ac_at_software_RNAz.md)
- [Bioconda rnaz Overview](./references/anaconda_org_channels_bioconda_packages_rnaz_overview.md)