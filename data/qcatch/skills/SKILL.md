---
name: qcatch
description: QCatch provides a quality control pipeline for single-cell quantification data to identify valid cell barcodes and generate interactive metric reports. Use when user asks to perform quality control on single-cell data, model empty droplets, filter quantification files, or generate HTML reports for alevin-fry results.
homepage: https://github.com/COMBINE-lab/QCatch
---


# qcatch

## Overview

QCatch provides a specialized quality control pipeline designed specifically for the output of single-cell quantification tools like alevin-fry and simpleaf. It automates the assessment of data quality by scanning quantification directories, modeling empty droplets to define an "ambient pool," and identifying valid cell barcodes. The primary output is an interactive HTML report that allows for visual inspection of metrics such as mitochondrial content, doublet detection, and library size, alongside optional filtered data files for downstream analysis.

## Installation

QCatch requires Python 3.11+. It is most reliably installed via Conda:

```bash
conda install -c bioconda qcatch
```

Alternatively, use pip: `pip install qcatch`

## Core CLI Usage

### Basic Execution
Provide the path to the quantification results. QCatch automatically detects if the input is a directory or a specific `.h5ad` file.

```bash
qcatch --input path/to/quants --output path/to/qc_results --chemistry 10X_3p_v3
```

### Handling Custom or Non-10X Assays
If the assay is not a standard 10X chemistry (e.g., Drop-seq, sci-RNA-seq3), you must manually specify the partition capacity using `--n_partitions`.

**Expert Tip**: Set this value by rounding the number of detected barcodes up to the next 10% increment of the current order of magnitude.
- 79,000 barcodes -> `--n_partitions 80000`
- 144,000 barcodes -> `--n_partitions 150000`

```bash
qcatch --input path/to/data --n_partitions 100000
```

### Filtering and Saving Results
To generate a filtered version of the quantification file containing only the high-quality cells identified by QCatch:

```bash
qcatch --input path/to/quants.h5ad --save_filtered_h5ad
```

## Best Practices and Tips

### Input Detection Logic
- **Directory Input**: QCatch looks for an existing `quants.h5ad`. If missing, it falls back to processing MTX-based results.
- **In-place Updates**: If the input is a `.h5ad` file and the output path matches the input directory, QCatch modifies the original file by appending filtering results to `adata.obs` (specifically the `is_retained_cells` column).

### Chemistry Specification
The `--chemistry` argument in QCatch refers to the **droplet/well capacity**, not the barcode geometry used in alevin-fry. Supported values include:
- `10X_3p_v2`, `10X_3p_v3`, `10X_3p_v4`
- `10X_3p_LT`, `10X_5p_v3`, `10X_HT`

### Gene Name Mapping
If using `simpleaf` versions older than v0.19.3, the `.h5ad` file may lack gene names. To ensure mitochondrial plots appear in the report, provide a mapping file:
- **Format**: A headerless TSV with two columns: `gene_id` and `gene_name`.
- **Command**: `qcatch --input <path> --gene_id2name_file mapping.tsv`

### Using Pre-defined Cell Lists
If you have already performed cell calling and wish to use a specific list of barcodes, bypass the QCatch cell-calling step:
```bash
qcatch --input <path> --valid_cell_list barcodes.txt
```

## Reference documentation
- [QCatch GitHub Repository](./references/github_com_COMBINE-lab_QCatch.md)
- [QCatch Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_qcatch_overview.md)