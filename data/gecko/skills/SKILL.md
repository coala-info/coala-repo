---
name: gecko
description: GECKO identifies high-scoring segment pairs in pairwise genome comparisons using a disk-based approach for large-scale sequences. Use when user asks to compare genomes, find sequence similarities, or generate alignments between large chromosomal sequences.
homepage: https://github.com/otorreno/gecko
metadata:
  docker_image: "quay.io/biocontainers/gecko:1.2--h7b50bb2_6"
---

# gecko

## Overview
GECKO (GEnome Comparison with K-mers Out-of-core) is a specialized tool for identifying High-scoring Segment Pairs (HSPs) in pairwise genome comparisons. Unlike memory-bound aligners, GECKO employs disk-based storage for intermediate hits, allowing it to process chromosome-scale sequences efficiently. It produces both human-readable CSV metadata and binary fragment files that can be converted into full alignments.

## Command Line Usage

### Running the Comparison Workflow
The primary entry point is the `workflow.sh` script. It requires five positional parameters plus a trailing "1" for internal processing.

```bash
./gecko/bin/workflow.sh <query.fasta> <reference.fasta> <length> <similarity> <wordLength> 1
```

### Parameter Tuning
*   **Length**: The minimum nucleotide length for an HSP to be kept.
    *   *Small organisms (Bacteria/E. Coli)*: Use ~40.
    *   *Large organisms (Human chromosomes)*: Use 100+.
*   **Similarity**: The score threshold (0-100). Use values above **50-60** to filter out background noise.
*   **Word Length**: The seed size for finding initial matches. **Must be a multiple of 4.**
    *   *Higher Sensitivity*: Use 12 or 16 (best for bacteria).
    *   *Higher Performance*: Use 32 (best for large chromosomes).

### Extracting Alignments
GECKO saves results in a binary `.frags` format. To generate a human-readable alignment text file, use the `frags2align.sh` utility:

```bash
./gecko/bin/frags2align.sh results/query-reference.frags <query.fasta> <reference.fasta> output_alignments.txt
```

## Output Management
GECKO generates a specific folder structure in the execution directory:
*   **results/**: Contains `query-reference.csv` (metadata) and `query-reference.frags` (binary data).
*   **intermediateFiles/hits/**: Stores seed matches. **Warning**: This folder can grow extremely large (e.g., 600GB for human-gorilla comparisons). Delete this folder after the workflow completes to reclaim disk space.
*   **intermediateFiles/dictionaries/**: Stores sequence indexes. These are reused if the same sequences are compared again, speeding up subsequent runs.

## Interpreting Results (CSV)
The output CSV contains the following key columns for each HSP:
*   **xStart/xEnd**: Coordinates in the query sequence.
*   **yStart/yEnd**: Coordinates in the reference sequence.
*   **strand**: `f` for forward, `r` for reverse. (Note: In `r` strands, `yEnd` is smaller than `yStart`).
*   **%ident**: Percentage of identical matches over the alignment length.
*   **SeqX/SeqY**: Numerical IDs for sequences if the input FASTA contained multiple entries (0 is the first sequence).

## Expert Tips
*   **Disk I/O**: GECKO is disk-intensive. If running on a cluster or shared filesystem, limit the input file size to prevent starving other processes of I/O bandwidth.
*   **Memory vs. Speed**: If a comparison is taking too long, increase the `wordLength` (e.g., from 16 to 32). If you are missing conserved regions, decrease it.
*   **Visualization**: The `.csv` output is compatible with GECKO-MGV (Multiple Genome Visualizer) for interactive analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| ./gecko/bin/workflow.sh | GECKO workflow for sequence comparison. |
| gecko_frags2align.sh | Converts fragment files to alignment files. |

## Reference documentation
- [GECKO Main Documentation](./references/github_com_otorreno_gecko_blob_master_README.md)
- [Repository Overview](./references/github_com_otorreno_gecko.md)