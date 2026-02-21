---
name: aligncov
description: The provided text does not contain help information or usage instructions. It consists of system logs and a fatal error message indicating a failure to build or extract the container image due to insufficient disk space ('no space left on device').
homepage: https://github.com/pcrxn/aligncov
---

# aligncov

## Overview
The `aligncov` tool is a specialized utility for bioinformaticians who need to convert binary alignment data (BAM) into human-readable, "tidy" tab-separated tables. It automates the extraction of coverage metrics that are often tedious to calculate manually, providing both high-level summaries of target sequences and granular, position-by-position depth data.

## Installation and Setup
The tool requires `samtools` (>= 1.15) and `pandas`. It is best installed via Conda to manage these dependencies automatically.

```bash
# Create a dedicated environment and install
conda create -n aligncov aligncov
conda activate aligncov
```

## Command Line Usage
The tool follows a simple input/output pattern.

### Basic Command
```bash
aligncov -i input.bam -o my_results
```

### Arguments
- `-i, --input`: Path to the **sorted** BAM file.
- `-o, --output`: Base name for the output files. If omitted, it defaults to `sample`.

## Understanding the Output
The tool generates two specific TSV files based on your output prefix:

### 1. Summary Statistics (`[output]_stats.tsv`)
Use this file for high-level quality control and target comparison.
- **seqlen**: Length of the reference target in base pairs.
- **depth**: Total number of base pairs mapped to the target.
- **len_cov**: Number of bases covered by at least one read.
- **prop_cov**: Breadth of coverage (0.0 to 1.0).
- **fold_cov**: Mean depth of coverage (Total depth / seqlen).

### 2. Per-Base Depth (`[output]_depth.tsv`)
Use this file for plotting coverage across a genome or identifying specific gaps.
- **target**: Reference sequence name.
- **position**: 1-based coordinate.
- **depth**: Number of reads covering that specific position.

## Expert Tips and Best Practices
- **Pre-sorting Requirement**: `aligncov` requires a sorted BAM file. If your BAM is unsorted, run `samtools sort -o sorted.bam unsorted.bam` before using this tool.
- **Tidy Data Integration**: Because the output is "tidy" (one observation per row), you can load these files directly into R using `read_tsv()` or Python using `pd.read_csv(sep='\t')` without additional cleaning.
- **Large BAM Files**: For very large BAM files, the `_depth.tsv` file can become extremely large (one row per base pair). Ensure you have sufficient disk space if processing whole-genome alignments.
- **Target Filtering**: If you only need coverage for specific chromosomes, use `samtools view -b input.bam chr1 > filtered.bam` to create a subset before running `aligncov`.

## Reference documentation
- [AlignCov GitHub Repository](./references/github_com_pcrxn_aligncov.md)
- [Bioconda aligncov Package Overview](./references/anaconda_org_channels_bioconda_packages_aligncov_overview.md)