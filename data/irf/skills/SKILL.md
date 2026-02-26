---
name: irf
description: Inverted Repeats Finder identifies DNA or RNA segments that are reversed and complemented relative to an adjacent sequence. Use when user asks to identify structural motifs, find small RNA hairpins, or detect mirror repeats in genomic sequences.
homepage: https://github.com/Benson-Genomics-Lab/IRF
---


# irf

## Overview
Inverted Repeats Finder (IRF) is a specialized tool for identifying segments of DNA or RNA that are reversed and complemented relative to an adjacent sequence, separated by a spacer (loop). This skill helps configure IRF's scoring parameters and alignment heuristics to target specific biological features, such as small RNA hairpins or massive chromosomal repeats. Use this skill when you need to perform structural motif discovery or establish background statistics for mirror repeats.

## CLI Usage and Parameters
The `irf` command requires nine positional arguments followed by optional flags.

### Basic Command Structure
```bash
irf <File> <Match> <Mismatch> <Delta> <PM> <PI> <Minscore> <Maxlength> <MaxLoop> [options]
```

### Positional Arguments
1.  **File**: Input sequence in FASTA format.
2.  **Match**: Matching weight (e.g., 2).
3.  **Mismatch**: Mismatching penalty (e.g., 3).
4.  **Delta**: Indel (gap) penalty (e.g., 5).
5.  **PM**: Match probability (whole number, e.g., 80 for 80%).
6.  **PI**: Indel probability (whole number, e.g., 10 for 10%).
7.  **Minscore**: Minimum alignment score to report (e.g., 20).
8.  **Maxlength**: Maximum stem length to report (minimum 10,000).
9.  **MaxLoop**: Maximum loop/spacer length (e.g., 1000000).

### Recommended Quick Start
For general-purpose discovery in a FASTA file:
```bash
irf yourfile.fa 2 3 5 80 10 20 100000 1000000 -d -ngs
```

## Expert Tips and Best Practices

### Handling RNA Sequences
*   **Enable G-U Base Pairing**: Use the `-gt` flag followed by a weight (e.g., `-gt 1`) to allow Wobble base pairing, which is critical for accurate RNA secondary structure prediction.
*   **Targeting Hairpins**: For small mRNA hairpins, significantly reduce the `MaxLoop` and `Maxlength` parameters to focus the search and reduce computational overhead.

### Output Management
*   **Terminal Output**: Always use the `-ngs` flag when running in automated environments or pipelines to ensure results are printed to stdout rather than just generated as HTML files.
*   **Suppress HTML**: Use the `-h` flag to prevent the generation of browser-based table files if you only require the raw data or text output.
*   **Data Files**: Use the `-d` flag to produce a `.dat` file, which is easier to parse for downstream bioinformatics scripts.

### Advanced Search Heuristics
*   **Mirror Repeats**: Use the `-mr` flag to find mirror repeats (inverted but not complemented). This is primarily used for statistical background modeling.
*   **Sensitivity vs. Speed**:
    *   **Faster**: Use `-la` (lookahead test) to speed up the search with a slight trade-off in interval precision.
    *   **More Sensitive**: Use `-a3` or `-a4` for more intensive alignment passes to produce longer or higher-quality alignments at the cost of speed.
*   **Redundancy**: By default, IRF removes redundant overlaps. Use `-r0` to see all detected repeats or `-r <value>` (60-100) to tune the redundancy threshold.

### Memory Considerations
*   The `Maxlength` parameter directly impacts memory consumption. While there is no hard upper limit, setting this excessively high on large genomes may lead to system memory exhaustion.

## Reference documentation
- [Inverted Repeats Finder (IRF) GitHub Repository](./references/github_com_Benson-Genomics-Lab_IRF.md)
- [IRF Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_irf_overview.md)