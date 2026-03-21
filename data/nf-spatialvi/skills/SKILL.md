---
name: spatialvi
description: This pipeline processes 10x Genomics Visium spatial transcriptomics data from raw FASTQs using Space Ranger or from pre-processed outputs to perform quality control, normalization, clustering, and differential gene expression testing. Use when analyzing spatial gene expression patterns in tissue samples, including Visium HD data, to identify spatially variable genes and integrate multiple samples into unified SpatialData objects.
homepage: https://github.com/nf-core/spatialvi
---

## Overview
nf-core/spatialvi is designed for the bioinformatics analysis of Visium spatial transcriptomics data from 10x Genomics. It addresses the need for a portable and reproducible workflow that can handle the transition from raw sequencing reads to downstream biological insights like tissue clustering and spatial gene autocorrelation.

The pipeline accepts either raw data for processing with Space Ranger or data that has already been processed by Space Ranger. It produces standardized outputs including quality control reports, normalized expression matrices, and dimensionality reduction results, facilitating the identification of spatially distinct cell populations and gene expression gradients.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This file must contain information about the samples in the experiment, with sample names that do not contain spaces.

A minimal samplesheet structure typically includes:
```csv
sample
sample1
sample2
```

For raw data processing, a Space Ranger reference directory is required (defaulting to GRCh38 if not specified). Users can also provide a Space Ranger probeset CSV file via `--spaceranger_probeset`. If working with Visium HD data, the bin size can be specified using `--hd_bin_size` (allowed values: 2, 8, or 16).

## How to run
The pipeline is executed using Nextflow with the following basic command structure. It is recommended to use `-profile` to specify the container engine (e.g., docker or singularity) and `--outdir` to define the results location.

```bash
nextflow run nf-core/spatialvi \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --outdir <OUTDIR>
```

Key parameters include:
- `-profile test`: Runs the pipeline with a minimal test dataset.
- `--spaceranger_reference`: Path to the Space Ranger reference directory or `tar.gz` file.
- `--merge_sdata`: Boolean to merge per-sample SpatialData objects into one.
- `--integrate_sdata`: Boolean to integrate per-sample SpatialData objects and generate an integration report.
- `-resume`: Use this Nextflow flag to restart a pipeline from the last successful process.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:
- **MultiQC Report**: A summary of quality control metrics across all samples.
- **SpatialData Objects**: Processed data objects containing normalization, clustering, and spatial metadata.
- **Integration Reports**: Generated if `--integrate_sdata` is enabled, detailing the results of sample integration.
- **Analysis Results**: Plots and tables for highly variable genes (HVGs) and spatially variable genes (SVGs).

For a detailed description of all output files, refer to the official [output documentation](https://nf-co.re/spatialvi/output). Example results from full-sized test runs can be viewed on the [nf-core website](https://nf-co.re/spatialvi/results).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
