---
name: nf-core-sopa
description: This pipeline processes spatial transcriptomics and multiplex imaging data from platforms like Xenium, MERSCOPE, and Visium HD using a samplesheet to generate single-cell resolution SpatialData objects and visualization files. Use when analyzing high-resolution spatial omics data to perform cell segmentation, transcript aggregation, and tissue-level analysis across various commercial technologies.
homepage: https://github.com/nf-core/sopa
---

# nf-core-sopa

## Overview
nf-core/sopa is a technology-invariant pipeline for spatial omics analysis, built on the SpatialData framework. It addresses the challenge of processing large-scale spatial datasets by providing a standardized workflow for cell segmentation and transcript or channel intensity aggregation.

The pipeline transforms raw instrument outputs into a unified `.zarr` format compatible with the scverse ecosystem. It handles diverse modalities including imaging-based transcriptomics and multiplexed protein imaging, supporting tools like Cellpose, Baysor, and Tangram for segmentation and annotation.

## Data preparation
The pipeline requires a CSV samplesheet specified with `--input`. For most technologies (Xenium, MERSCOPE, CosMX, etc.), the samplesheet defines the path to the directory containing the instrument's output.

Example `samplesheet.csv`:
```csv
sample,data_path
SAMPLE1,/path/to/merscope_directory
SAMPLE2,/path/to/xenium_directory
```

For Visium HD data, the samplesheet requires additional columns such as `fastq_dir`, `cytaimage`, and `image`. If performing cell-type annotation with Tangram, a single-cell RNA-seq reference in `.h5ad` format must be provided via `--sc_reference_path`. Visium HD processing also requires a Space Ranger reference directory or a `.tar.gz` file via `--spaceranger_reference`.

## How to run
The pipeline is executed using technology-specific profiles to load the correct parameters for the input data type.

```bash
nextflow run nf-core/sopa \
   -r [version] \
   -profile <docker/singularity/conda>,<TECHNOLOGY_PROFILE> \
   --input samplesheet.csv \
   --outdir <OUTDIR>
```

Common technology profiles include `xenium`, `merscope`, `cosmx`, and `visium_hd`. Use `-resume` to restart a run from the last successful step. Parameters for specific segmentation methods (e.g., `--use_cellpose`, `--use_baysor`) can be added to the command line or provided in a params file.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

*   **SpatialData Object**: A `.zarr` directory containing the processed spatial data, including images, transcript locations, and cell boundaries.
*   **Visualization**: A `.explorer` directory formatted for use with the Xenium Explorer visualization tool.
*   **Reports**: Standard nf-core reports including a MultiQC summary of the run.

For detailed information on the structure of the SpatialData object and visualization files, refer to the official pipeline output documentation.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)