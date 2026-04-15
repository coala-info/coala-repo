---
name: iobrpy
description: iobrpy is a command-line toolkit for processing bulk RNA-seq data to characterize the tumor microenvironment and calculate immune infiltration scores. Use when user asks to process raw FASTQ files, perform immune deconvolution, calculate pathway activity scores, or convert mouse gene symbols to human equivalents.
homepage: https://github.com/IOBR/IOBRpy
metadata:
  docker_image: "quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0"
---

# iobrpy

## Overview
iobrpy is a comprehensive command-line toolkit designed for end-to-end processing of bulk RNA-seq data with a specific focus on immuno-oncology. It streamlines the transition from raw sequencing files (FASTQ) to high-level biological insights like immune cell infiltration fractions and pathway activity scores. By integrating industry-standard tools like Salmon, STAR, and fastp with specialized deconvolution algorithms (e.g., CIBERSORT, EPIC, quanTIseq), it provides a unified workflow for researchers to characterize the tumor microenvironment.

## Core Workflows

### End-to-End Pipeline (`runall`)
The `runall` command is the primary entry point for processing raw data. It automatically handles QC, quantification, matrix assembly, and TME profiling.

*   **Salmon Mode (Alignment-free):** Faster, recommended for standard quantification.
    ```bash
    iobrpy runall --mode salmon --fastq /path/to/fastq --index /path/to/salmon_index --outdir ./results --project MyProject --threads 8
    ```
*   **STAR Mode (Alignment-based):** Use when genomic coordinates or BAM files are required.
    ```bash
    iobrpy runall --mode star --fastq /path/to/fastq --index /path/to/star_index --outdir ./results --project MyProject --threads 8
    ```

### TME Profiling from Matrices (`tme_profile`)
If you already have a Gene Expression Omnibus (GEO) matrix or a processed TPM matrix (genes × samples), use `tme_profile` to generate immune scores.
```bash
iobrpy tme_profile --input tpm_matrix.csv --outdir ./tme_results --project TME_Analysis
```

## Specialized Modules

### Signature Scoring
Calculate pathway activity using various methods (`pca`, `zscore`, `ssgsea`, or `integration`).
*   **Common Groups:** `hallmark`, `kegg`, `reactome`, `signature_tme`, `go_bp`.
*   **Example:**
    ```bash
    iobrpy calculate_sig_score --input matrix.csv --group hallmark,signature_tme --method ssgsea
    ```

### Immune Deconvolution
Individual methods can be called if the full `tme_profile` is not required:
*   **CIBERSORT:** `iobrpy cibersort --input matrix.csv --perm 100`
*   **EPIC:** `iobrpy epic --input matrix.csv`
*   **ESTIMATE:** `iobrpy estimate --input matrix.csv` (Immune/Stromal/Purity scores)
*   **MCP-counter:** `iobrpy mcpcounter --input matrix.csv`

### Preprocessing & Annotation
*   **Gene Mapping:** Convert mouse symbols to human for cross-species analysis.
    ```bash
    iobrpy mouse2human_eset --input mouse_matrix.csv --mode matrix
    ```
*   **Normalization:** Apply log2(x+1) transformation.
    ```bash
    iobrpy log2_eset --input tpm_matrix.csv
    ```

## Expert Tips & Best Practices
*   **Input Orientation:** Ensure your expression matrix is oriented as **genes (rows) × samples (columns)**.
*   **File Extensions:** iobrpy infers delimiters from extensions. Use `.csv` for comma-separated and `.tsv` or `.txt` for tab-separated files.
*   **FASTQ Naming:** By default, the tool expects `*_1.fastq.gz` and `*_2.fastq.gz`. If your files use a different pattern (e.g., `_R1`), specify it using the `--suffix1` and `--suffix2` flags.
*   **Resource Management:** Use the `--batch_size` parameter in `runall` to control how many samples are processed in parallel if memory is a constraint.
*   **Clustering:** Use `tme_cluster` for unsupervised discovery of TME phenotypes. It uses the KL index to automatically determine the optimal number of clusters (k).



## Subcommands

| Command | Description |
|---------|-------------|
| iobrpy anno_eset | Annotates an expression set with gene/probe information. |
| iobrpy batch_salmon | Run Salmon in batch mode on multiple samples. |
| iobrpy batch_star_count | Run STAR aligner in batches for multiple samples. |
| iobrpy bayesprism | BayesPrism is a tool for deconvolution of bulk RNA-seq data using single-cell RNA-seq data as a reference. |
| iobrpy calculate_sig_score | Calculate signature scores from an expression matrix. |
| iobrpy cibersort | CIBERSORT analysis tool |
| iobrpy deside | Predicts cell fractions from gene expression data using a DeSide model. |
| iobrpy epic | EPIC deconvolution tool |
| iobrpy estimate | Estimate gene expression levels from raw count matrices. |
| iobrpy fastq_qc | Perform quality control on FASTQ files using fastp. |
| iobrpy log2_eset | Applies log2(x+1) transformation to an expression set matrix. |
| iobrpy mcpcounter | MCPcounter is a tool for estimating the abundance of immune cells in transcriptomic data. |
| iobrpy nmf | Non-negative Matrix Factorization (NMF) for dimensionality reduction and deconvolution. |
| iobrpy quantiseq | Performs deconvolution of immune cell proportions from gene expression data. |
| iobrpy runall | Run iobrpy in different modes. |
| iobrpy tme_cluster | Perform TME clustering on input data. |
| iobrpy tme_profile | TPM matrix (genes x samples). CSV/TSV/.gz supported. |
| iobrpy_count2tpm | Convert gene counts to TPM (Transcripts Per Million) |
| iobrpy_merge_salmon | Merge Salmon quant.sf files from multiple runs. |
| iobrpy_merge_star_count | Merge STAR counts from multiple samples. |
| iobrpy_mouse2human_eset | Convert mouse gene symbols to human gene symbols. |
| iobrpy_prepare_salmon | Prepare a TPM matrix from Salmon output. |

## Reference documentation
- [IOBRpy GitHub README](./references/github_com_IOBR_IOBRpy_blob_main_README.md)
- [IOBRpy Environment Configuration](./references/github_com_IOBR_IOBRpy_blob_main_environment.yml.md)