---
name: srf-n-trf
description: srf-n-trf identifies and filters satellite DNA monomers and regions by bridging SRF and TRF outputs to isolate specific repeat periodicities. Use when user asks to identify tandem repeat monomers, filter SRF motifs by length, or merge and filter genomic regions based on monomer composition.
homepage: https://github.com/koisland/srf-n-trf
---


# srf-n-trf

## Overview
The `srf-n-trf` tool is a specialized utility designed for satellite DNA analysis in high-quality genome assemblies. It bridges the gap between `srf` (which identifies repetitive motifs) and `trf` (which characterizes tandem repeats) by filtering genomic coordinates for specific periodicities. This is particularly useful for researchers working with centromeric or telomeric regions who need to isolate specific repeat families (e.g., 171bp α-satellites) from complex SRF/TRF outputs.

## Core Workflows

### 1. Identifying Monomers
Use the `monomers` command to find TRF-confirmed monomers within SRF-generated PAF files. This is the primary way to generate high-confidence BED files of satellite repeats.

```bash
srf-n-trf monomers \
  -p srf.paf \
  -m monomers.tsv \
  -s 170 340 42 \
  -d 0.02 \
  -c 0.8
```
*   **-s (Sizes)**: Specify the target periodicities (e.g., 171 for α-satellite).
*   **-d (Difference)**: The allowed length deviation (0.02 = 2%).
*   **-c (Coverage)**: Minimum fraction of the motif that must be covered by the monomer.

### 2. Extracting Motifs
Use the `motifs` command to filter an SRF FASTA file for sequences that match specific monomer lengths.

```bash
srf-n-trf motifs \
  -f srf.fa \
  -m monomers.tsv \
  -s 170 340 \
  -d 0.02
```

### 3. Merging and Filtering Regions
Use the `regions` command to consolidate fragmented hits into larger genomic blocks, which is essential for annotating large satellite arrays.

```bash
srf-n-trf regions \
  -b input.bed \
  -d 100000 \
  -m 30000 \
  -s 170 340 \
  --diff 0.02
```
*   **-d (Distance)**: Merge hits within this distance (e.g., 100kbp).
*   **-m (Min Size)**: Only keep merged regions at least this long (e.g., 30kbp).

## Expert Tips
*   **Input Preparation**: This tool expects outputs from the `Snakemake-srf` pipeline. Ensure you have the `srf.paf` and `monomers.tsv` files ready.
*   **Compressed Files**: The tool natively supports `.gz` compressed inputs for all commands.
*   **Interpreting Output**: In the resulting BED file's name column, a `.` indicates a motif match where TRF did not provide a specific monomer output, while comma-separated values represent overlapping monomers.
*   **Common Periodicities**: 
    *   **α-satellite**: ~170-171 bp
    *   **HSAT-1A**: ~42 bp



## Subcommands

| Command | Description |
|---------|-------------|
| monomers | Parses TRF output to identify tandem repeats within SRF-elongated motifs. |
| srf-n-trf motifs | Fasta file of srf detected motifs |
| srf-n-trf_regions | Generates regions based on TRF output, merging and filtering based on monomer composition and distance. |

## Reference documentation
- [srf-n-trf GitHub README](./references/github_com_koisland_srf-n-trf_blob_main_README.md)