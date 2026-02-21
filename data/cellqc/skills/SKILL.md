---
name: cellqc
description: The `cellqc` skill provides a streamlined workflow for the systematic quality control of single-cell RNA-Seq data.
homepage: https://github.com/lijinbio/cellqc
---

# cellqc

## Overview
The `cellqc` skill provides a streamlined workflow for the systematic quality control of single-cell RNA-Seq data. It automates the transition from raw Cell Ranger outputs to analysis-ready feature count matrices by integrating several specialized tools: Dropkick for empty droplet filtering, SoupX for ambient RNA removal, and DoubletFinder for doublet detection. It also supports optional cell-type annotation via scPred. This skill is essential for ensuring data integrity before downstream analysis in scRNA-seq pipelines.

## Installation and Setup
Install `cellqc` via conda/mamba to manage the complex R and Python dependencies:
```bash
mamba create -y -n cellqc python=3.10 cellqc r-seurat=4 r-seuratobject=4 r-matrix=1.6.1 dropkick r-hdf5r hdf5 r-leidenbase libxml2 r-xml r-xml2 zlib bioconductor-rsamtools bioconductor-genomicfeatures bioconductor-rtracklayer 'pandas<2'
conda activate cellqc
```
Note: Seurat v4 is required as v5 is currently unsupported by SeuratDisk.

## Command Line Usage
The primary interface is the `cellqc` command. It requires a sample file and can take an optional configuration file.

### Basic Execution
```bash
cellqc -i samples.txt -o output_directory
```

### Input Sample File (`samples.txt`)
The input must be a tab-delimited file with the following headers:
- `sample`: Unique ID for each sample.
- `cellranger`: Path to the Cell Ranger output directory (containing `outs/raw_feature_bc_matrix`).
- `nreaction` (optional): Number of reactions in the library; used to infer expected doublet rates. Defaults to 1 if omitted.

### Key CLI Arguments
- `-i, --input`: Path to the tab-delimited sample information file.
- `-o, --outdir`: Directory where results will be stored.
- `-c, --config`: Path to a configuration file (YAML format) to override default parameters.
- `-t, --numthreads`: Number of threads for the Snakemake workflow.
- `-D, --define`: Override specific configuration parameters directly from the CLI.

## Workflow Components and Best Practices

### 1. Empty Droplet Removal (Dropkick)
- **Purpose**: Filters out droplets that do not contain real cells.
- **Tip**: Dropkick can be memory-intensive. It is recommended to limit this step to a single thread (`dropkick.numthreads: 1`) to avoid OOM (Out of Memory) errors.
- **Fallback**: If Dropkick predicts too many false negatives (common in poor quality libraries), you can skip it to use standard Cell Ranger `EmptyDrops` estimates.

### 2. Ambient RNA Correction (SoupX)
- **Purpose**: Subtracts background mRNA "soup" often found in droplets.
- **Output**: Produces a purified transcriptome measurement.

### 3. Doublet Detection (DoubletFinder)
- **Purpose**: Identifies droplets containing two or more cells.
- **Optimization**: If you don't know the optimal neighbor size, set `findpK: true` to estimate it via mean-variance bimodality coefficients.

### 4. Cell Type Annotation (scPred)
- **Requirement**: Requires a pre-trained reference model (RDS file).
- **Usage**: Best used when a high-quality, annotated reference exists for your specific tissue type.

## Output Structure
The pipeline generates a `result/` subdirectory containing:
- `*.h5seurat` and `*.h5ad`: Processed count matrices including QC metrics (e.g., `pANN` for doublet scores) and predicted cell types.
- `report.html`: A comprehensive summary of QC metrics across all samples.
- `postproc/*.h5ad`: Cleaned files with standardized barcode prefixes and unique variable names.

## Reference documentation
- [cellqc GitHub Repository](./references/github_com_lijinbio_cellqc.md)
- [cellqc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cellqc_overview.md)