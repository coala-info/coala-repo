---
name: perl-velvetoptimiser
description: The VelvetOptimiser is a Perl-based wrapper designed to streamline the use of the Velvet assembler.
homepage: https://github.com/tseemann/VelvetOptimiser
---

# perl-velvetoptimiser

## Overview
The VelvetOptimiser is a Perl-based wrapper designed to streamline the use of the Velvet assembler. It performs a heuristic search across a range of k-mer values and then optimizes the coverage cutoff for the best-performing k-mer. By automating these steps, it helps researchers maximize assembly metrics like N50 or total assembly length. This skill provides the necessary patterns to execute the optimizer, manage computational resources, and customize the scoring functions used to define a "successful" assembly.

## Core CLI Usage

The primary command is `VelvetOptimiser.pl`. It requires a k-mer range and a string representing the standard `velveth` input parameters.

### Basic Optimization Pattern
To search for the best k-mer between 51 and 71 (stepping by 2) for a single-end FASTQ library:
```bash
VelvetOptimiser.pl --hashs 51 --hashe 71 --step 2 --velvethfiles '-short -fastq reads.fastq'
```

### Common Parameters
- `-s, --hashs`: Starting (lower) k-mer value. If even, it will be lowered to the nearest odd number.
- `-e, --hashe`: Ending (higher) k-mer value.
- `-x, --step`: The increment for the k-mer search (default is 2).
- `-f, --velvethfiles`: The exact string of arguments you would normally pass to `velveth` (excluding the directory and k-mer). **Must be enclosed in quotes.**
- `-t, --threads`: Maximum number of simultaneous Velvet instances to run.

## Advanced Optimization and Resource Management

### Memory Estimation
Before running a large assembly, use the `-g` flag to estimate RAM requirements. The program will calculate the estimate and exit without running the assembly.
```bash
VelvetOptimiser.pl -s 53 -e 75 -f '-short -fastq reads.fq' -g 4.5 -t 8
```
*Note: `-g` is the genome size in Megabases (Mb).*

### Custom Optimization Functions
You can change what the optimizer considers a "good" assembly using the `-k` (k-mer choice) and `-c` (coverage cutoff choice) flags.
- **n50**: Optimizes for the N50 metric.
- **Lbp**: Optimizes for the total number of base pairs in contigs longer than 1kb.
- **n90**: Optimizes for the N90 metric.

Example optimizing for N50 at both stages:
```bash
VelvetOptimiser.pl -s 31 -e 45 -f '-shortPaired -fasta reads.fa' --optFuncKmer 'n50' --optFuncCov 'n50'
```

### Passing Options to velvetg
Use the `-o` flag to pass specific parameters directly to the `velvetg` stage, such as long read settings or specific cutoffs.
```bash
VelvetOptimiser.pl -s 61 -e 71 -f '-short reads.fq' -o '-long_mult_cutoff 2 -min_contig_lgth 200'
```

## Expert Tips
1. **K-mer Selection**: Velvet only uses odd k-mers. If you provide even numbers for `-s` or `-e`, the tool will automatically adjust them downwards.
2. **Thread Scaling**: While `-t` allows parallel k-mer searches, ensure your system has enough RAM to support `(threads * velvet_memory_usage)`.
3. **Output Management**: Use `-p` to set a custom prefix for your output files and `-d` to specify a final results directory. By default, it uses a timestamped prefix.
4. **Read Tracking**: If you need to perform downstream analysis like scaffolding or visualization, use `-a` (or `--amosfile`) to turn on read tracking and generate an AMOS file.

## Reference documentation
- [VelvetOptimiser GitHub Repository](./references/github_com_tseemann_VelvetOptimiser.md)
- [Bioconda perl-velvetoptimiser Package](./references/anaconda_org_channels_bioconda_packages_perl-velvetoptimiser_overview.md)