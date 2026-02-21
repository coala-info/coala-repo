---
name: umicollapse
description: UMICollapse is a specialized bioinformatic tool used to identify and collapse duplicate reads that share the same Unique Molecular Identifier (UMI).
homepage: https://github.com/Daniel-Liu-c0deb0t/UMICollapse
---

# umicollapse

## Overview

UMICollapse is a specialized bioinformatic tool used to identify and collapse duplicate reads that share the same Unique Molecular Identifier (UMI). PCR amplification often creates redundant copies of the same original DNA/RNA molecule; UMICollapse uses advanced data structures like BK-trees and n-grams to efficiently group these duplicates even when they contain sequencing errors. It is designed to be a drop-in, high-performance replacement for UMI-tools, offering orders-of-magnitude faster processing times while maintaining similar deduplication logic.

## Installation and Setup

The most reliable way to use UMICollapse is via Conda:

```bash
conda install -c bioconda umicollapse
```

Note: UMICollapse requires **Java 11**. If running from the source or jar file, ensure your `JAVA_HOME` is set correctly.

## Common CLI Patterns

### Deduplicating Aligned BAM Files
The most common use case is deduplicating reads that have already been aligned to a reference genome. UMIs must be present in the read headers.

```bash
# Basic deduplication (autodetects UMI length)
umicollapse bam -i input.bam -o output.bam

# Specifying a UMI separator (e.g., if header is ReadName:ATGC...)
umicollapse bam -i input.bam -o output.bam --umi-sep :
```

### Paired-End Processing
For paired-end data, use the `--paired` flag. It is recommended to use the `--two-pass` algorithm for better memory efficiency and accuracy in paired mode.

```bash
umicollapse bam -i paired_input.bam -o dedup_output.bam --paired --two-pass
```

### FASTQ Mode (Alignment-Free)
If you want to collapse reads based on the entire sequence (treating the sequence itself as the UMI) without aligning to a genome:

```bash
umicollapse fastq -i input.fastq -o output.fastq
```

### Marking Duplicates Without Removing
If you need to keep all reads but mark duplicates with the BAM "duplicate" flag (0x400), use the `--tag` option. This also adds useful metadata tags:
* `cs`: Cluster size (total reads in the group).
* `su`: Number of reads with the exact same UMI.
* `MI`: Molecular Identifier (unique ID for the cluster).

```bash
umicollapse bam -i input.bam -o marked_output.bam --tag
```

## Expert Tips and Best Practices

*   **Error Tolerance**: By default, the tool allows 1 mismatch (`-k 1`). For very long UMIs or high-error-rate sequencing, you may want to increase this, though it will impact performance.
*   **Memory Management**: If you encounter memory issues with extremely large datasets, ensure you are using the `--two-pass` mode for BAM files. If running the `.jar` directly, you can increase the heap size (e.g., `java -Xmx10G -jar umicollapse.jar ...`).
*   **Unmapped Reads**: By default, UMICollapse removes unmapped reads. If you need to keep them, check for the latest `--keep-unmapped` flag support in your version.
*   **Parallelization**: While the tool has `-t` and `-T` flags for parallelization, the documentation notes these are often discouraged as they may lack certain features. The tool is generally fast enough on a single thread for most applications.
*   **UMI Extraction**: UMICollapse does not extract UMIs from the middle of reads. Use `umi_tools extract` first to move UMIs to the read header, then use UMICollapse for the heavy lifting of deduplication.

## Reference documentation
- [UMICollapse Overview](./references/anaconda_org_channels_bioconda_packages_umicollapse_overview.md)
- [UMICollapse GitHub Repository](./references/github_com_Daniel-Liu-c0deb0t_UMICollapse.md)