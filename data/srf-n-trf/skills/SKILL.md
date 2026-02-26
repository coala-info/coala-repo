---
name: srf-n-trf
description: srf-n-trf refines and filters tandem repeat data by processing srf and trf outputs into standard BED9 formats. Use when user asks to extract monomers with specific periodicities, filter motifs based on monomer content, or define larger genomic regions of contiguous repeats.
homepage: https://github.com/koisland/srf-n-trf
---


# srf-n-trf

## Overview
srf-n-trf is a specialized utility designed to refine and filter tandem repeat data. It acts as a post-processing bridge for srf and trf outputs, allowing researchers to extract genomic regions that match specific biological criteria, such as monomer length and motif coverage. By converting complex PAF and TSV data into standard BED9 formats, it facilitates the identification of higher-order repeats (HORs) and specific satellite families in telomere-to-telomere assemblies.

## Command Line Usage

### 1. Extracting Monomers
Use the `monomers` subcommand to identify regions where trf monomers align with specific periodicities within a PAF file's CIGAR string.

```bash
srf-n-trf monomers \
  -p results/srf.paf \
  -m results/trf_monomers.tsv \
  -s 170 340 \
  -d 0.02 \
  -c 0.8
```
*   **-s**: Target periodicities (e.g., 170 for alpha-satellites).
*   **-d**: Length difference tolerance (0.02 = 2%).
*   **-c**: Minimum coverage (0.8 = 80%) of a motif that a monomer must cover.

### 2. Filtering Motifs
Use the `motifs` subcommand to search for srf motifs that contain monomers matching your target periodicity.

```bash
srf-n-trf motifs \
  -f results/srf.fa \
  -m results/trf_monomers.tsv \
  -s 170 340 \
  -d 0.02
```

### 3. Defining Genomic Regions
Use the `regions` subcommand to merge filtered BED outputs into larger contiguous blocks, filtering by total region length and monomer content.

```bash
srf-n-trf regions \
  -b extract.bed \
  -d 100000 \
  -m 30000 \
  -s 170 340 \
  --diff 0.02
```
*   **-d**: Merge distance (e.g., 100kbp).
*   **-m**: Minimum total region size to retain (e.g., 30kbp).

## Best Practices and Tips
*   **T2T Workflow**: This tool is designed to work seamlessly with the `Snakemake-srf` pipeline. Ensure your input files follow the `results/{sample}/{contig}/` structure for easiest integration.
*   **Output Format**: The `monomers` command generates a BED9 file. The "name" column (column 4) contains comma-delimited overlapping monomers. A period (`.`) in this column indicates a motif match that lacked corresponding trf output.
*   **Periodicity Precision**: When targeting alpha-satellites, using `-s 170 340` with a low `-d` (0.02) is the standard approach for high-stringency filtering.
*   **Gzip Support**: Recent versions support gzipped input files, allowing you to process compressed pipeline outputs directly.

## Reference documentation
- [GitHub Repository - koisland/srf-n-trf](./references/github_com_koisland_srf-n-trf.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_srf-n-trf_overview.md)