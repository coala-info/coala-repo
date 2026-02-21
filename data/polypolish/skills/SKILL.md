---
name: polypolish
description: Polypolish is a conservative short-read polishing tool that excels at resolving consensus errors in repetitive genomic regions.
homepage: https://github.com/rrwick/Polypolish
---

# polypolish

## Overview
Polypolish is a conservative short-read polishing tool that excels at resolving consensus errors in repetitive genomic regions. While most polishers rely on "best-match" alignments that often leave repeats uncovered, Polypolish uses SAM files containing all possible alignments for each read. This ensures that even identical repeat copies receive the necessary read coverage for error correction. It is highly conservative, meaning it prefers to leave a sequence unchanged rather than risk introducing a new error, making it an ideal final step in a microbial assembly pipeline.

## Installation
Install Polypolish via Bioconda:
```bash
conda install bioconda::polypolish
```

## Core Workflow
Polypolish requires a specific alignment strategy to function correctly. You must ensure your aligner reports all valid alignments for every read.

### 1. Align Short Reads
Use an aligner like `bwa mem` or `minimap2`, but ensure you disable the default behavior of picking a single best hit.

**Using BWA-MEM:**
```bash
# Index the assembly
bwa index assembly.fasta

# Align reads, using -a to output all alignments
bwa mem -t 8 -a assembly.fasta reads_1.fastq reads_2.fastq > alignments.sam
```

**Using Minimap2:**
```bash
# Use -N 0 to keep all alignments
minimap2 -t 8 -ax sr -N 0 assembly.fasta reads_1.fastq reads_2.fastq > alignments.sam
```

### 2. Filter Alignments (Optional but Recommended)
For paired-end reads, use the insert size filter to remove alignments that do not match the expected library orientation or distance.
```bash
polypolish filter --in alignments.sam --out filtered_alignments.sam
```

### 3. Run Polishing
Execute the polishing command to generate the corrected assembly.
```bash
polypolish polish assembly.fasta filtered_alignments.sam > polished_assembly.fasta
```

## Expert Tips and Best Practices
- **Conservative Nature**: Polypolish will only change a base if the evidence is unambiguous. If multiple bases are possible at a position, it will leave the original assembly base intact.
- **Repeat Resolution**: The primary strength of this tool is fixing homopolymer errors and small indels in repeats. If your assembly has large-scale structural errors, use a tool like `Trycycler` before polishing.
- **Careful Mode**: Use the `--careful` flag if you want to be even more cautious about introducing changes, though the default settings are already designed for high precision.
- **Multi-Tool Pipelines**: For maximum accuracy, combine Polypolish with other polishers. A common effective sequence is running `pypolca` followed by `polypolish`.
- **Memory Management**: Since SAM files with all-mapping reads can be very large, consider piping your aligner output directly into a filter or using sub-samplings if resources are limited.

## Reference documentation
- [Polypolish GitHub README](./references/github_com_rrwick_Polypolish.md)
- [Polypolish Wiki - Home](./references/github_com_rrwick_Polypolish_wiki.md)
- [Bioconda Polypolish Overview](./references/anaconda_org_channels_bioconda_packages_polypolish_overview.md)