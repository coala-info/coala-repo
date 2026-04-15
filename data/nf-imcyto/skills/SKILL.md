---
name: imcyto
description: This pipeline performs image segmentation and single-cell expression extraction from Imaging Mass Cytometry data (mcd, ome.tiff, or txt) using user-provided metadata, CellProfiler pipelines, and Ilastik training files to produce cell masks and expression matrices. Use when analyzing high-dimensional imaging data, including IMC, immunofluorescence, or immunohistochemistry, to generate spatially resolved single-cell data while optionally bypassing pixel classification if CellProfiler modules are sufficient.
homepage: https://github.com/nf-core/imcyto
---

# imcyto

## Overview
nf-core/imcyto is a bioinformatics pipeline designed for the automated processing of Imaging Mass Cytometry (IMC) data, though it is flexible enough to support other multiplexed imaging modalities such as immunofluorescence or immunohistochemistry. It addresses the challenge of converting raw multi-channel image acquisition files into segmented single-cell expression profiles by integrating image conversion, preprocessing, and pixel classification.

The pipeline transforms raw image stacks into individual TIFF files based on user-defined metadata and applies specific CellProfiler routines for filtering and segmentation. The final deliverables include single-cell expression data in CSV format and spatial cell masks, enabling detailed downstream biological analysis of the tissue microenvironment.

## Data preparation
The pipeline requires raw image acquisition files and several configuration files to define the analysis logic.

*   **Input Files**: Raw data in `.mcd`, `.ome.tiff`, or `.txt` formats.
*   **Metadata**: A `metadata.csv` file is required to define channel names and match them to the acquisition ROIs.
*   **CellProfiler Pipelines**: Three distinct `.cppipe` files are required for full stack preprocessing, ilastik stack preprocessing, and final segmentation.
*   **Ilastik Project**: An `.ilp` training file is required for pixel classification unless the classification step is skipped.
*   **Plugins**: A directory containing any required CellProfiler plugins.

A typical input directory structure:
```
inputs/
├── sample_01.mcd
└── metadata.csv

plugins/
├── full_stack_preprocessing.cppipe
├── ilastik_stack_preprocessing.cppipe
├── segmentation.cppipe
├── ilastik_training_params.ilp
└── cp_plugins/
```

## How to run
Run the pipeline using `nextflow run`. It is recommended to specify a pipeline version with `-r` and use a container profile for reproducibility.

```bash
nextflow run nf-core/imcyto \
    --input "./inputs/*.mcd" \
    --metadata './inputs/metadata.csv' \
    --full_stack_cppipe './plugins/full_stack_preprocessing.cppipe' \
    --ilastik_stack_cppipe './plugins/ilastik_stack_preprocessing.cppipe' \
    --segmentation_cppipe './plugins/segmentation.cppipe' \
    --ilastik_training_ilp './plugins/ilastik_training_params.ilp' \
    --plugins './plugins/cp_plugins/' \
    --outdir ./results \
    -profile docker
```

Key parameters:
*   `-profile`: Choose `docker`, `singularity`, or an institute profile.
*   `--skip_ilastik`: Bypasses Ilastik pixel classification if CellProfiler modules alone are sufficient for segmentation.
*   `-resume`: Restarts the pipeline from the last successful step if interrupted.

## Outputs
Results are placed in the directory specified by `--outdir`.

*   **Single-cell data**: A `csv` file containing expression data extracted by overlaying the cell mask onto the full image stack.
*   **Image Masks**: Segmentation masks saved as `tiff` files representing individual cells.
*   **Intermediate Images**: ROI-specific TIFF files, pre-processed stacks, and Ilastik probability maps (if not skipped).
*   **Reports**: MultiQC reports and pipeline execution logs.

For a detailed description of the folder structure and file contents, refer to the [official output documentation](https://github.com/nf-core/imcyto/blob/master/docs/output.md).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)