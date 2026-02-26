---
name: snapatac2
description: SnapATAC2 is a high-performance framework for analyzing large-scale single-cell omics data with a focus on memory efficiency and speed. Use when user asks to convert BAM files to fragments, generate count matrices, perform matrix-free dimension reduction, or integrate multi-omics datasets.
homepage: https://github.com/kaizhang/SnapATAC2
---


# snapatac2

## Overview
SnapATAC2 is a high-performance Python/Rust framework designed for the analysis of single-cell omics data, capable of scaling to over 10 million cells. This skill assists in navigating its end-to-end pipeline, which includes efficient BAM-to-fragment conversion, matrix-free dimension reduction, and seamless integration with the scverse ecosystem (e.g., Scanpy and AnnData). It is particularly useful for researchers needing to process large-scale epigenomic datasets where memory efficiency and speed are critical.

## Core Workflows and Best Practices

### Preprocessing and Matrix Generation
*   **Fragment File Creation**: Use SnapATAC2's preprocessing tools to convert BAM files into fragment files. This is the foundation for all downstream analysis.
*   **Count Matrix Construction**: Generate cell-by-bin or cell-by-peak matrices. For initial discovery, 500bp or 1kb bins are standard.
*   **Quality Control**: Filter cells based on TSS enrichment scores and the number of unique fragments. SnapATAC2 provides optimized functions to calculate these metrics rapidly.

### Dimension Reduction and Clustering
*   **Spectral Embedding**: Utilize the matrix-free spectral embedding algorithm. This is the preferred method for large datasets as it avoids the memory overhead of storing large similarity matrices.
*   **Clustering**: Perform clustering on the embedding space. SnapATAC2 integrates with standard community detection algorithms (like Leiden) to identify cell populations.

### Multi-omics Integration
*   **Co-embedding**: When working with multi-omics data (e.g., paired ATAC and RNA), use the scalable co-embedding features to project different modalities into a shared latent space.
*   **AnnData Compatibility**: Leverage the "fully backed" AnnData implementation. This allows you to work with datasets that are larger than the available RAM by keeping the data on disk and loading only what is necessary.

### Peak Calling and Regulatory Analysis
*   **Peak Calling**: Identify accessible chromatin regions across clusters.
*   **Differential Analysis**: Compare accessibility between different cell types or conditions.
*   **Motif and Network Analysis**: Use the downstream modules to identify enriched transcription factor motifs and construct gene regulatory networks.

## Expert Tips
*   **Memory Management**: For datasets exceeding 1 million cells, always ensure you are using the "backed" mode for AnnData objects to prevent OOM (Out of Memory) errors.
*   **Speed Optimization**: SnapATAC2's core is implemented in Rust; ensure your environment has appropriate SIMD support enabled for maximum performance during preprocessing.
*   **Integration with Scanpy**: Since SnapATAC2 objects are AnnData-compatible, you can use `scanpy.pl` functions for visualization (UMAP, t-SNE) once the embedding is computed.

## Reference documentation
- [SnapATAC2 GitHub Repository](./references/github_com_scverse_SnapATAC2.md)