---
name: flash2
description: FLASH2 (Fast Length Adjustment of SHort reads) is a high-speed tool designed to merge overlapping paired-end reads into single, longer sequences.
homepage: https://github.com/dstreett/FLASH2
---

# flash2

## Overview

FLASH2 (Fast Length Adjustment of SHort reads) is a high-speed tool designed to merge overlapping paired-end reads into single, longer sequences. By identifying the optimal overlap between forward and reverse reads, it produces a consensus sequence that reduces error rates in the overlapped region and provides longer starting material for assemblers. 

Compared to the original FLASH, this version (flash2) provides superior handling of non-standard overlaps, such as "outies" (where reads overlap but point in opposite directions) and "engulfed" cases (where one read is entirely contained within the other). It is highly efficient, utilizing multithreading and minimal memory.

## Installation

The most reliable way to install flash2 is via Bioconda:

```bash
conda install bioconda::flash2
```

## Common CLI Patterns

### Basic Merging
The simplest usage requires two input FASTQ files (forward and reverse):

```bash
flash2 read_R1.fastq read_R2.fastq
```

### Controlling Sensitivity
Adjust the overlap requirements based on your library preparation:

```bash
# Set minimum overlap to 20bp (default is 10) and max mismatch density to 0.1
flash2 -m 20 -x 0.1 read_R1.fastq read_R2.fastq
```

### Performance and Determinism
By default, flash2 uses all available processors.

```bash
# Use a specific number of threads
flash2 -t 4 read_R1.fastq read_R2.fastq

# Force deterministic output order (required if downstream tools depend on read order)
flash2 --threads=1 read_R1.fastq read_R2.fastq
```

### Handling Amplicons and Outies
FLASH2 is specifically modified to handle amplicon sequencing where "outie" overlaps are common.

```bash
# Explicitly handle outie overlaps with a specific minimum overlap
flash2 --allow-outies --min-overlap-outie 35 read_R1.fastq read_R2.fastq
```

## Expert Tips

- **Engulfed Reads**: If your fragments are very short (shorter than a single read length), one read may "engulf" the other. FLASH2 handles this automatically, but you can tune the logic using the `--min-overlap-outie` parameter if you suspect many fragments are shorter than your read length.
- **Memory Efficiency**: FLASH2 is extremely lightweight, typically using less than 2 MB of RAM even when processing millions of reads. It is safe to run on low-resource environments.
- **Output Files**: FLASH2 generates several files by default:
    - `out.extendedFrags.fastq`: The successfully merged reads.
    - `out.notCombined_1.fastq` / `out.notCombined_2.fastq`: Reads that failed to merge.
    - `out.hist` / `out.histogram`: Visual representation of the overlap lengths.
- **Quality Scores**: If you have high error rates (e.g., 5%), increase the max mismatch density (`-x 0.35`) to maintain a high merging rate, though this may increase the risk of false merges.
- **Primer Dimers**: Use the "Threshold Quality" features if you encounter issues with primer dimers in your amplicon sets.

## Reference documentation

- [FLASH2 Overview](./references/anaconda_org_channels_bioconda_packages_flash2_overview.md)
- [FLASH2 GitHub README](./references/github_com_dstreett_FLASH2.md)
- [FLASH2 Feature Commits](./references/github_com_dstreett_FLASH2_commits_master.md)