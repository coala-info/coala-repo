---
name: ncrf
description: Noise Cancelling Repeat Finder identifies tandem repeats within high-error long-read sequencing data by aligning reads to specific motifs. Use when user asks to locate tandem repeats in noisy reads, align sequences to repeat motifs, or filter genomic data for specific repeat patterns.
homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
metadata:
  docker_image: "quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6"
---

# ncrf

## Overview

Noise Cancelling Repeat Finder (NCRF) is a specialized alignment tool designed to identify tandem repeats within high-error sequencing data. Unlike general-purpose aligners, NCRF is optimized for the specific error profiles (noise) characteristic of long-read technologies. It allows users to align segments of DNA sequences to repeated copies of known motifs (e.g., "GGCAT"). Use this skill when you need to locate, quantify, or filter specific repeat motifs in genomic reads where traditional methods might fail due to high indel or substitution rates.

## Core Usage Patterns

### Basic Search
The primary command reads FASTA data from standard input and requires at least one motif.
```bash
cat reads.fa | NCRF GGCAT > results.ncrf
```

### Searching Multiple Motifs
You can search for multiple motifs simultaneously by listing them or providing names.
```bash
cat reads.fa | NCRF GGCAT CCAT TTAGGG > results.ncrf
# With names
cat reads.fa | NCRF telomere:TTAGGG centromere:GGCAT > results.ncrf
```

### Technology-Specific Scoring
NCRF includes optimized scoring matrices for major long-read platforms.
*   **PacBio**: `--scoring=pacbio` (M=10, MM=35, IO=33, IX=21, DO=6, DX=28)
*   **Nanopore**: `--scoring=nanopore` (M=10, MM=63, IO=51, IX=98, DO=27, DX=34)

## Filtering and Thresholds

To reduce false positives and manage output size, apply length and noise filters:

*   **Match Ratio**: Use `--minmratio` (e.g., `0.85` or `85%`) to discard alignments with low match frequency.
*   **Noise Level**: Use `--maxnoise` as an alternative to match ratio (MaxNoise = 1 - MinMRatio).
*   **Minimum Length**: Use `--minlength` to set the minimum repeat length in base pairs (default is 500bp).
*   **Minimum Score**: Use `--minscore` to filter by the alignment score.

Example of a strict filter for Nanopore data:
```bash
cat reads.fa | NCRF GGCAT --scoring=nanopore --minmratio=0.80 --minlength=1000 > filtered.ncrf
```

## Post-Processing Workflow

NCRF output is often processed through a pipeline of helper scripts:

1.  **Concatenation**: Use `ncrf_cat.py` instead of standard `cat` to merge results while maintaining proper end-of-file markers.
    ```bash
    ncrf_cat.py run1.ncrf run2.ncrf > combined.ncrf
    ```
2.  **Consensus Filtering**: Use `ncrf_consensus_filter.py` to discard alignments where the consensus sequence does not match the intended motif.
    ```bash
    cat results.ncrf | ncrf_consensus_filter.py > validated.ncrf
    ```
3.  **Summary Statistics**: Generate a summary of the findings.
    ```bash
    cat results.ncrf | ncrf_summary.py
    ```

## Expert Tips

*   **Positional Events**: Use the `--positionalevents` flag to see match/mismatch/indel counts for each position within the motif. This is highly effective for distinguishing truly perfect repeats from those containing systematic biological variations.
*   **Memory Constraints**: NCRF is optimized for sequences up to ~500kbp and motifs up to ~200bp. Performance may degrade significantly if these limits are exceeded.
*   **Scoring Overflow**: If manually adjusting scores with `--match` or `--mismatch`, ensure the match reward (M) does not exceed 100. Alignments longer than $2^{31}/M$ may cause numerical overflow.
*   **Symbolic Links**: After installation, run `./make_symbolic_links.sh` in the NCRF directory to use the Python helper scripts without the `.py` extension.



## Subcommands

| Command | Description |
|---------|-------------|
| NCRF | Noise Cancelling Repeat Finder, to find tandem repeats in noisy reads |
| ncrf_ncrf_cat.py | Concatenate several output files from Noise Cancelling Repeat Finder. This is little more than copying the files and adding a blank line between the files. |
| ncrf_resolve_overlaps | Resolves overlaps in alignment summaries. |
| ncrf_to_bed | Converts NCRF output to BED format. |

## Reference documentation
- [Noise Cancelling Repeat Finder README](./references/github_com_makovalab-psu_NoiseCancellingRepeatFinder_blob_master_README.md)