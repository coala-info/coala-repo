---
name: pisces
description: Pisces is a variant calling suite optimized for detecting low-frequency somatic variants in amplicon and enrichment panels. Use when user asks to call variants from BAM files, detect somatic mutations without a matched normal, or phase complex variants.
homepage: https://github.com/Illumina/Pisces
metadata:
  docker_image: "quay.io/biocontainers/pisces:5.2.10.49--0"
---

# pisces

## Overview

Pisces is a specialized variant calling suite optimized for amplicon and enrichment panels. While it supports germline calling, its primary strength lies in detecting low-frequency somatic variants in heterogeneous tumor samples where a matched normal sample is unavailable. It operates by streaming BAM files, building coverage matrices, and applying a Poisson-based noise model to differentiate true variants from sequencing artifacts. The suite includes additional tools for read stitching (Stitcher) and phasing complex variants (Scylla).

## Command Line Usage

Pisces is a .NET Core application. On Linux or Windows, it is typically invoked via the `dotnet` command.

### Basic Execution
The minimal command requires an input BAM and a reference genome directory.
```bash
dotnet Pisces.dll -bam /path/to/sample.bam -g /path/to/ReferenceGenome/ -out /path/to/output/
```

### Key Parameters
- `-bam <file>`: Path to the input BAM file.
- `-g <dir>`: Path to the directory containing the reference genome (FASTA). The genome build must match the one used for alignment.
- `-out <dir>`: Directory where VCF/gVCF results will be written.
- `-minvf <float>`: Minimum variant frequency threshold (default is 0.01 for 1%).
- `-q <int>`: Minimum base call quality score (default is 20).
- `-gvcf`: Output results in gVCF format.

## Expert Tips and Best Practices

### Optimizing Sensitivity for Low-Frequency Variants
Pisces' ability to detect low-frequency variants is directly tied to the base quality filter (`-q`).
- **1% Frequency (Default):** Use `-q 20`. This is the standard for most somatic workflows.
- **0.1% Frequency:** Increase to `-q 30`. This reduces the noise floor, allowing Pisces to grant higher confidence to lower frequency alleles, provided the library prep supports such high-quality calls.

### Handling Paired-End Data
For amplicon data with overlapping paired-end reads, use the **Stitcher** tool before calling variants. Stitching creates a single consensus read from the pair, which reduces false positives caused by sequencing errors in the overlap region.

### Phasing Complex Regions
If your region of interest contains multiple mutations in close proximity, run **Scylla** after Pisces. Scylla detects Multiple Nucleotide Variants (MNVs) and phases variants in complex regions into sub-populations, which is critical for accurate functional annotation.

### System Requirements & Environment
- **Linux Dependencies:** Ensure `libFileCompression.so` is located in the same directory as `Pisces.dll`.
- **Runtime:** Requires .NET Core 2.0 or higher.
- **Memory:** Pisces uses block-processing to manage memory, but high-depth amplicon data (e.g., >10,000x) may require significant RAM depending on the number of candidate variants.

### Genotype Interpretation
In somatic mode, Pisces uses `0/1` to indicate that both reference and alternate alleles were detected above the threshold (e.g., 1%). This does **not** imply a diploid heterozygous state; a variant at 5% frequency will still be labeled `0/1`.

## Reference documentation
- [Illumina Pisces GitHub Repository](./references/github_com_Illumina_Pisces.md)
- [Pisces Wiki and User Guide](./references/github_com_Illumina_Pisces_wiki.md)