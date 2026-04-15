---
name: hg-color
description: HG-CoLoR is a hybrid correction tool that fixes errors in long-read sequencing data by aligning short reads and traversing a de Bruijn graph. Use when user asks to correct long reads using short reads, improve long-read accuracy, or perform hybrid error correction.
homepage: https://github.com/pierre-morisse/HG-CoLoR
metadata:
  docker_image: "quay.io/biocontainers/hg-color:1.1.1--he1b5a44_0"
---

# hg-color

## Overview
HG-CoLoR is a hybrid correction tool designed to fix errors in long-read sequencing data. It works by aligning short reads to long reads to establish "seeds" and then traversing a variable-order de Bruijn graph (built from the short reads) to fill the gaps between those seeds. This approach is particularly effective for resolving complex genomic regions where fixed-order graphs might struggle.

## Core Usage
The basic command structure requires long reads (FASTA), short reads (FASTQ), an output prefix, and a maximum K-mer size.

```bash
HG-CoLoR --longreads LR.fasta --shortreads SR.fastq --out corrected_output -K 50
```

### Input Requirements
- **Long Reads**: Must be in FASTA format with one sequence per line.
- **Short Reads**: Must be a single FASTQ file. If you have paired-end data, concatenate the files first: `cat R1.fastq R2.fastq > SR.fastq`.
- **K-mer Size (`-K`)**: This is the maximum order for the graph. Common values range from 31 to 75 depending on read length and complexity.

## Parameter Optimization
Adjust these settings based on your specific dataset characteristics:

### Handling Coverage and Error Rates
- **Solid K-mers (`--solid`, `-S`)**: The minimum occurrences for a k-mer to be considered valid. 
    - *Default (1)*: Good for low coverage.
    - *High Coverage*: Increase this (e.g., 2-5) to filter out short-read sequencing errors.
- **Alignment Depth (`--bestn`, `-n`)**: Number of alignments reported by BLASR.
    - *Default (50)*: Optimized for 50x short-read coverage.
    - *Lower Coverage*: Increase this value.
    - *Higher Coverage*: Decrease this value to speed up processing.

### Graph Traversal and Seed Linking
- **Branching (`--branches`, `-b`)**: Maximum branch exploration (default 1,500). Increase this if you have many split reads, but be aware it increases runtime and risk of chimeras.
- **Seed Overlap (`--seedsoverlap`, `-o`)**: Minimum overlap to merge seeds. Default is `maxorder - 1`.
- **Mismatches (`--mismatches`, `-m`)**: Allowed errors when linking seeds. Default is 3; increase slightly for very noisy long reads.

## Performance Tips
- **Parallelization**: Use `--nproc` or `-j` to specify the number of CPU cores. By default, it attempts to use all available cores.
- **Memory Management**: Use `--kmcmem` or `-r` to limit the RAM used by KMC (default 12GB).
- **Temporary Files**: HG-CoLoR generates significant intermediate data. Use `--tmpdir` to point to a high-speed SSD or a location with ample space.

## Output Interpretation
The header of corrected reads contains metadata about the correction process:
`>id_len_seedsBases_graphBases_rawBases`
- **seedsBases**: Bases corrected via short-read alignment.
- **graphBases**: Bases corrected via graph traversal.
- **rawBases**: Uncorrected segments retained from the original long read.

## Reference documentation
- [GitHub Repository and Manual](./references/github_com_morispi_HG-CoLoR.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hg-color_overview.md)