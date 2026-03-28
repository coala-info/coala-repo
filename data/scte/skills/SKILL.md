---
name: scte
description: scTE quantifies the expression of transposable elements and genes in single-cell datasets using a hierarchical classification strategy. Use when user asks to build genome indices for repetitive elements, quantify transposable element expression from BAM files, or integrate TE counts with single-cell gene expression data.
homepage: https://github.com/JiekaiLab/scTE
---


# scte

## Overview
scTE is a computational pipeline designed to quantify the expression of repetitive elements, specifically Transposable Elements (TEs), alongside standard gene expression in single-cell datasets. It addresses the challenge of multi-mapping reads in repetitive regions by using a hierarchical classification strategy. By default, scTE prioritizes gene exons, ensuring that TEs overlapping with known gene features do not lead to double-counting unless specific modes are enabled. It is compatible with standard single-cell alignment outputs from tools like Cell Ranger and STARsolo.

## Command Line Usage

### 1. Building Genome Indices
Before quantification, you must build a genome index. scTE provides shortcuts for common model organisms or allows for custom annotations.

**Standard Organisms:**
Use the `-g` flag to automatically download and build indices for supported genomes (mm10, hg38, panTro6, macFas5, dm6, danRer11, xenTro9).
```bash
scTE_build -g hg38 -o hg38_index
```

**Custom Annotations:**
If using a custom genome or specific versions of TEs/Genes, provide the BED and GTF files manually.
```bash
scTE_build -te TEs.bed -gene Genes.gtf -o custom_index -m exclusive
```

**Index Modes (`-m`):**
*   `exclusive` (Default): Reads are assigned to genes first; TEs in exons/UTRs contribute only to the gene score.
*   `inclusive`: Reads are assigned to both TEs and genes if they overlap.
*   `nointron`: Removes TEs located within gene introns from the analysis.

### 2. Quantifying Expression
The main `scTE` command processes BAM/SAM files. It requires specific tags for Cell Barcodes (CB) and UMIs depending on the upstream aligner.

**For STARsolo Aligned Data:**
Typically uses `CR` for Cell Barcodes and `UR` for UMIs.
```bash
scTE -i input.bam -o output_prefix -x hg38.exclusive.idx --hdf5 True -CB CR -UMI UR
```

**For Cell Ranger Aligned Data:**
Typically uses `CB` for Cell Barcodes and `UB` for UMIs.
```bash
scTE -i input.bam -o output_prefix -x mm10.exclusive.idx --hdf5 True -CB CB -UMI UB
```

### 3. Key Parameters
*   `-p`: Number of threads. **Note:** scTE requires approximately 10GB of RAM per thread for human/mouse genomes.
*   `--min_genes`: Minimum number of genes required to keep a cell.
*   `--hdf5`: Set to `True` to output in HDF5 format (compatible with AnnData/Scanpy).

## Best Practices and Expert Tips
*   **Input Quality:** Always use the **unfiltered** alignment BAM file (e.g., `possorted_genome_bam.bam` from Cell Ranger) rather than the filtered version. This ensures that reads mapping to TEs—which might be filtered out by standard gene-centric pipelines—are preserved for scTE to quantify.
*   **Memory Management:** Monitor your system resources closely. If running on a standard workstation with 32GB RAM, limit the threads (`-p`) to 2 or 3 when working with human data to avoid OOM (Out of Memory) errors.
*   **Barcode Verification:** If you are unsure which tags your BAM file uses, run `samtools view your_file.bam | head -n 1` and look for the `CB:Z:` or `CR:Z:` tags to identify the correct `-CB` and `-UMI` arguments.
*   **ATAC-seq Support:** The package includes `scTEATAC` and `scTEATAC_build` for processing single-cell ATAC-seq data, following a similar logic for chromatin accessibility in repetitive regions.



## Subcommands

| Command | Description |
|---------|-------------|
| scTE | hahaha... |
| scTE_build | Build genome annotation index for scTE |

## Reference documentation
- [scTE GitHub README](./references/github_com_JiekaiLab_scTE_blob_master_README.md)
- [scTE Setup and Scripts](./references/github_com_JiekaiLab_scTE_blob_master_setup.py.md)
- [Test Script Examples](./references/github_com_JiekaiLab_scTE_blob_master_test.sh.md)