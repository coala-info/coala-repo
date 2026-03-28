---
name: gargammel-slim
description: gargammel-slim simulates ancient DNA sequences by modeling fragment degradation, post-mortem damage, and various sources of contamination. Use when user asks to simulate ancient DNA reads, model post-mortem deamination, add human or microbial contamination to a sample, or benchmark ancient DNA bioinformatic pipelines.
homepage: https://github.com/grenaud/gargammel
---

# gargammel-slim

## Overview
gargammel-slim is a specialized toolset designed to simulate the complex degradation and contamination profiles characteristic of ancient DNA. It models the entire "in vivo to in silico" process: sampling random fragments from a genome, applying post-mortem damage (deamination), adding adapters, and simulating sequencing errors. It is particularly useful for testing bioinformatic pipelines, evaluating the impact of contamination on downstream analyses, or benchmarking ancient DNA damage detection tools.

## Core Workflow
The pipeline requires a specific directory structure containing FASTA files for three components:
1. `endo/`: Endogenous ancient DNA (e.g., a diploid hominin).
2. `cont/`: Present-day human contamination.
3. `bact/`: Microbial/bacterial contamination.

### Basic Execution
Run the main driver script with the input directory and an output prefix:
```bash
gargammel.pl -c [coverage] --comp [endo,cont,bact] -o [output_prefix] [input_dir]
```

## CLI Best Practices and Patterns

### 1. Defining Sample Composition
The `--comp` flag defines the ratio of the three components (must sum to 1).
- **Clean sample**: `--comp 1,0,0`
- **Contaminated (8% human, 2% microbial)**: `--comp 0.9,0.08,0.02`
- **High microbial load**: `--comp 0.1,0.05,0.85`

### 2. Modeling DNA Damage (Deamination)
Damage is critical for realistic aDNA simulation. You can use the Briggs model or empirical matrices.

**Using Briggs Model Parameters:**
Specify the four parameters: `[v, λ, δd, δs]`.
```bash
# Example: 3% deamination at ends
gargammel.pl -damage 0.03,0.4,0.01,0.3 ...
```

**Using mapDamage Matrices:**
If you have a `misincorporation.txt` from a real sample, use it to replicate that specific damage profile.
```bash
# For double-stranded libraries
-mapdamage path/to/misincorporation.txt double

# For single-stranded libraries
-mapdamage path/to/misincorporation.txt single
```

### 3. Fragment Size Distribution
Ancient DNA is typically short. You can specify a fixed length or a distribution.
- **Fixed length**: `-l 40`
- **Log-normal distribution**: `--loc 4.106 --scale 0.358`
- **Empirical distribution file**: `-f src/sizefreq.size.gz`

### 4. Sequencing Parameters
gargammel uses ART to simulate Illumina reads.
- **Platform**: `-ss HS25` (HiSeq 2500), `-ss MSv1` (MiSeq v1).
- **Read Length**: `-rl 75` (for 75bp reads).
- **Single-end**: Add `-se` flag. Default is paired-end.

## Expert Tips
- **Diploid Endogenous**: Ensure the `endo/` folder contains at least two FASTA files to represent a diploid individual.
- **Microbial Diversity**: For realistic `bact/` simulations, include a diverse set of representative microbial genomes rather than a single species.
- **Coverage vs. Count**: Use `-c` to target a specific depth of coverage or `-n` to generate an exact number of fragments.
- **Reference Generation**: Use the included `ms2chromosomes.py` or `msprime_chromosomes.py` scripts to generate synthetic population genetic data as input for gargammel if real genomes are not being used.



## Subcommands

| Command | Description |
|---------|-------------|
| adptSim | This program reads a fasta file containing aDNA fragments and splits them into two records, one containing the forward read and the second containing the reverse read (-fr,-rr) or into a single for single-end mode (-fr) |
| deamSim | Reads a fasta (default) or BAM file containing aDNA fragments and adds deamination according to a certain model file. Some model files are found in the models/ directory. If the input is fasta, the output will be fasta as well. |
| fragSim | This program takes a fasta file representing a chromosome and generates aDNA fragments according to a certain distribution |

## Reference documentation
- [gargammel README](./references/github_com_grenaud_gargammel_blob_master_README.md)
- [gargammel.pl Source](./references/github_com_grenaud_gargammel_blob_master_gargammel.pl.md)
- [Conda Environment Specs](./references/github_com_grenaud_gargammel_blob_master_environment.yml.md)