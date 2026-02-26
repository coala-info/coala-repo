---
name: irescue
description: IRescue quantifies transposable element expression in single-cell transcriptomics data by redistributing multi-mapping reads using an EM algorithm. Use when user asks to quantify TE subfamilies from BAM files, generate TE count matrices for Seurat or Scanpy, or handle multi-mapping reads in repetitive genomic regions.
homepage: https://github.com/bodegalab/irescue
---


# irescue

## Overview
IRescue (Interspersed Repeats single-cell quantifier) is a bioinformatics tool designed to accurately quantify the expression of transposable element subfamilies in single-cell transcriptomics. It addresses the inherent difficulty of mapping reads to repetitive genomic regions by employing an EM algorithm to redistribute multi-mapping reads. Use this skill to generate TE count matrices from aligned BAM files that are compatible with downstream analysis suites like Seurat and Scanpy.

## Installation and Setup
The recommended installation method is via Conda to ensure all dependencies (samtools, bedtools, gawk) are correctly configured.

```bash
conda create -n irescue -c conda-forge -c bioconda irescue
conda activate irescue
```

## Core CLI Usage

### Basic Quantification
For standard 10X Genomics-like libraries with cell barcodes (CB) and UMIs (UR):
```bash
irescue -b genome_alignments.bam -g hg38
```

### UMI-less Libraries (e.g., SMART-seq)
When working with libraries that do not use UMIs, use the `--no-umi` flag. Note that cell barcodes may be stored in the `RG` tag instead of `CB`.
```bash
irescue -b genome_alignments.bam -g hg38 --no-umi --cb-tag RG
```

### Performance Optimization
To significantly reduce runtime and memory usage, provide a whitelist of validated cell barcodes (e.g., from your gene expression analysis) and utilize multiple threads.
```bash
irescue -b input.bam -g hg38 -w barcodes.tsv -p 8
```

## BAM Preparation Best Practices
IRescue relies on the presence of secondary alignments to properly redistribute multi-mapping reads. When aligning with STARsolo, use the following parameters:
- `--outFilterMultimapNmax 100`
- `--winAnchorMultimapNmax 100`
- Ensure SAM attributes include: `NH HI AS nM NM MD jM jI XS MC ch cN CR CY UR UY GX GN CB UB sM sS sQ`

## Advanced Options
- **Custom Annotations**: Provide your own repeat mask in BED format (minimum 4 columns, where the 4th is the feature name).
  ```bash
  irescue -b input.bam -g hg38 -r custom_TEs.bed
```
- **Strandedness**: If your library is stranded, ensure you use the appropriate orientation flags if supported by your version to avoid antisense noise.
- **Debugging**: Use `-vv` for verbose logging and `--keeptmp` to inspect intermediate files in the `tmp/` directory.

## Downstream Integration (Seurat)
IRescue outputs a sparse matrix in MTX format. To integrate this into an existing Seurat object:

```R
# Load TE data
te.data <- Seurat::Read10X('./irescue_out/counts/', gene.column = 1, cell.column = 1)
te.assay <- Seurat::CreateAssayObject(te.data)

# Filter for cells present in your gene expression object
te.assay <- subset(te.assay, colnames(te.assay) %in% colnames(seurat_obj))

# Add to Seurat object
seurat_obj[['TE']] <- te.assay
```

## Reference documentation
- [IRescue GitHub Repository](./references/github_com_bodegalab_irescue.md)
- [Bioconda IRescue Overview](./references/anaconda_org_channels_bioconda_packages_irescue_overview.md)