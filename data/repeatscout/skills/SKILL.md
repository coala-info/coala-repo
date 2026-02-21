---
name: repeatscout
description: RepeatScout is a specialized tool for discovering repeat families in large genomes without prior knowledge of the sequences.
homepage: https://github.com/Dfam-consortium/RepeatScout
---

# repeatscout

## Overview
RepeatScout is a specialized tool for discovering repeat families in large genomes without prior knowledge of the sequences. It identifies short exact matches (seeds) and extends them into consensus sequences using a "fit-preferred" alignment score. This skill guides you through the four-phase process of l-mer tabulation, repeat discovery, and the subsequent filtering steps required to remove low-complexity sequences and tandem repeats.

## Core Workflow

### 1. Build L-mer Frequency Table
The first step tabulates the frequency of all l-mers in the target sequence.
```bash
build_lmer_table -sequence input.fa -freq input.freq
```
*   **Note**: The default l-mer length ($l$) is calculated as $ceil(\log_4(L)+1)$, where $L$ is the sequence length.

### 2. Run RepeatScout
Generate the initial consensus sequences using the frequency table.
```bash
RepeatScout -sequence input.fa -freq input.freq -output repeats_initial.fa
```
*   **Critical**: You must use the same `-l` value for both `build_lmer_table` and `RepeatScout` if you choose to override the default.

### 3. Post-Processing and Filtering
RepeatScout requires a multi-stage filtering process to refine the library.

**Stage 1: Filter low-complexity and tandem elements**
This script uses `dustmasker` (from NCBI BLAST+) and `trf` (Tandem Repeats Finder).
```bash
perl filter-stage-1.prl repeats_initial.fa > repeats_filtered_1.fa
```

**Stage 2: Filter by occurrence frequency**
After running RepeatMasker on your genome using the Stage 1 library, use this script to remove elements that appear fewer than a specific number of times (default is 10).
```bash
perl filter-stage-2.prl --cat repeats_filtered_1.fa --thresh 10 > repeats_filtered_2.fa
```

**Stage 3: Genomic Context Filtering**
Use `compare-out-to-gff.prl` to remove sequences that overlap with "uninteresting" regions like known exons or segmental duplications.
```bash
perl compare-out-to-gff.prl --cat repeats_filtered_2.fa --gff annotations.gff > final_repeats.fa
```

## Expert Tips and Best Practices

*   **Search Sensitivity**: The `-stopafter` parameter determines how far the algorithm searches when the alignment score stops improving. The default is 100 for speed, but the original paper used 500 for higher sensitivity.
*   **Memory Management**: RepeatScout is memory-intensive. For very large genomes, ensure you have sufficient RAM or process the genome in large chromosomal chunks.
*   **Sequence Boundaries**: Modern versions of RepeatScout (v1.0.3+) honor sequence boundaries in FASTA files, preventing seeds from extending across different scaffolds or chromosomes.
*   **Dependencies**: Ensure `dustmasker` and `trf` are in your system PATH before running the filtering scripts, as they are required for identifying simple repeats and tandem elements.
*   **Seed Extension Data**: In version 1.0.7+, you can record extended sequence coordinates for each seed into a TSV file for downstream analysis by using the appropriate command-line flags.

## Reference documentation
- [RepeatScout README](./references/github_com_Dfam-consortium_RepeatScout.md)
- [Bioconda RepeatScout Overview](./references/anaconda_org_channels_bioconda_packages_repeatscout_overview.md)