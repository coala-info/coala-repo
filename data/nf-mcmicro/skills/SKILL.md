---
name: mcmicro
description: This pipeline processes highly-multiplexed imaging data from OME-TIFF files using samplesheets and markersheets to perform image registration, segmentation, and quantification. Use when transforming multi-channel whole-slide images from technologies like Cycif, MIBI, or CODEX into single-cell data and feature arrays.
homepage: https://github.com/nf-core/mcmicro
---

# mcmicro

## Overview
nf-core/mcmicro solves the challenge of converting raw, multi-channel whole-slide microscopy images into structured single-cell datasets. It automates the complex tasks of aligning image cycles, identifying cell boundaries, and measuring signal intensities across many markers for technologies such as Cycif, MIBI, and CODEX.

The pipeline accepts OME-TIFF image tiles and metadata describing the experimental cycles and markers. It produces registered images, segmentation masks, and a cell-by-feature spreadsheet suitable for downstream single-cell analysis and spatial profiling.

## Data preparation
The pipeline requires two primary CSV input files: a samplesheet describing the image files and a markersheet describing the channels.

*   **Samplesheet (`--input_cycle`)**: Defines the sample ID, the cycle number, and the path to the OME-TIFF image tiles.
*   **Markersheet (`--marker_sheet`)**: Defines the channel number, the cycle number (which must match the samplesheet), and the marker name.
*   **Constraints**: Each row in the samplesheet represents a single cycle image, while each row in the markersheet represents a single channel within that cycle.

Example `samplesheet.csv`:
```csv
sample,cycle_number,image_tiles
TEST1,1,path/to/cycle1.ome.tif
TEST1,2,path/to/cycle2.ome.tif
```

Example `markersheet.csv`:
```csv
channel_number,cycle_number,marker_name
1,1,DNA 1
2,1,CD3
1,2,DNA 2
2,2,CD45
```

## How to run
Run the pipeline using the `nextflow run` command, specifying the input sheets and an output directory. Use `-profile` to choose a container engine (e.g., `docker` or `singularity`).

```bash
nextflow run nf-core/mcmicro \
   -r 1.0.0 \
   -profile docker \
   --input_cycle samplesheet.csv \
   --marker_sheet markers.csv \
   --outdir ./results
```

Key parameters include:
*   `--segmentation`: Comma-separated list of modules to run (e.g., `cellpose,mesmer`).
*   `--tma_dearray`: Set to `true` for tissue microarray samples to generate separate outputs for each core.
*   `--illumination`: Specify illumination correction (e.g., `basicpy`).
*   `-resume`: Use this Nextflow flag to restart a pipeline from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

*   **Registered Images**: Aligned multi-channel image files.
*   **Segmentation Masks**: Image files identifying individual cell boundaries.
*   **Cell x Feature Array**: A spreadsheet containing quantified marker intensities for every identified cell.
*   **MultiQC Report**: A summary report of the pipeline run and quality metrics.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/mcmicro/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)