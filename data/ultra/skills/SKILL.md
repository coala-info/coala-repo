---
name: ultra
description: ULTRA is a specialized bioinformatics tool designed to locate and annotate tandemly repetitive regions in genomic data. Use when user asks to locate and annotate tandem repeats, perform repeat discovery, identify simple sequence repeats or large tandem repeats, generate masked FASTA files, analyze sub-repeat structures, or get detailed statistics and sequences.
homepage: https://github.com/TravisWheelerLab/ULTRA
metadata:
  docker_image: "quay.io/biocontainers/ultra:1.2.1--h9948957_0"
---

# ultra

## Overview

ULTRA is a specialized bioinformatics tool designed to locate and annotate tandemly repetitive regions in genomic data. It is highly effective for identifying both short simple sequence repeats (SSRs) and larger tandem repeats. Use this skill to perform repeat discovery, generate masked FASTA files for downstream alignment or assembly, and analyze sub-repeat structures within complex repetitive regions.

## Basic Usage

The primary command for ULTRA takes a FASTA file as input and outputs results to stdout by default.

```bash
# Basic annotation (outputs TSV to stdout)
ultra input.fa

# Save results to a specific file
ultra -o output.tsv input.fa
```

## Common CLI Patterns

### Repeat Masking
ULTRA can generate a masked version of your input genome. By default, it uses soft-masking (lower-case).

*   **Soft-masking**: `ultra --mask masked.fa -o output.tsv input.fa`
*   **Hard-masking (N-masking)**: `ultra --mask masked.fa --nmask -o output.tsv input.fa`

### Handling Large Repeats
The default maximum detectable period is 100. For larger repeats (e.g., centromeric satellites), you must adjust the period limit.

*   **Detect large periods**: `ultra -p 1000 input.fa`
*   **Clean output for large periods**: Use `--max_consensus` to prevent massive consensus strings from bloating your TSV.
    `ultra -p 1000 --max_consensus 10 input.fa`

### Detailed Statistics and Sequences
To get more than just the coordinates and consensus:

*   **Include full sequence**: `ultra --show_seq input.fa`
*   **Include copy number and mutations**: `ultra -c input.fa` (Adds copy number, insertions, deletions, and substitutions).

## Expert Tips

*   **FDR Tuning**: If working with non-standard genomes (e.g., extremely AT-rich), the default False Discovery Rate (FDR) might be high. Use `--fdr` to see the estimated rate and `--tune_fdr` to adjust thresholds.
*   **Sub-repeat Analysis**: ULTRA identifies changes in repetitive patterns within a single region. Check the `#Subrepeats`, `SubrepeatStarts`, and `SubrepeatConsensi` columns in the TSV output to understand internal repeat evolution.
*   **Output Files**: When using `-o`, ULTRA creates two files: the `.tsv` with annotations and a `.tsv.settings` file containing the parameters used for that run. This is useful for reproducibility.
*   **Summary Statistics**: By default, ULTRA provides an annotation coverage summary. If processing thousands of small scaffolds and this becomes too verbose, use `--disable_summary`.

## Reference documentation
- [ULTRA GitHub README](./references/github_com_TravisWheelerLab_ULTRA.md)
- [Bioconda ULTRA Overview](./references/anaconda_org_channels_bioconda_packages_ultra_overview.md)