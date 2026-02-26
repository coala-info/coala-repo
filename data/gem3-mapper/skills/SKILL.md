---
name: gem3-mapper
description: gem3-mapper performs fast and sensitive genomic read mapping by aligning sequences against large reference genomes using a custom FM-Index. Use when user asks to index a reference genome, map single-end or paired-end reads, or perform high-throughput sequence alignment with GPU acceleration.
homepage: https://github.com/smarco/gem3-mapper
---


# gem3-mapper

## Overview
The gem3-mapper skill provides procedural knowledge for using the GEM3 suite to perform fast and sensitive genomic read mapping. It excels at aligning sequences up to 1K bases long against large reference genomes. The tool utilizes a custom FM-Index and supports various alignment models, including global and local alignment with gap-affine penalties. It is particularly useful for researchers requiring high-throughput processing with support for multithreading and GPU acceleration.

## Core Workflows

### 1. Indexing a Reference Genome
Before mapping, you must create a GEM index from a multi-FASTA reference file.

```bash
# Basic indexing
gem-indexer -i reference.fa -o reference_index

# Indexing for bisulfite sequencing (epigenetics)
gem-indexer -i reference.fa -o reference_bisulfite -b
```

### 2. Single-End Mapping
Map single-end reads to a pre-built index. The default output is SAM format.

```bash
# Standard single-end mapping
gem-mapper -I reference_index.gem -i reads.fastq -o output.sam

# High-sensitivity mode with specific error rate (e.g., 10%)
gem-mapper -I reference_index.gem -i reads.fastq --mapping-mode sensitive -e 0.10 -o output.sam
```

### 3. Paired-End Mapping
GEM3 supports both interleaved and separate FASTQ files for paired-end data.

```bash
# Separate files (End 1 and End 2)
gem-mapper -I reference_index.gem -1 reads_1.fastq -2 reads_2.fastq -o output.sam

# Interleaved file (requires -p flag)
gem-mapper -I reference_index.gem -i interleaved_reads.fastq -p -o output.sam
```

## Expert Tips and Best Practices

### Performance Optimization
*   **Threading**: By default, GEM3 uses all available logical cores. Use `-t <N>` to restrict CPU usage in shared environments.
*   **GPU Acceleration**: If the hardware supports it, add the `--gpu` flag to `gem-mapper` to significantly speed up the alignment process.
*   **Compressed I/O**: Use `-z` for gzip-compressed input or `-j` for bzip-compressed input to save disk space and reduce I/O overhead.

### Alignment Tuning
*   **Mapping Modes**: 
    *   `fast`: Optimized for speed (default).
    *   `sensitive`: Higher accuracy, slower execution.
    *   `customed`: Allows manual override of internal heuristics.
*   **Local Alignment**: If global alignment fails, you can trigger local alignment using `--alignment-local if-unmapped`.
*   **Reporting**: Control the number of reported matches per read with `-M <N>`. Use `-M all` for complete search results, though this increases output size significantly.

### Output Formatting
*   **SAM Compatibility**: Use `--sam-compact true` (default) to include alternative hits in the `XA` tag, keeping the SAM file manageable.
*   **Read Groups**: Always define read group headers for downstream GATK/Picard compatibility using `-r '@RG\tID:ID_STR\tSM:SAMPLE_NAME'`.

## Reference documentation
- [GEM-Mapper v3 README](./references/github_com_smarco_gem3-mapper.md)
- [Bioconda gem3-mapper Package](./references/anaconda_org_channels_bioconda_packages_gem3-mapper_overview.md)