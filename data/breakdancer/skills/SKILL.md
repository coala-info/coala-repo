---
name: breakdancer
description: BreakDancer discovers genome-wide structural variants by identifying read pairs with unexpected separation distances or orientations. Use when user asks to generate library configuration files from BAM files, detect structural variants like deletions or translocations, or filter variants by mapping quality and read support.
homepage: https://github.com/genome/breakdancer
metadata:
  docker_image: "quay.io/biocontainers/breakdancer:1.4.5--pl5321h264e753_11"
---

# breakdancer

## Overview

BreakDancer is a specialized tool for genome-wide discovery of structural variants. It operates by identifying read pairs that map with unexpected separation distances or orientations. The tool consists of two primary components: **BreakDancerMax**, which predicts a wide range of SV types, and **BreakDancerMini**, which focuses on small indels (10-100bp) using normally mapped pairs. This skill provides the procedural knowledge required to prepare input configurations and execute the SV detection pipeline.

## Core Workflow

The BreakDancer pipeline requires a two-step process: generating a library configuration file and then running the SV detector.

### 1. Configuration Generation
Before calling variants, you must calculate library statistics (mean and standard deviation of insert sizes) for your BAM files.

```bash
# Generate configuration from one or more BAM files
perl bam2cfg.pl sample1.bam sample2.bam > analysis.cfg
```

**Requirements for BAM files:**
- Must be sorted and indexed.
- Must contain proper Read Group (`@RG`) tags in both the header and every alignment record.
- `bam2cfg.pl` depends on `AlnParser.pm` being in the Perl library path.

### 2. Structural Variant Calling
Run the primary analysis using the generated configuration file.

```bash
# Basic execution
breakdancer_max analysis.cfg > sv_calls.output
```

## Command Line Options and Patterns

### Filtering and Quality Control
- **`-q INT`**: Minimum mapping quality (default: 35). Increase this to reduce false positives from repetitive regions.
- **`-y INT`**: Phred-style probability score filter (default: 40). SVs with scores below this threshold are filtered out.
- **`-r INT`**: Minimum number of read pairs required to support a variant (default: 2). Increasing this (e.g., to 4 or 5) improves confidence in high-coverage data.
- **`-c INT`**: Cutoff in units of standard deviation (default: 3). This defines how many standard deviations a read pair must be from the mean to be considered "anomalous."

### Performance and Parallelization
- **`-o STRING`**: Operate on a single chromosome. Use this to parallelize jobs across a cluster (one job per chromosome).
- **`-t`**: Only detect transchromosomal rearrangements. This is useful for specific cancer genomics workflows.

### Output Customization
- **`-g STRING`**: Dump SVs and supporting reads in BED format for visualization in genome browsers (e.g., IGV or GBrowse).
- **`-d STRING`**: Save supporting reads into fastq files with the specified prefix, organized by library.
- **`-h`**: Include the Allele Frequency column in the output (particularly useful for deletions).

## Configuration File Format
If manually editing or generating the configuration file, each line must be tab-delimited and contain at least these six key-value pairs:
- `map:` Path to the BAM file.
- `mean:` Mean insert size.
- `std:` Standard deviation of insert size.
- `readlen:` Average read length.
- `sample:` Unique identifier for the library.
- `exe:` The command used to view the map (usually `samtools view`).

Example line:
`map:tumor.bam mean:315.09 std:43.92 readlen:75.00 sample:PatientA exe:samtools view`

## Expert Tips
- **Mate-Pair Libraries**: If using Illumina long-insert (mate-pair) libraries, always include the `-l` flag to ensure the orientation logic is handled correctly.
- **Copy Number Integration**: BreakDancerMax computes copy number based on genome-wide normalization. Use `-a` to toggle whether this is reported per BAM file or per library.
- **Small Indels**: For variants between 10bp and 100bp that are missed by the standard "Max" algorithm, run `breakdancer_mini` on the same configuration file.

## Reference documentation
- [BreakDancer README](./references/github_com_genome_breakdancer.md)