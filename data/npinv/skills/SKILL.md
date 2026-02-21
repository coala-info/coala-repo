---
name: npinv
description: npInv is a specialized bioinformatics tool designed to identify and genotype inversion structural variations from long-read alignments.
homepage: https://github.com/haojingshao/npInv
---

# npinv

## Overview
npInv is a specialized bioinformatics tool designed to identify and genotype inversion structural variations from long-read alignments. Unlike tools focused on short-read data, npInv utilizes the unique properties of long reads—specifically multiple alignment signals—to accurately pinpoint inversion breakpoints and determine the zygosity of the events. It is particularly effective for resolving complex inversions that are often missed by standard variant callers.

## Installation and Requirements
The tool is available via Bioconda and requires a Java Runtime Environment (JRE) version 1.8 or higher.
```bash
conda install bioconda::npinv
```

**Critical Requirement**: The input BAM file must contain the `MD:Z:` tag. Ensure your aligner is configured to generate this field (standard in `minimap2`, `bwa mem`, and `ngmlr`).

## Basic Usage
The primary interface is a Java executable. The basic command requires an input BAM and an output VCF path.

```bash
java -jar npInv.jar --input input.bam --output results.vcf
```

## Command Line Options
| Option | Description | Default |
| :--- | :--- | :--- |
| `--input` | Path to the input BAM file (required). | N/A |
| `--output` | Path for the output VCF file (required). | N/A |
| `--region` | Specify a genomic region (e.g., `chr1:1-1000` or `chr1`). | all |
| `--min` | Minimum size of inversion to detect. | 500 |
| `--max` | Maximum size of inversion to detect. | 10000 |
| `--minAln` | Minimum alignment size for signal detection. | 500 |
| `--IRdatabase` | Path to an Inverted Repeat (IR) database in BED format. | none |

## Expert Tips and Best Practices

### 1. Improving Accuracy with IR Databases
Inversions often occur near or within inverted repeats. Providing a known IR database via the `--IRdatabase` flag significantly improves the tool's ability to resolve breakpoints in repetitive regions.

### 2. Tuning Detection Sensitivity
If you are looking for small inversions, you must decrease both `--min` and `--minAln`. Conversely, for very large structural variants, increase the `--max` parameter, as the default is capped at 10kb.

### 3. Aligner Selection
While `bwa` and `ngmlr` are supported, `minimap2` is generally recommended for Nanopore data due to its superior handling of long-read gaps and split alignments, which npInv relies on for inversion signaling.

### 4. Processing Specific Loci
For large genomes, running the tool on the entire BAM can be time-consuming. Use the `--region` flag to parallelize jobs by chromosome or to focus on specific candidate regions identified by other structural variant callers.

## Reference documentation
- [npinv - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_npinv_overview.md)
- [haojingshao/npInv: an accurate tool for detecting and genotyping inversion using multiple alignment long reads](./references/github_com_haojingshao_npInv.md)