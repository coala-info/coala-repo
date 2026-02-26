---
name: instrain
description: inStrain analyzes metagenomic read mappings to provide high-resolution insights into microbial microdiversity and strain-level population dynamics. Use when user asks to profile microbial samples, compare multiple populations using PopANI, call SNPs, or track strain evolution across longitudinal datasets.
homepage: https://github.com/MrOlm/inStrain
---


# instrain

## Overview
inStrain is a specialized bioinformatics suite for the high-resolution analysis of co-occurring microbial populations. While standard metagenomics often stops at species-level identification, inStrain utilizes paired-end bit-level data from read mappings to provide insights into microdiversity, linkage, and evolutionary pressures. It is the primary tool for researchers looking to differentiate closely related strains within a complex community and track their persistence or evolution across longitudinal datasets.

## Installation
The recommended method for installing inStrain is via Bioconda to ensure all dependencies (like samtools and pysam) are correctly managed.

```bash
conda install -c conda-forge -c bioconda instrain
```

## Core Workflow

### 1. Profiling a Sample
The `profile` command is the entry point. it calculates microdiversity, coverage, and calls SNPs for a single mapping file.

```bash
inStrain profile mapping.bam genome_file.fasta -o output_profile_dir
```
*   **Input**: A sorted BAM file and the corresponding FASTA reference.
*   **Output**: A directory containing several TSV files (e.g., `output_profile_dir/output/output_genome_info.tsv`).

### 2. Comparing Multiple Samples
Once profiles are generated for individual samples, use `compare` to identify shared SNPs and calculate PopANI (Population Average Nucleotide Identity).

```bash
inStrain compare -i profile_dir1 profile_dir2 profile_dir3 -o comparison_output
```

## Expert Tips and Best Practices

### Scaffold-to-Bin (STB) Files
If your reference FASTA contains many scaffolds belonging to different bins (genomes), provide an `.stb` file. This allows inStrain to aggregate statistics at the genome level rather than just the scaffold level.
*   **Format**: A two-column TSV (no header) where column 1 is the scaffold ID and column 2 is the bin name.
*   **Usage**: Add `-s path/to/file.stb` to the `profile` or `compare` command.

### Handling Large Databases
When working with a massive number of reference genomes (e.g., a large GTDB-based database), use the `--database_mode`. This optimizes how inStrain handles memory and reporting for thousands of genomes.

### Filtering for Accuracy
*   **Minimum Coverage**: By default, inStrain requires 5x coverage to call a position "covered." You can adjust this with `--min_cov`.
*   **MapQ**: Ensure your BAM files are filtered for high-quality mappings (usually MapQ > 2) before profiling to avoid false-positive SNP calls from misaligned reads.

### Key Output Files to Inspect
*   **genome_info.tsv**: Summary of coverage, breadth, and microdiversity per genome.
*   **SNVs.tsv**: Detailed list of all identified variants, including whether they are synonymous or non-synonymous.
*   **linkage.tsv**: Information on co-occurrence of SNPs on the same physical reads, useful for determining if mutations are on the same genetic background.

## Reference documentation
- [inStrain GitHub README](./references/github_com_MrOlm_inStrain.md)
- [Bioconda inStrain Overview](./references/anaconda_org_channels_bioconda_packages_instrain_overview.md)
- [inStrain Issues (Technical Troubleshooting)](./references/github_com_MrOlm_inStrain_issues.md)