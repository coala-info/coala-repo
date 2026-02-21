---
name: stecfinder
description: STECFinder is a specialized bioinformatic tool designed to characterize Shigatoxin-producing *Escherichia coli*.
homepage: https://github.com/LanLab/STECFinder
---

# stecfinder

## Overview

STECFinder is a specialized bioinformatic tool designed to characterize Shigatoxin-producing *Escherichia coli*. It distinguishes itself from general serotyping tools by utilizing cluster-specific markers to provide phylogenetic context alongside O and H antigen identification. It is primarily used in public health and clinical microbiology workflows to identify high-risk STEC lineages and toxin profiles from either raw sequencing data or finished assemblies.

## Command Line Usage

The primary script is `STECFinder.py`.

### Basic Syntax

**Analyzing Genome Assemblies:**
```bash
STECFinder.py -i /path/to/genomes/*.fasta --output results.tsv
```

**Analyzing Raw Illumina Reads:**
Use the `-r` flag when providing FASTQ files.
```bash
STECFinder.py -r -i sample_R1.fastq.gz sample_R2.fastq.gz --output results.tsv
```

### Common Options
- `-t <int>`: Set the number of threads (default: 4).
- `--hits`: Output detailed gene search results (useful for troubleshooting "No Call" results).
- `--output <file>`: Specify output file path; if omitted, results write to stdout and a `tmp` folder.
- `--check`: Verify that dependencies (kma, blastn) are correctly installed in the environment.

## Expert Tips and Best Practices

### Raw Reads vs. Assemblies
- **Prefer Raw Reads for stx2:** Assemblies often collapse multiple *stx2* genes into a single locus. To accurately detect multiple *stx2* alleles or evaluate SNP frequencies within toxin genes, run STECFinder on raw reads (`-r`).
- **Assembly Method:** When using assemblies, the tool uses `blastn`. When using reads, it uses `kma` for mapping.

### Tuning Detection Sensitivity
If you are working with low-coverage data or divergent strains, you can adjust the following thresholds:
- **Gene Length:** Use `--length`, `--o_length`, or `--h_length` (percentage) to change the minimum coverage required for a positive call.
- **Depth (Reads Only):** Use `--stx_depth` or `--o_depth` to adjust the minimum depth relative to the genome average (default is often 1.0%).
- **ipaH Detection:** For *Shigella* or EIEC detection within the STEC workflow, adjust `--ipaH_length` and `--ipaH_depth`.

### Interpreting Results
- **Cluster Serotype:** This column provides a "filtered" serotype based on antigen matches that have been historically observed within the predicted phylogenetic cluster, offering higher confidence than the raw "Serotype" column.
- **Stx2 Allele Notation:** 
    - `*`: Indicates uncertainty (non-perfect match or minority SNPs).
    - `/`: Multiple possible alleles for a single locus.
    - `,`: Multiple separate *stx2* loci detected in the same genome.

## Reference documentation
- [STECFinder GitHub Repository](./references/github_com_LanLab_STECFinder.md)
- [Bioconda STECFinder Package](./references/anaconda_org_channels_bioconda_packages_stecfinder_overview.md)