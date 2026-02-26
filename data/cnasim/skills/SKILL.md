---
name: cnasim
description: CNAsim simulates the evolutionary dynamics and genomic profiles of tumor cell populations to generate synthetic single-cell datasets. Use when user asks to simulate copy number profiles, generate synthetic readcounts, or produce full-scale DNA sequencing reads for tumor cell lineages.
homepage: https://github.com/samsonweiner/CNAsim
---


# cnasim

## Overview
CNAsim is a specialized simulation framework designed to model the evolutionary dynamics and genomic profiles of tumor cell populations. It excels at creating synthetic single-cell datasets that mimic the technical noise and biological complexity found in real-world sequencing. Use this skill to configure lineage trees, define subclonal structures, and generate multi-modal data ranging from simple integer copy number profiles to full-scale sequencing reads.

## Installation and Setup
The most reliable way to deploy CNAsim is via Bioconda to ensure all external dependencies (like `samtools` and `dwgsim`) are correctly linked.

```bash
conda create -n cnasim_env -c bioconda cnasim
conda activate cnasim_env
```

## Core Execution Modes
CNAsim operates in three distinct modes defined by the `-m` or `--mode` flag.

| Mode | Name | Output | Use Case |
| :--- | :--- | :--- | :--- |
| `0` | CNP Mode | Copy Number Profiles only | Rapid testing of subclonal evolution and lineage tree logic. |
| `1` | Count Mode | Readcounts + CNPs | Benchmarking bin-based CNA callers without the overhead of FASTQ files. |
| `2` | Seq Mode | DNA-seq reads + CNPs | Full end-to-end validation of sequencing pipelines (requires reference genome). |

## Common CLI Patterns

### 1. Basic Copy Number Profile Simulation
Generate profiles for 100 tumor cells with default subclonal evolution.
```bash
cnasim -m 0 -n 100 -o simulation_results/
```

### 2. Generating Readcounts (Mode 1)
Simulate readcounts directly. This is faster than generating full sequencing reads but provides more realism than raw profiles.
```bash
cnasim -m 1 -n 50 --reference reference.fasta -o count_data/
```

### 3. Full Sequencing Simulation (Mode 2)
Generate synthetic FASTQ files. Use `-P` to parallelize the process across multiple CPU cores.
```bash
cnasim -m 2 -n 20 -r1 hg38.fa -P 8 -o sequencing_output/
```

### 4. Using Human hg38 Static Reference
If working with the standard human genome (hg38) with "chr" prefixes, use the static flag to bypass manual fasta filtering.
```bash
cnasim -m 2 -n 50 --use-hg38-static -o hg38_sim/
```

## Expert Tips and Best Practices
- **Reference Genome Preparation**: In Mode 2, ensure your reference FASTA contains only the chromosomes you wish to simulate. Remove small unorganized scaffolds or alternate sequences unless specifically needed, as they can increase computation time.
- **Haplotype-Specific Simulation**: CNAsim supports allelic frequency analysis. Provide two distinct haploid references using `-r1` and `-r2` in Mode 2 to simulate heterozygous sites and allele-specific CNAs.
- **Parameter Files**: For complex simulations with many variables, use a parameter file instead of long CLI strings. Modify the default `parameters` file and run:
  ```bash
  cnasim -F
  ```
- **Memory Management**: When generating sequencing reads (Mode 2) for a large number of cells, ensure the output directory has sufficient disk space, as FASTQ files can grow very large.
- **Lineage Trees**: You can provide a custom cell lineage tree in Newick format using the `-T` or `--tree-path` flag if you want to simulate specific evolutionary trajectories rather than using the internal stochastic model.

## Reference documentation
- [CNAsim GitHub Repository](./references/github_com_samsonweiner_CNAsim.md)
- [Bioconda CNAsim Package Overview](./references/anaconda_org_channels_bioconda_packages_cnasim_overview.md)