---
name: cellsnp-lite
description: cellsnp-lite genotypes single cells by generating allele counts from BAM/SAM files for bi-allelic SNPs. Use when user asks to genotype known SNPs, perform de novo SNP discovery, or generate allele matrices for donor deconvolution and doublet detection.
homepage: https://github.com/single-cell-genetics/cellSNP
metadata:
  docker_image: "quay.io/biocontainers/cellsnp-lite:1.2.3--ha0c3a46_6"
---

# cellsnp-lite

## Overview
`cellsnp-lite` is a high-performance C implementation of the `cellSNP` tool, optimized for genotyping single cells at scale. It processes BAM/SAM files to generate allele counts (AD and DP matrices) for bi-allelic SNPs. The tool is specifically designed to handle the unique requirements of single-cell data, such as cell barcodes (CB) and Unique Molecular Identifiers (UMI). It is the standard preprocessing step for donor deconvolution workflows, providing the necessary input for tools like `vireo` to assign cells to donors and detect doublets without requiring prior reference genotypes.

## Core Usage Modes

### Mode 1: Genotyping Known SNPs (Recommended for Human)
Use this mode when you have a list of common SNPs (e.g., from 1000 Genomes or gnomAD). This is the most efficient method for donor deconvolution in human samples.
- **Required**: Single BAM file (`-s`), Barcode list (`-b`), and VCF of common SNPs (`-R`).
- **Pattern**:
  ```bash
  cellsnp-lite -s $BAM -b $BARCODE -O $OUT_DIR -R $REGION_VCF -p 20 --minMAF 0.1 --minCOUNT 20
  ```

### Mode 2: De Novo SNP Discovery
Use this mode for species without a comprehensive common SNP database or when looking for expressed variants across the whole genome/chromosome.
- **Required**: Single BAM file (`-s`) and Barcode list (`-b`). Do NOT use `-R`.
- **Pattern**:
  ```bash
  cellsnp-lite -s $BAM -b $BARCODE -O $OUT_DIR -p 22 --chrom 1,2,MT --minMAF 0.1 --minCOUNT 100
  ```
- **Note**: Higher `--minCOUNT` (e.g., 100) is recommended to reduce false positives and save memory.

### Mode 3: Bulk or Smart-seq (Multiple BAMs)
Use this mode for bulk RNA-seq or plate-based single-cell methods where each cell/sample has its own BAM file.
- **Required**: List of BAM files (`-s` or `-S`) and VCF of SNPs (`-R`). Do NOT use `-b`.
- **Pattern**:
  ```bash
  cellsnp-lite -s $BAM1,$BAM2,$BAM3 -I sample1,sample2,sample3 -o $OUT_FILE -R $REGION_VCF --UMItag None
  ```

## Expert Tips and Best Practices

### Filtering for Donor Deconvolution
To ensure high-quality input for downstream tools like `vireo`, apply stringent filters:
- **Minor Allele Frequency (`--minMAF`)**: Set to `0.1` to exclude rare variants or sequencing errors.
- **Minimum UMI Count (`--minCOUNT`)**: Use `20` for Mode 1 and `100` for Mode 2.

### Handling PCR Duplicates
- **scRNA-seq (10x)**: `cellsnp-lite` defaults to a large `--maxFLAG` (4096) when UMIs are used. This is intentional because CellRanger often flags reads sharing CB/UMI pairs as duplicates, which can lead to significant data loss if filtered out.
- **Bulk/Smart-seq**: If UMIs are not present, ensure you set `--UMItag None`.

### Performance Optimization
- **Multi-threading**: Always use the `-p` parameter to specify the number of cores.
- **Memory Management**: `cellsnp-lite` is significantly more memory-efficient than the original Python version. If memory is still an issue in Mode 2, restrict the analysis to specific chromosomes using `--chrom`.

### Common CLI Arguments
- `-s / -S`: Input BAM file(s). Use `-s` for comma-separated strings or `-S` for a text file listing BAM paths.
- `-b`: File containing valid cell barcodes (e.g., `barcodes.tsv` from CellRanger).
- `-O`: Output directory (for Mode 1 and 2).
- `-o`: Output file (for Mode 3).
- `-R`: Reference VCF file containing SNP positions.
- `--UMItag`: Tag for UMI (default `UB`). Set to `None` if UMIs are not used.
- `--cellTAG`: Tag for cell barcode (default `CB`).

## Reference documentation
- [cellSNP GitHub Repository](./references/github_com_single-cell-genetics_cellSNP.md)
- [cellsnp-lite Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cellsnp-lite_overview.md)