---
name: kb-python
description: kb-python processes raw single-cell RNA-seq FASTQ files into gene or feature count matrices using the kallisto and bustools suite. Use when user asks to build a pseudoalignment index, quantify single-cell or single-nucleus reads, or perform feature barcoding workflows like CITE-seq.
homepage: https://github.com/pachterlab/kb_python
---


# kb-python

## Overview
The `kb-python` skill provides a streamlined interface for the kallisto | bustools suite, transforming raw FASTQ files into analysis-ready count matrices. It simplifies complex single-cell preprocessing by wrapping multiple steps—index generation, pseudoalignment, and UMI bus-file processing—into high-level commands. Use this skill to efficiently handle standard scRNA-seq, single-nucleus RNA-seq, or feature barcoding experiments with minimal computational overhead.

## Installation and Setup
Install the package via pip or conda:
```bash
pip install kb-python
# OR
conda install -c bioconda kb-python
```
The package includes pre-compiled `kallisto` and `bustools` binaries, so no external dependencies are required.

## Core CLI Patterns

### 1. Building a Reference (`kb ref`)
Before quantification, you must build a pseudoalignment index.
*   **From local files**: Requires a genome FASTA and a GTF annotation.
    ```bash
    kb ref -i index.idx -g t2g.txt -f1 transcriptome.fa genome.fa.gz annotation.gtf.gz
    ```
*   **Download pre-built**: Use the `-d` flag for common species (e.g., human, mouse).
    ```bash
    kb ref -d human -i index.idx -g t2g.txt
    ```

### 2. Quantifying Reads (`kb count`)
Generate count matrices from FASTQ files.
*   **Standard 10x Genomics (v3)**:
    ```bash
    kb count -i index.idx -g t2g.txt -x 10xv3 -o out/ read1.fastq.gz read2.fastq.gz
    ```
*   **Generating H5AD files**: Add the `--h5ad` flag to produce a file ready for Scanpy/AnnData.
    ```bash
    kb count -i index.idx -g t2g.txt -x 10xv3 -o out/ --h5ad R1.fastq.gz R2.fastq.gz
    ```

### 3. Feature Barcoding / KITE Workflow
For CITE-seq or CRISPR screening where you align against a small set of known sequences:
1.  **Build KITE index**: Use a tab-delimited `features.txt` (barcode<tab>feature_name).
    ```bash
    kb ref -i index.idx -g f2g.txt -f1 features.fa --workflow kite features.txt
    ```
2.  **Count features**:
    ```bash
    kb count -i index.idx -g f2g.txt -x 10xv2 -o out/ --workflow kite R1.fastq.gz R2.fastq.gz
    ```

## Expert Tips and Best Practices
*   **Check Supported Technologies**: Run `kb --list` to see all supported chemistry strings (e.g., `10xv2`, `10xv3`, `dropseq`, `celseq`, `smartseq`).
*   **Memory Management**: For large datasets, `kb-python` is designed for constant-memory usage, but ensure your output directory has sufficient space for the intermediate `.bus` files.
*   **Dry Runs**: Use `--dry-run` to inspect the underlying `kallisto` and `bustools` commands without executing them.
*   **Reference Tools**: Combine with `gget` to quickly find the latest Ensembl FTP links for genome and GTF files.
*   **Version Info**: Use `kb info` to verify the versions of the wrapped binaries if you encounter unexpected behavior.

## Reference documentation
- [kb-python GitHub Repository](./references/github_com_pachterlab_kb_python.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_kb-python_overview.md)