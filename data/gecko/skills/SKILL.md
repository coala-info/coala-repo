---
name: gecko
description: GECKO is a high-performance tool designed for rapid pairwise sequence alignment and the identification of high-scoring segment pairs. Use when user asks to perform genome comparisons, execute the GECKO workflow, or convert binary fragment files into readable alignments.
homepage: https://github.com/otorreno/gecko
---


# gecko

## Overview
GECKO (GEnome Comparison with K-mers Out-of-core) is a high-performance tool designed for rapid pairwise sequence alignment. It identifies collections of High-scoring Segment Pairs (HSPs) by utilizing a modular architecture that balances sensitivity and speed. This skill provides the procedural knowledge required to execute the GECKO workflow, optimize parameters for different organism sizes, and process the resulting alignment data.

## Core Workflow
The primary execution method is via the `workflow.sh` script.

```bash
./gecko/bin/workflow.sh <query.fasta> <reference.fasta> <length> <similarity> <wordLength> 1
```

### Parameter Guidelines
*   **Query/Reference**: Must be in FASTA format. The reference reverse strand is automatically computed and matched.
*   **Length**: Minimum nucleotide length for an HSP.
    *   *Small organisms (e.g., E. coli)*: ~40 bp.
    *   *Large organisms (e.g., Human)*: 100+ bp.
*   **Similarity**: Threshold for filtering noise. Recommended values are between 50 and 60.
*   **Word Length (k-mer size)**: Determines seed sensitivity. **Must be a multiple of 4.**
    *   *Small organisms*: 12 or 16.
    *   *Large organisms*: 32.
    *   *Note*: Smaller seeds increase sensitivity but decrease performance.

## Extracting Alignments
GECKO produces binary `.frags` files in the `results/` directory. To convert these into human-readable text alignments, use the extraction script:

```bash
./gecko/bin/frags2align.sh results/query-reference.frags <query.fasta> <reference.fasta> <output_alignments.txt>
```

## Output Interpretation
The `results/query-reference.csv` file contains the following key columns for each detected HSP:
*   **xStart/xEnd**: Coordinates in the query sequence.
*   **yStart/yEnd**: Coordinates in the reference sequence.
*   **strand**: `f` (forward) or `r` (reverse). Note that for reverse strands, `yEnd` is smaller than `yStart`.
*   **score**: Raw alignment score (+4 for match, -4 for mismatch).
*   **%ident**: Number of identities divided by alignment length.
*   **SeqX/SeqY**: ID of the sequence within the FASTA file (0-indexed).

## Expert Tips and Best Practices
*   **Disk Space Management**: GECKO is extremely disk-intensive. A chromosome-level comparison (e.g., Human vs. Gorilla) can generate up to 600GB of temporary "hits" data.
*   **Cleanup**: Always monitor the `hits/` folder. It is recommended to delete the contents of this folder after a successful run to reclaim storage space.
*   **Performance Bottlenecks**: Because GECKO is I/O intensive, running multiple instances concurrently on the same filesystem can lead to significant performance degradation due to disk contention.
*   **Re-runs**: The `dictionaries/` folder stores pre-processed sequence data. If you run a comparison again using the same sequences, GECKO will utilize these files to speed up the process.

## Reference documentation
- [GECKO GitHub Repository](./references/github_com_otorreno_gecko.md)
- [Bioconda Gecko Overview](./references/anaconda_org_channels_bioconda_packages_gecko_overview.md)