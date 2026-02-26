---
name: hapog
description: HAPO-G is a haplotype-aware genomic tool designed to improve assembly consensus quality and maintain phasing using high-accuracy reads. Use when user asks to polish a genome assembly, correct mismatches and small indels, or identify homozygous and heterozygous assembly errors.
homepage: https://github.com/institut-de-genomique/HAPO-G
---


# hapog

## Overview

HAPO-G (Haplotype-Aware Polishing of Genomes) is a genomic tool designed to improve the consensus quality of an assembly using high-accuracy reads. It distinguishes itself from general polishers by being "haplotype-aware," meaning it attempts to follow a single read as a template for as long as possible to maintain phasing. It effectively corrects mismatches, small insertions, and deletions while identifying whether changes are homozygous (present in both haplotypes) or heterozygous (phasing errors).

## Installation

The most reliable way to install HAPO-G is via Bioconda:

```bash
conda install -c bioconda hapog
```

## Common CLI Patterns

### Standard Polishing Pipeline
Use this pattern when starting from raw Illumina paired-end reads. HAPO-G will handle the mapping internally using BWA.

```bash
hapog --genome assembly.fasta \
  --pe1 reads_R1.fastq.gz \
  --pe2 reads_R2.fastq.gz \
  -o output_dir \
  -t 16 \
  -u
```

### Polishing from an Existing BAM
If you have already mapped your reads, you can skip the mapping step to save time. Ensure the BAM is sorted and indexed.

```bash
hapog --genome assembly.fasta \
  -b mapping.sorted.bam \
  -o output_dir \
  -t 16 \
  -u
```

### Rerunning Failed Chunks
If a multi-threaded run fails on specific segments, you can resume only those chunks without restarting the entire process.

```bash
hapog --chunk-list 3,7,12 \
  -o output_dir \
  --genome assembly.fasta \
  [other original options]
```

## Expert Tips and Best Practices

*   **The Essential `-u` Flag**: Always include the `-u` flag. By default, HAPO-G only outputs sequences that were actually polished. If a contig has no read coverage, it will be omitted from the output unless `-u` is used to include unpolished sequences.
*   **Clean Fasta Headers**: Before running HAPO-G, ensure your Fasta headers contain only alphanumeric characters, underscores (`_`), or dashes (`-`). Special characters can cause failures in the underlying Samtools/BCFtools calls.
*   **BAM Requirements**: If providing a BAM file via `-b`, it **must not** contain secondary alignments. Secondary alignments can introduce non-ACTG characters into your consensus. If using Minimap2 to generate the BAM, use the `secondary=no` option.
*   **Interpreting Results**:
    *   `hapog.fasta`: The final polished assembly.
    *   `hapog.changes`: A 8-column TSV file. Look at column 6 (`hetero` vs `homo`) to determine if HAPO-G corrected a phasing error (hetero) or a general assembly error (homo).
*   **Memory Management**: For large genomes, monitor the number of threads. HAPO-G splits the genome into chunks; high thread counts increase the number of simultaneous subprocesses and memory consumption.

## Reference documentation
- [HAPO-G GitHub Repository](./references/github_com_institut-de-genomique_HAPO-G.md)
- [HAPO-G Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hapog_overview.md)