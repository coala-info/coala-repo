---
name: gargammel
description: gargammel is a specialized simulation suite that models the end-to-end process of ancient DNA retrieval.
homepage: https://github.com/grenaud/gargammel
---

# gargammel

## Overview

gargammel is a specialized simulation suite that models the end-to-end process of ancient DNA retrieval. It transforms reference genomes into degraded, damaged, and contaminated sequencing reads. The tool functions as a pipeline, sequentially running `fragSim` (fragmentation), `deamSim` (damage/deamination), and `adptSim` (adapter ligation), before finally utilizing ART to simulate Illumina-specific sequencing errors and quality scores. It is the standard tool for creating "gold standard" synthetic datasets where the ground truth of endogenous versus contaminant sequences is known.

## Input Preparation

gargammel requires a specific directory structure for its input. You must create a base directory containing three subdirectories:

1.  `endo/`: Contains the endogenous ancient genome (must be at least two files for a diploid individual).
2.  `cont/`: Contains present-day human contaminant genomes.
3.  `bact/`: Contains microbial/bacterial genomes representing environmental contamination.

Each file within these folders should represent a complete genome (not just individual chromosomes).

## Common CLI Patterns

### Basic Simulation with Contamination
To simulate a dataset with specific contamination levels (e.g., 2% human contamination and 90% microbial background):
```bash
gargammel.pl -c 5 --comp 0.08,0.02,0.90 -f src/sizefreq.size.gz -o output_prefix input_dir/
```
*   `-c`: Target coverage (e.g., 5X).
*   `--comp`: Composition ratios for [Endogenous, Contaminant, Bacterial].

### Simulating Specific Fragment Counts
If you need a specific number of fragments rather than a coverage depth:
```bash
gargammel.pl -n 1000000 --comp 1,0,0 -l 45 -o output_prefix input_dir/
```
*   `-n`: Total number of fragments to generate.
*   `-l`: Fixed fragment length (overrides distribution).

### Modeling DNA Damage (Deamination)
You can specify damage using the Briggs model parameters or an empirical matrix.

**Using Briggs Parameters:**
```bash
gargammel.pl -n 1000000 --comp 1,0,0 -damage 0.03,0.4,0.01,0.3 -o output_prefix input_dir/
```
*   Parameters: [v, λ, δ_d, δ_s] (nick frequency, length of overhanging ends, deamination rate in double-stranded parts, deamination rate in single-stranded parts).

**Using a mapDamage Matrix:**
```bash
gargammel.pl -n 1000000 --comp 1,0,0 -matfile path/to/misincorporation.txt -o output_prefix input_dir/
```

### Sequencing Configuration
Adjust the read length and Illumina platform to match your target experiment:
```bash
gargammel.pl -n 1000000 -rl 100 -ss HS25 -se -o output_prefix input_dir/
```
*   `-rl`: Read length (e.g., 100bp).
*   `-ss`: Sequencing system (e.g., `HS25` for HiSeq 2500, `MSv3` for MiSeq v3).
*   `-se`: Generate single-end reads (default is paired-end).

## Expert Tips

*   **Size Distributions**: For realistic simulations, always provide an empirical size distribution file using `-f`. Using fixed lengths (`-l`) or log-normal parameters (`--loc`, `--scale`) is usually reserved for theoretical testing.
*   **Intermediate Files**: gargammel generates several intermediate files during the `fragSim` and `deamSim` steps. Ensure you have sufficient disk space, as these can be large before they are processed into the final compressed FASTQ files.
*   **Microbial Diversity**: When populating the `bact/` folder, use a diverse set of microbes representative of the specific burial environment (e.g., soil bacteria for terrestrial samples) to accurately simulate mapping noise.
*   **Conda Environment**: If installed via Bioconda, the main executable is typically available as `gargammel`. If running from a git clone, use `gargammel.pl`.

## Reference documentation
- [gargammel - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gargammel_overview.md)
- [grenaud/gargammel: gargammel is an ancient DNA simulator](./references/github_com_grenaud_gargammel.md)