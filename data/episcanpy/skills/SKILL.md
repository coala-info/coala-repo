---
name: episcanpy
description: episcanpy is a Python framework for analyzing single-cell epigenomic data such as scATAC-seq and scBS-seq within the Scanpy ecosystem. Use when user asks to build count matrices from fragment files, calculate TSS enrichment, estimate gene activity, annotate peaks, or perform motif enrichment and footprinting analysis.
homepage: http://github.com/colomemaria/epiScanpy
---


# episcanpy

## Overview
episcanpy is a specialized Python framework designed to extend the Scanpy ecosystem into the realm of single-cell epigenomics. It provides the necessary infrastructure to handle data types like single-cell open chromatin (scATAC-seq) and single-cell DNA methylation (scBS-seq). Because epigenomic data is typically defined by genomic coordinates rather than predefined gene sets, this tool focuses on building feature matrices from fragments, performing epigenomic-specific quality control, and linking regulatory elements to gene functions.

## Core Workflow and Best Practices

### 1. Matrix Construction
Epigenomic analysis often begins with genomic coordinates (BED files) or fragment files rather than a ready-made count matrix.
- **ATAC-seq**: Use `epi.ct.bld_atac_mtx` to generate a count matrix from peak files and fragment files.
- **Methylation**: Use `epi.ct.bld_met_mtx` to construct methylation level matrices.
- **Custom Features**: Use `epi.ct.bld_mtx_bed` to build matrices based on custom genomic windows or specific regions of interest.

### 2. Quality Control (QC)
Standard transcriptomic QC metrics (like mitochondrial percentage) are less relevant in epigenomics.
- **TSS Enrichment**: Use `epi.pp.tss_enrichment` to calculate the signal-to-noise ratio at Transcription Start Sites. This is a primary metric for scATAC-seq library quality.
- **Filtering**: Apply `epi.pp.set_filter` to remove cells with low accessibility or features that are too rare to be informative.
- **Visualization**: Use `epi.pl.show_filters` to determine appropriate thresholds for cell and feature pruning.

### 3. Preprocessing and Dimensionality Reduction
- **PCA**: Execute `epi.pp.pca(adata)` for dimensionality reduction. Ensure that parameters are adjusted for the high sparsity typical of epigenomic data.
- **Binarization**: For many scATAC-seq workflows, it is common practice to binarize the matrix (treating any accessibility as 1) to reduce noise from PCR bias.

### 4. Functional Analysis
- **Gene Activity**: Use `epi.tl.geneactivity` to estimate gene expression potential by aggregating accessibility signals within gene bodies and promoter regions. This requires a GTF annotation file.
- **Peak Annotation**: Use `epi.tl.annotate_peaks` to assign genomic features (e.g., promoter, distal, intronic) to your peaks.
- **Motif Enrichment**: Identify transcription factor binding sites using `epi.tl.motif_enrichment`. This helps identify the regulatory drivers of specific cell clusters.
- **Footprinting**: Use `epi.pl.plot_footprints` or `epi.pl.plot_footprints_compact` to visualize the high-resolution Tn5 insertion patterns that indicate physical TF binding.

## Expert Tips
- **AnnData Compatibility**: Since episcanpy uses the `AnnData` format, you can and should use standard `scanpy` functions (`sc.tl.leiden`, `sc.pl.umap`, `sc.tl.rank_genes_groups`) for clustering and visualization once the epigenomic-specific preprocessing is complete.
- **Memory Efficiency**: Epigenomic data is extremely sparse. Ensure your environment has sufficient RAM when building matrices, and always verify that the data is stored in a sparse format (CSR) within the AnnData object.
- **Chromosome Naming**: Always verify that your GTF file and your fragment/peak files use the same chromosome naming convention (e.g., both using "chr1" or both using "1") before running `geneactivity` or `annotate_peaks`.

## Reference documentation
- [EpiScanpy – Epigenomics single cell analysis in python](./references/github_com_colomemaria_epiScanpy.md)
- [episcanpy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_episcanpy_overview.md)