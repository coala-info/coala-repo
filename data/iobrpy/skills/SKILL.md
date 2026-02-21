---
name: iobrpy
description: `iobrpy` is a comprehensive command-line toolkit designed to transform raw sequencing data into deep insights regarding the tumor microenvironment.
homepage: https://github.com/IOBR/IOBRpy
---

# iobrpy

## Overview

`iobrpy` is a comprehensive command-line toolkit designed to transform raw sequencing data into deep insights regarding the tumor microenvironment. It automates the integration of disparate tools—from raw FASTQ processing to advanced cellular deconvolution and clustering—into a standardized workflow. Use this skill to execute full pipelines or modular tasks such as gene annotation, mouse-to-human mapping, and pathway-level signature scoring.

## Core Workflows

### End-to-End Pipeline (`runall`)
Use `runall` to execute the entire pipeline from FASTQ files to ligand-receptor scoring. This command automatically creates a standardized directory structure (01-qc to 06-LR_cal).

**Salmon Mode:**
```bash
iobrpy runall \
    --mode salmon \
    --outdir "./results" \
    --fastq "./data/fastq" \
    --threads 8 \
    --index "/path/to/salmon_index" \
    --project "TME_Study"
```

**STAR Mode:**
```bash
iobrpy runall \
    --mode star \
    --outdir "./results" \
    --fastq "./data/fastq" \
    --threads 8 \
    --project "TME_Study"
```

### TME Profiling from TPM (`tme_profile`)
Use this when you already have a normalized expression matrix (TPM). It performs signature scoring, runs six deconvolution methods, and computes ligand-receptor scores in one step.

```bash
iobrpy tme_profile \
    --input "tpm_matrix.csv" \
    --outdir "./tme_results" \
    --threads 4
```

## Modular Analysis Patterns

### Quality Control and Quantification
*   **FASTQ QC**: Run `iobrpy fastq_qc --input ./fastq --threads 8` to perform trimming via `fastp` and generate MultiQC reports.
*   **Merge Salmon**: Use `iobrpy merge_salmon --input ./salmon_output` to recursively collect `quant.sf` files into TPM and NumReads matrices.
*   **Count to TPM**: Convert STAR counts using `iobrpy count2tpm --input counts.csv --source Ensembl`.

### Expression Matrix Preprocessing
*   **Annotation**: Harmonize matrices using `iobrpy anno_eset --input matrix.csv --symbol_col "gene_id"`.
*   **Species Conversion**: Map mouse symbols to human using `iobrpy mouse2human_eset --input mouse_matrix.csv`.
*   **Normalization**: Apply log-transformation with `iobrpy log2_eset --input tpm.csv`.

### Signature Scoring and Deconvolution
*   **Signature Scoring**: Calculate scores for specific groups (e.g., `hallmark`, `kegg`, `go_bp`) using `calculate_sig_score`.
    ```bash
    iobrpy calculate_sig_score --input tpm.csv --method ssgsea --signatures hallmark,kegg
    ```
*   **Immune Deconvolution**: Run specific algorithms individually if needed:
    *   `iobrpy cibersort --input tpm.csv --perm 100`
    *   `iobrpy epic --input tpm.csv`
    *   `iobrpy mcpcounter --input tpm.csv`
    *   `iobrpy estimate --input tpm.csv`

## Expert Tips and Best Practices

*   **Matrix Orientation**: Ensure input expression matrices are oriented as **genes (rows) × samples (columns)**.
*   **File Formats**: Use `.csv`, `.tsv`, or `.txt` extensions; the tool automatically infers the delimiter based on the extension.
*   **Resource Management**: For `runall` and `batch_salmon`, use the `--batch_size` parameter to control memory consumption during parallel processing.
*   **Resume Capability**: Most preprocessing and quantification commands are resume-friendly; they will skip already processed samples if the output directory remains the same.
*   **Signature Groups**: When using `calculate_sig_score`, you can pass `all` to the `--signatures` flag to merge all available signature collections.

## Reference documentation
- [IOBRpy GitHub Repository](./references/github_com_IOBR_IOBRpy.md)
- [IOBRpy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_iobrpy_overview.md)