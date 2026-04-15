---
name: scdownstream
description: nf-core/scdownstream processes quantified single-cell RNA-seq data from h5ad, SingleCellExperiment, or CSV inputs to perform quality control, ambient RNA removal, integration, and clustering. Use when performing downstream analysis of single-cell transcriptomics data to generate integrated datasets, cell type annotations, and comprehensive QC reports.
homepage: https://github.com/nf-core/scdownstream
---

# scdownstream

## Overview
nf-core/scdownstream is designed for the downstream analysis of single-cell RNA-seq data that has already been quantified. It addresses the need for a unified workflow to handle quality control, batch effect correction, and data visualization across multiple samples and formats.

The pipeline accepts various input formats including AnnData (h5ad), Seurat/SingleCellExperiment (RDS), and raw CSV matrices. It produces integrated datasets in h5ad and SingleCellExperiment formats, along with detailed MultiQC reports covering per-sample and aggregated quality metrics.

## Data preparation
Input data is defined in a CSV samplesheet. The pipeline requires at least a `sample` name and a path to either a `filtered` or `unfiltered` matrix file.

```csv
sample,unfiltered,batch_col
sample1,raw_counts.h5ad,batch1
sample2,data.rds,batch2
sample3,matrix.csv,batch1
```

- **File Formats**: Supports `.h5ad`, `.h5`, `.rds` (Seurat or SingleCellExperiment), and `.csv` (genes as columns, cells as rows).
- **Metadata**: Optional columns in the samplesheet allow for per-sample QC thresholds (e.g., `min_genes`, `max_mito_percentage`) and batch/condition assignments.
- **References**: Users can provide custom gene lists for cell cycle scoring (`--s_genes`, `--g2m_genes`) or mitochondrial filtering (`--mito_genes`).

## How to run
Run the pipeline by providing the samplesheet and an output directory. It is recommended to specify a pipeline version with `-r` and use `-resume` for incremental runs.

```bash
nextflow run nf-core/scdownstream \
  -profile <docker/singularity/conda/institute> \
  --input samplesheet.csv \
  --outdir ./results \
  -r 1.0.0
```

Key parameters include `--integration_methods` (e.g., `scvi,harmony,bbknn`), `--ambient_correction` (e.g., `decontx,soupx,cellbender`), and `--doublet_detection`. For large datasets, use `--memory_scale` to increase resource allocation.

## Outputs
Results are saved to the directory specified by `--outdir`.

- **MultiQC Report**: The primary summary of QC metrics, doublet detection, and integration results.
- **Integrated Data**: Final datasets are provided as `*.h5ad` and `*.rds` files containing embeddings (UMAP) and cluster assignments.
- **CellTypist**: If enabled, cell type annotations are included in the final object metadata.

Refer to the [official output documentation](https://nf-co.re/scdownstream/output) for a complete list of generated files.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)