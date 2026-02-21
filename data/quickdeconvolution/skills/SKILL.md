---
name: quickdeconvolution
description: QuickDeconvolution is a specialized tool designed for linked-reads bioinformatics.
homepage: https://github.com/RolandFaure/QuickDeconvolution
---

# quickdeconvolution

## Overview
QuickDeconvolution is a specialized tool designed for linked-reads bioinformatics. In linked-reads sequencing, multiple long DNA fragments often share the same barcode. This tool performs "deconvolution" to identify which reads belong to which specific fragment without requiring a reference genome. It processes barcoded reads (containing the `BX:Z` tag) and appends a sub-barcode suffix (e.g., `-1`, `-2`) to the existing barcode to represent distinct fragments.

## Installation
The recommended method is via Bioconda:
```bash
conda install -c bioconda quickdeconvolution
```

## Basic Usage
The tool requires an input file with `BX:Z` tags and an output path.

```bash
QuickDeconvolution -i input.fastq -o output_deconvolved.fastq
```

### Handling Paired-End Reads
QuickDeconvolution requires paired-end data to be interleaved in a single file where the two ends of a pair share the same name. You can interleave two FASTQ files using the following pattern:

```bash
paste -d '\n' <(awk '{if (NR%4==1){printf"\n";printf $0;} else{printf "((()))"$0;}}' forward.fq) \
<(awk '{if (NR%4==1){printf"\n";printf $0;}else{ printf "((()))"$0;}}' reverse.fq) \
| sed 's/((()))/\n/g' > interleaved.fastq
```

## Command Line Options
| Option | Description | Default | Recommended Range |
| :--- | :--- | :--- | :--- |
| `-k`, `--kmers-length` | Size of k-mers used for alignment. | 21 | Avoid < 15 |
| `-w`, `--window-size` | Window size for minimizing k-mers. | 40 | 10 - 50 |
| `-d`, `--density` | Density of indexed k-mers (1/2^d). | 3 | 1 - 5 |
| `-t`, `--threads` | Number of parallel threads. | 1 | Based on CPU |
| `-a`, `--dropout` | Ignore clouds with fewer reads than this value. | 0 | User-defined |

## Expert Tips and Best Practices
- **Interpreting Output**: The tool appends a suffix to the barcode. For example, `BX:Z:AAAACTGTAT-1` and `BX:Z:AAAACTGTAT-2` indicate reads from the same original barcode that have been assigned to different fragments.
- **The -0 Tag**: Reads assigned the `-0` suffix (e.g., `BX:Z:AAAACTGTAT-0`) are those that the program could not successfully deconvolve.
- **Performance Tuning**: Increasing threads (`-t`) will decrease wall-clock time but significantly increase RAM usage. Monitor system memory when scaling up thread counts.
- **Optimization**: If you only care about large read clouds for downstream assembly or scaffolding, use the `-a` (dropout) option to skip processing small clouds, which saves computation time.
- **Parameter Sensitivity**: The deconvolution is generally robust. However, if precision is low, try decreasing `-w` or `-d` to increase k-mer density at the cost of longer runtimes.

## Reference documentation
- [QuickDeconvolution GitHub Repository](./references/github_com_RolandFaure_QuickDeconvolution.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_quickdeconvolution_overview.md)