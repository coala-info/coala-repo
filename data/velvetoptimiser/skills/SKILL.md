---
name: velvetoptimiser
description: VelvetOptimiser automates the optimization of Velvet genome assembly by iterating through k-mer lengths and coverage thresholds. Use when user asks to optimize genome assembly, find optimal k-mer lengths, estimate memory for assembly, or improve assembly quality.
homepage: https://github.com/tseemann/VelvetOptimiser
---


# velvetoptimiser

## Overview

VelvetOptimiser is a Perl-based wrapper script designed to streamline the use of the Velvet assembler. Instead of manually testing various k-mer lengths and coverage thresholds, this tool automates the search for an optimal assembly by iterating through a user-defined range of hash values. It estimates expected coverage, calculates optimal coverage cutoffs, and uses Velvet's internal mechanisms to determine insert lengths for paired-end libraries. It is particularly useful for maximizing assembly quality metrics such as N50 or the sum of long contigs without exhaustive manual intervention.

## Core CLI Usage

The primary command is `VelvetOptimiser.pl`. All input files and read types must be passed via the `-f` (or `--velvethfiles`) flag as a single quoted string.

### Basic Optimization
To find the best assembly within a k-mer range (e.g., 53 to 75):
```bash
VelvetOptimiser.pl -s 53 -e 75 -f '-short -fastq reads.fastq'
```

### Resource Management and Estimation
If you need to estimate RAM requirements before running a large assembly, provide the estimated genome size in Megabases:
```bash
VelvetOptimiser.pl -s 53 -e 75 -f '-short -fastq reads.fastq' -g 4.5 -t 8
```
*Note: When `-g` is provided, the tool will estimate memory, print the result, and exit without running the assembly.*

### Multi-threading
Use the `-t` flag to specify the maximum number of simultaneous Velvet instances:
```bash
VelvetOptimiser.pl -s 21 -e 31 -t 4 -f '-shortPaired -fasta interleaved.fasta'
```

## Parameter Best Practices

### K-mer (Hash) Selection
- **Odd Numbers Only**: Velvet requires odd k-mer lengths. If you provide an even number for `-s` (start) or `-e` (end), the tool will automatically decrement it by 1.
- **Range Limits**: The maximum k-mer value is limited by the `MAXKMERLENGTH` that Velvet was compiled with (often 31, 63, or 127).
- **Step Size (`-x`)**: This determines the increment between k-mer tests. It must be an even integer (default is 2).

### Optimization Functions
You can change what the "best" assembly means by adjusting the optimization functions:
- **`-k` (optFuncKmer)**: Function for k-mer choice. Default is `n50`.
- **`-c` (optFuncCov)**: Function for coverage cutoff optimization. Default is `Lbp` (Total bases in contigs longer than the k-mer).

### Input Formatting (`-f`)
The string passed to `-f` must contain everything you would normally pass to `velveth` except for the hash size and directory name.
- **Single-end**: `-f '-short -fastq reads.fq'`
- **Paired-end**: `-f '-shortPaired -fastq-gz reads.fq.gz'`
- **Multiple libraries**: `-f '-short -fastq s_1.fq -short2 -fastq s_2.fq'`

## Expert Tips

- **Verbose Logging**: Use `-v` to include the full output of `velveth` and `velvetg` in the log file. This is highly recommended for troubleshooting and for reviewing the insert lengths and standard deviations Velvet calculated for your libraries.
- **Output Management**: By default, results are placed in the current directory with a timestamped prefix. Use `-d` to specify a final output directory and `-p` to set a custom filename prefix.
- **Upper Coverage Cutoff**: The `-z` flag (default 0.8) controls the maximum coverage cutoff as a multiplier of the expected coverage. If your assembly is fragmented due to high-depth repeats, consider adjusting this value.
- **Read Tracking**: Use `-a` (or `--amosfile`) to turn on Velvet's read tracking, which generates an AMOS file for downstream assembly visualization.

## Reference documentation
- [VelvetOptimiser Manual](./references/github_com_tseemann_VelvetOptimiser.md)