---
name: magpurify
description: MAGpurify is a modular suite designed to improve the quality of metagenome-assembled genomes (MAGs) by identifying and removing "contaminant" contigs—those that likely originated from a different species than the dominant organism in the bin.
homepage: https://github.com/snayfach/MAGpurify
---

# magpurify

## Overview

MAGpurify is a modular suite designed to improve the quality of metagenome-assembled genomes (MAGs) by identifying and removing "contaminant" contigs—those that likely originated from a different species than the dominant organism in the bin. It employs a conservative approach, prioritizing specificity to ensure that very few legitimate contigs are incorrectly removed. The tool works through a two-stage process: first, running various detection modules to flag suspicious contigs, and second, using a cleaning module to produce the final refined genome.

## Core Workflow

The standard workflow involves running individual detection modules sequentially, followed by the cleaning step.

### 1. Environment Setup
Ensure the reference database is downloaded and the environment variable is set:
```bash
export MAGPURIFYDB=/path/to/MAGpurify-db-v1.0
```
Alternatively, use the `--db` flag in supported modules.

### 2. Run Detection Modules
Most modules follow the pattern: `magpurify <module> <input.fna> <output_dir>`

*   **Taxonomic Discordance**:
    *   `magpurify phylo-markers bin.fna output/` (Uses universal phylogenetic markers)
    *   `magpurify clade-markers bin.fna output/` (Uses clade-specific markers)
*   **Sequence Composition**:
    *   `magpurify tetra-freq bin.fna output/` (Identifies tetranucleotide frequency outliers)
    *   `magpurify gc-content bin.fna output/` (Identifies GC content outliers)
*   **Known Contaminants**:
    *   `magpurify known-contam bin.fna output/` (Matches against a database of common contaminants)

### 3. Final Refinement
After running the desired modules, generate the cleaned MAG:
```bash
magpurify clean-bin bin.fna output/ bin_cleaned.fna
```

## Advanced Modules

### Coverage Profile Analysis
Requires one or more sorted BAM files of reads mapped to the MAG.
```bash
magpurify coverage bin.fna output/ sample1.bam sample2.bam
```
*Tip*: If multiple BAM files are provided, MAGpurify automatically selects the one with the highest average coverage for outlier detection.

### Conspecific Alignment
Used when you have closely related reference genomes. This requires building a Mash sketch first.
```bash
# 1. Create Mash sketch
mash sketch -l ref_genomes.list -o ref_genomes_sketch

# 2. Run module
magpurify conspecific bin.fna output/ ref_genomes_sketch.msh
```

## Best Practices

*   **Sequential Execution**: Modules do not depend on each other and can be run in any order or in parallel, provided they share the same output directory.
*   **Conservative Defaults**: The default parameters are tuned for high specificity. If you suspect significant remaining contamination, consider adjusting thresholds for more sensitive detection.
*   **Database Pathing**: If the `MAGPURIFYDB` variable is not set, you must manually provide the path using `--db` for `phylo-markers`, `clade-markers`, and `known-contam`.
*   **Cleaning Logic**: The `clean-bin` module looks for specific subdirectories in the output folder created by the detection modules. Do not rename these subdirectories manually.

## Reference documentation
- [MAGpurify GitHub Repository](./references/github_com_snayfach_MAGpurify.md)
- [MAGpurify Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_magpurify_overview.md)